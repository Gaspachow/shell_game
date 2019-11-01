require_relative '_base'

class AdminPwdDir < FakeDir
  def initialize
    @path = "admin"
    @list = [
      {name: "Mot de passe", slug: ".mdp", locked: true, removable: false, hidden: true, editable: false, kind: :file, content: "chicken-dinner"}
    ]
  end

  def hint
    puts "\n\n"
    puts "💡  Conseil : Dans ce dossier, tu vas pouvoir trouver le mot de passe pour accéder à \n"
    puts "   l'administration de la gestion de l'ordinateur du voleur. Les fichiers sont peut-être cachés..."
    puts "\n-----------\n"
  end
end


class AdminPartDir < FakeDir
  attr_accessor :securite_vpn_activee, :encryptage_avance_des_donnees, :niveau_de_securite_anti_triangulation
  def initialize
    @path = "Gestion du systeme"
    @password = "chicken-dinner"
    @list = [
      {name: "Liste emails", slug: "clients_emails", kind: :file, removable: false, hidden: false, editable: true, locked: false, content: ""},
      {name: "anti_tracker", slug: "anti_tracker", kind: :file, removable: false, hidden: false, locked: false, content: "", editable: true}
    ]
    set_emails_content(@list.first)
    set_status_content(@list.last)
    @securite_vpn_activee = true
    @encryptage_avance_des_donnees = true
    @niveau_de_securite_anti_triangulation = 10
    @localized = false
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
      if filename == "anti_tracker"
        f.each_line do |l|
          next if l.blank?
          var = l.split('=').first.strip.parameterize.underscore
          value = l.split('=').last.strip
          if var == "niveau_de_securite_anti_triangulation"
            value = value.to_i
          elsif var == "encryptage_avance_des_donnees" || var == "securite_vpn_activee"
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

    puts "Sécurité VPN activée : #{@securite_vpn_activee}"
    puts "Encryptage avancé des données : #{@encryptage_avance_des_donnees}"
    puts "Niveau de sécurité Anti-Triangulation : #{@niveau_de_securite_anti_triangulation}"
    if !@securite_vpn_activee && !@encryptage_avance_des_donnees && @niveau_de_securite_anti_triangulation <= 1
      puts "\n/!\\ ATTENTION ! L'ETAT DU VAISSEAU EST TRÈS CRITIQUE\n".colorize(:red)
    elsif @securite_vpn_activee && @encryptage_avance_des_donnees && @niveau_de_securite_anti_triangulation >= 10
      puts "\nLe vaisseau est en bon état\n".colorize(:green)
    else
      puts "\nAttention, le vaisseau n'est pas en bon état\n".colorize(:yellow)
    end
  end

  def destroy_ship
    (puts "Il faut d'abord envoyer un mail aux analyseurs des planètes pour les faire revenir sur le vaisseau." ; return) if !mails_sent?
    if @localized
      puts "\nLe vaisseau a déjà été détruit.\n"
    elsif !@securite_vpn_activee && !@encryptage_avance_des_donnees && @niveau_de_securite_anti_triangulation <= 1
      @localized = true
      cursor = TTY::Cursor
      str = "Interception des messages cryptés...\n".colorize(:red)
      display_letters(str) ; sleep(1.5)
      str = "Décryptage des informations réussi !\n".colorize(:green)
      display_letters(str) ; sleep(1)
      str = "Triangulation des coordonées des voleurs...\n".colorize(:red)
	  display_letters(str) ; sleep(1.5)
	  str = "Localisation réussie!\n".colorize(:green)
      display_letters(str) ; sleep(1)
      str = "Envoi des coordonnées à la police...\n".colorize(:cyan)
      display_letters(str)
      cursor.invisible {
        0.upto(5) { print "\r🚨   " ; sleep 0.4 ; print "\r🚔    " ; sleep 0.4 }
      }
      screen_clear
      a = Artii::Base.new(font: 'slant')
      puts a.asciify('VOLEURS ATTRAPPES!').colorize(:green)
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
      elem[:content] += "#{a[:slug]}@evilcorp.com\n"
    end
  end

  def set_status_content elem
    elem[:content] += "Sécurité VPN activée = Oui\n"
    elem[:content] += "Encryptage avancé des données = Oui\n"
    elem[:content] += "Niveau de sécurité Anti-Triangulation = 10\n"
  end

  def mails_sent?
    $planetes_dir.list.each do |l|
      return false unless l[:target].emailed
    end
    true
  end

end
