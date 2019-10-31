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
    puts "💡  Conseil : Dans le dossier d'un administrateur, tu éditer son mot de passe."
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
    puts "💡  Conseil : C'est dans ce dossier que tu vas pouvoir trouver les mots de passe des\n"
    puts "   des administrateurs pour pouvoir entrer dans leur dossier pour la première fois."
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
      {:name=>"Vrezeok", :slug=>"vrezeok", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Krerrin", :slug=>"krerrin", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Vrils", :slug=>"vrils", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Iktoks", :slug=>"iktoks", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Daldrar", :slug=>"daldrar", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Choldal", :slug=>"choldal", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Ghid", :slug=>"ghid", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Teivil", :slug=>"teivil", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Ruldeth", :slug=>"ruldeth", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Coknals", :slug=>"coknals", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Tenqids", :slug=>"tenqids", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Korkeids", :slug=>"korkeids", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Arkrils", :slug=>"arkrils", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Ulmae", :slug=>"ulmae", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Uval", :slug=>"uval", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Yudda", :slug=>"yudda", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Khoknuts", :slug=>"khoknuts", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Gulxot", :slug=>"gulxot", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true},
      {:name=>"Fodreas", :slug=>"fodreas", :removable=>false, :locked=>false, :kind=>:dir, pwd_needed: true}
    ]
    @list.each { |l| l[:target] = "Admin#{l[:name]}".constantize.new}
    @list.each { |l| l[:target].parent_dir = self }
  end

  def hint
    puts "\n\n"
    puts "💡  Conseil : Ici, tu peux accéder au dossier personnel des administrateurs...\n"
    puts "   ... Si tu as le bon mot de passe."
    puts "\n-----------\n"
  end
end



class SecurityDir < FakeDir
  def initialize
    $admins_dir = AdminsDir.new
    $passwords_dir = PasswordsDir.new
    @path = "Securite"
    @list = [
      {name: "Mots de passe", slug: "mots_de_passe", locked: false, removable: false, kind: :dir, target: $passwords_dir},
      {name: "Admins", slug: "admins", locked: false, removable: false, kind: :dir, target: $admins_dir},
    ]
    @list.each { |l| l[:target].parent_dir = self }
  end

  def hint
    puts "\n\n"
    puts "💡  Conseil : Dans ce dossier, tu peux aller changer le mot de passe des administrateurs\n"
    puts "   pour qu'ils ne puissent plus se connecter à leur session."
    puts "\n-----------\n"
  end

end
