require_relative '_base'

def populate_admins
  $admins.each do |a|
    klass_name = "Admin#{a[:name].camelize}"
    klass = class_exists?(klass_name)
    return klass if klass
    klass = Class.new(AdminDir) do
      define_method :initialize do
        @password = a[:password]
        @name = a[:name]
        @slug = a[:slug]
        @path = a[:name]
        @list = [
          {name: "Password", slug: "mdp", kind: :file, removable: false, locked: false, hidden: false, content: @password, editable: true}
        ]
      end
    end
    Object.const_set(klass_name, klass)
  end
end

class AdminDir < FakeDir
  def edit args
    elem = @list.select { |l| l[:slug] == args.first and l[:kind] == :file }
    if !elem.blank?
      filename = args.first.strip
      File.open(filename, "w+") {|f| f.puts elem.first[:content].split("\n").map {|l| l} }
      system "nano -t #{filename}"
      f = File.read(filename)
      new_cont = f.split.first
      unless !new_cont || new_cont.empty?
        elem.first[:content] = new_cont
        @password = new_cont
      end
      File.delete(filename) if File.exist?(filename)
    else
      puts "Le fichier n'existe pas ou n'est pas un fichier."
    end
  end

  def hint
	puts "\n\n"
	puts "🤖   4LFR3D:\n".colorize(:light_blue)
    puts "    Maintenant que tu es dans le dossier d'un voleur, édite son mot de passe."
    puts "\n-----------\n"
  end
end



class PasswordsDir < FakeDir
  def initialize
    @path = "Mots de passe"
    @list = []
    set_list
  end

  def hint
	puts "\n\n"
	puts "🤖   4LFR3D:\n".colorize(:light_blue) 
    puts "    C'est dans ce dossier que tu vas pouvoir trouver les mots de passe des\n"
    puts "    voleurs afin d'entrer dans leur dossier."
    puts "\n-----------\n"
  end

  private
  def set_list
    $admins.each do |a|
      @list << {name: "#{a[:name]} mot de passe", slug: ".#{a[:slug]}_mdp", kind: :file, removable: false, locked: false, editable: false, hidden: true, content: a[:password]}
    end
  end
end

class AdminsDir < FakeDir
  def initialize
    @path = "Admins"
    populate_admins
    @list = [
	  {:name=>"Chipeur", :slug=>"chipeur", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Joker", :slug=>"joker", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Arist0t3", :slug=>"arist0t3", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Bowser", :slug=>"bowser", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Megamind", :slug=>"megamind", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Farqu4d", :slug=>"farqu4d", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Mojo", :slug=>"mojo", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Jojo", :slug=>"jojo", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Dante", :slug=>"dante", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Roger", :slug=>"roger", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Hercule", :slug=>"hercule", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Drevil", :slug=>"drevil", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Palerme", :slug=>"palerme", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Rio", :slug=>"rio", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"1p0", :slug=>"1p0", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Unkn0wn", :slug=>"unkn0wn", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Bogota", :slug=>"bogota", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Kamelot", :slug=>"kamelot", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
	  {:name=>"Forty3", :slug=>"forty3", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true}
	]
    @list.each { |l| l[:target] = "Admin#{l[:name]}".constantize.new}
    @list.each { |l| l[:target].parent_dir = self }
  end

  def hint
	puts "\n\n"
	puts "🤖   4LFR3D:\n".colorize(:light_blue) 
    puts "    Ici, tu peux accéder au dossier personnel des voleurs...\n"
    puts "    ... si tu as le bon mot de passe."
    puts "\n-----------\n"
  end
end



class SecurityDir < FakeDir
  def initialize
    $admins_dir = AdminsDir.new
    $passwords_dir = PasswordsDir.new
    @path = "Securite"
    @list = [
      {name: "Mot de passe", slug: "mot_de_passe", locked: false, removable: false, kind: :dir, target: $passwords_dir},
      {name: "Admins", slug: "admins", locked: false, removable: false, kind: :dir, target: $admins_dir},
    ]
    @list.each { |l| l[:target].parent_dir = self }
  end

  def hint
	puts "\n\n"
	puts "🤖   4LFR3D:\n".colorize(:light_blue)
    puts "    Dans ce dossier, tu peux aller changer le mot de passe des voleurs\n"
    puts "    pour qu'ils ne puissent plus se connecter à leur session."
    puts "\n-----------\n"
  end

end
