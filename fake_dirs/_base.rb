def display_dir kind, elem
  if kind == :dir
    "🗂   #{elem.bold}"
  else
    "📄   #{elem}"
  end
end

class FakeDir
  attr_reader :path, :name
  attr_accessor :parent_dir, :password

  def ls args=[]
    puts ""
    if !args.empty? && args.first.strip == "-a"
      @list.sort_by { |l| l[:slug] }.each { |l| puts display_dir(l[:kind], l[:slug])}
    else
      @list.sort_by { |l| l[:slug] }.each { |l| puts display_dir(l[:kind], l[:slug]) unless l[:hidden] == true}
    end
    puts ""
  end

  def cat args
    puts ""
    elem = @list.select { |l| l[:slug] == args.first and l[:kind] == :file }
    if !elem.blank?
      if elem.first[:locked]
        puts "Vous n'avez pas le droit de faire ça."
      else
        puts elem.first[:content]
      end
    else
      puts "Le fichier n'existe pas ou n'est pas un fichier."
    end
    puts ""
  end

  def rm args
    if args.empty?
      puts "Vos devez préciser un fichier."
    else
      elem = @list.select { |l| l[:slug] == args.first.strip}
      (puts "Le fichier n'a pas pu être trouvé" ; return self) if elem.empty?
      (puts "Vous ne pouvez pas supprimer ce fichier." ; return self) if !elem.first[:removable]
      @list.delete_if { |l| l[:slug] == args.first.strip }
      puts "Le fichier a bien été supprimé."
    end
    self
  end

  def cd args
    (puts "Tu dois préciser un dossier après la commande." ; return ) if args.empty?
    arg = args.first.strip
    (puts "Tu ne peux pas aller plus loin." ; return) if $current_dir.path == "home" && arg == ".."
    ($current_dir = $admin_part_dir ; return) if arg == "admin_part"
    elem = @list.select { |l| l[:slug] == arg}.first
    ($current_dir = @parent_dir ; return) if arg == ".."
    if elem and elem[:kind] == :dir
      if elem[:pwd_needed]
        pwd = $prompt.ask("Mots de passe pour #{elem[:target].name} :") do |q|
          q.modify   :downcase
          q.modify   :strip
        end
        (puts "Le mot de passe n'est pas bon" ; return ) if pwd.empty? || pwd != elem[:target].password
        $current_dir = elem[:target]
      else
        $current_dir = elem[:target]
      end
    else
      puts "Le dossier n'a pas été trouvé."
    end
  end

  def chmod args
    if args.empty?
      puts "Vos devez préciser un fichier."
    elsif args.count < 2
      puts "Vous devez préciser le mode et le fichier."
    else
      mode = args.first
      file = args[1]
      (puts "Le mode est incorrect, doit être: '+r'" ; return self) if mode != "+r"
      elem = @list.select { |l| l[:slug] == file and l[:kind] == :file }
      (puts "Le fichier n'a pas pu être trouvé" ; return self) if elem.empty?
      elem.first[:locked] = false
      puts "Les droits du fichier ont bien été modifié."
    end
  end

  def edit args
    elem = @list.select { |l| l[:slug] == args.first and l[:kind] == :file }
    if !elem.blank?
      (puts "Le fichier n'est pas éditable." ; return) if !elem.first[:editable]
      (puts "Vous n'avez pas le droit de faire ça." ; return) if elem.first[:locked]
      filename = args.first.strip
      File.open(filename, "w+") {|f| f.puts elem.first[:content].split("\n").map {|l| l} }
      system "nano -t #{filename}"
      f = File.read(filename)
      elem.first[:content] = f
      File.delete(filename) if File.exist?(filename)
    else
      puts "Le fichier n'existe pas ou n'est pas un fichier."
    end
  end

  def status
    puts "La commande a mal été formulée."
  end

  def destroy_ship
    puts "La commande a mal été formulée."
  end

  def cd_home

  end

  def hint

  end

  def mail args
    puts "La commande a mal été formulée."
  end

  protected
  def validate_path args
    if args.empty?
      puts "Specify dir..."
      return false
    elsif (args.first == ".." and self.path == "home")
      puts "Cannot go furthur"
      return false
    end
    true
  end
end
