require_relative '_base'

class AdminPwdDir < FakeDir
  def initialize
    @path = "admin"
    @list = [
      {name: "Mot de passe", slug: ".mdp", locked: true, removable: false, hidden: true, editable: false, kind: :file, content: "bc1a8fb"}
    ]
  end

  def hint
    puts "\n\n"
    puts "💡  Conseil : Dans ce dossier, tu vas pouvoir trouver le mot de passe pour accéder à \n"
    puts "   l'administration de la gestion du vaisseau. Les fichiers sont peut-être cachés..."
    puts "\n-----------\n"
  end
end


class AdminPartDir < FakeDir
  attr_accessor :temperature_des_reacteurs, :systeme_de_refroidissement_enclanche, :aerations_ouvertes
  def initialize
    @path = "Gestion du vaisseau"
    @password = "bc1a8fb"
    @list = [
      {name: "Liste emails", slug: "liste_emails", kind: :file, removable: false, hidden: false, editable: true, locked: false, content: ""},
      {name: "Statut des composants", slug: "statut_composants", kind: :file, removable: false, hidden: false, locked: false, content: "", editable: true}
    ]
    set_emails_content(@list.first)
    set_status_content(@list.last)
    @temperature_des_reacteurs = 90
    @systeme_de_refroidissement_enclanche = true
    @aerations_ouvertes = 10
    @destroyed = false
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
      if filename == "statut_composants"
        f.each_line do |l|
          next if l.blank?
          var = l.split('=').first.strip.parameterize.underscore
          value = l.split('=').last.strip
          if var == "temperature_des_reacteurs" || var == "aerations_ouvertes"
            value = value.to_i
          elsif var == "systeme_de_refroidissement_enclanche"
            if value.downcase == "non" || value.downcase == "false"
              value = false
            else
              value = true
            end
          end
          self.instance_variable_set("@#{var}", value)
        end
      end
      elem.first[:content] = f
      File.delete(filename) if File.exist?(filename)
    else
      puts "Le fichier n'existe pas ou n'est pas un fichier."
    end
  end

  def status

    puts "Température des réacteurs : #{@temperature_des_reacteurs}"
    puts "Système de refroidissement enclanché : #{@systeme_de_refroidissement_enclanche}"
    puts "Nombre d'aérations ouvertes : #{@aerations_ouvertes}"
    if @temperature_des_reacteurs >= 400 && !@systeme_de_refroidissement_enclanche && @aerations_ouvertes <= 1
      puts "\n/!\\ ATTENTION ! L'ETAT DU VAISSEAU EST TRÈS CRITIQUE\n".colorize(:red)
    elsif @temperature_des_reacteurs <= 100 && @systeme_de_refroidissement_enclanche && @aerations_ouvertes >= 10
      puts "\nLe vaisseau est en bon état\n".colorize(:green)
    else
      puts "\nAttention, le vaisseau n'est pas en bon état\n".colorize(:yellow)
    end
  end

  def destroy_ship
    (puts "Il faut d'abord envoyer un mail aux analyseurs des planètes pour les faire revenir sur le vaisseau." ; return) if !mails_sent?
    if @destroyed
      puts "\nLe vaisseau a déjà été détruit.\n"
    elsif @temperature_des_reacteurs >= 400 && !@systeme_de_refroidissement_enclanche && @aerations_ouvertes <= 1
      @destroyed = true
      cursor = TTY::Cursor
      str = "La température des réacteurs est beaucoup trop haute !\n".colorize(:red)
      display_letters(str) ; sleep(1)
      str = "Tentative de refroidissement des réacteurs...\n"
      display_letters(str) ; sleep(1.5)
      str = "Le système de refroidissement a été désactivé !\n".colorize(:red)
      display_letters(str) ; sleep(1)
      str = "Tentative de refroidissement par les aérations...\n"
      display_letters(str) ; sleep(1.5)
      str = "Il n'y a pas assez d'aérations ouvertes !\n".colorize(:red)
      display_letters(str)
      cursor.invisible {
        0.upto(5) { print "\r⚠️   " ; sleep 0.4 ; print "\r     " ; sleep 0.4 }
      }
      screen_clear
      a = Artii::Base.new(font: 'slant')
      puts a.asciify('XZ120F DETRUIT !').colorize(:red)
      puts "\n\n\n"
      $current_dir = $home_dir
      $prompt.ask("Appuie sur entrée pour continuer ")
    else
      puts "\nLe vaisseau est en trop bon état pour être détruit !\n\n"
    end
  end

  def hint
    puts "\n\n"
    puts "💡  Conseil : Dans la partie de gestion du vaisseau, tu vas pouvoir faire en sorte de le détruire !\n"
    puts "   Pour cela, il va falloir faire en sorte que les composants du vaisseau soient en mauvais état !\n"
    puts "   En éditant le fichier correspondant en augmentant la température au max, en mettant le moins d'aération \n"
    puts "   possible et en annulant le système de refroidissement, tu vas pouvoir constater l'état du vaisseau avec la \n"
    puts "   commande `status` et tenter de le détruire avec la commande `destruction`"
    puts "\n-----------\n"
  end

  private

  def set_emails_content elem
    $admins.each do |a|
      elem[:content] += "#{a[:slug]}@xz120f.com\n"
    end
  end

  def set_status_content elem
    elem[:content] += "Température des réacteurs = 90\n"
    elem[:content] += "Système de refroidissement enclanché = Oui\n"
    elem[:content] += "Aérations ouvertes = 10\n"
  end

  def mails_sent?
    $planetes_dir.list.each do |l|
      return false unless l[:target].emailed
    end
    true
  end

end
