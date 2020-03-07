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
	puts "____________________________________________________________________________________________________________________________________________________________________________________\n".colorize(:light_black)
	puts "🤖   4LFR3D:\n".colorize(:light_blue)
    puts "    Dans ce dossier, tu vas pouvoir trouver le mot de passe pour accéder à \n".colorize(:light_black)
    puts "    l'administration de la gestion de l'ordinateur du voleur.\n".colorize(:light_black)
    puts "    Les fichiers sont peut-être cachés...\n\n".colorize(:light_black)
    puts "    N'oublie pas que s'il te manque des droits de lecture, tu peux toujours utiliser ".colorize(:light_black) + "chmod +r".colorize(:light_yellow) + " comme indiqué dans la partie ".colorize(:light_black) + "aide".colorize(:light_yellow) + ".".colorize(:light_black)
	puts "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
  end
end


class AdminPartDir < FakeDir
  attr_accessor :securite_vpn_activee, :encryptage_avance_des_donnees, :niveau_de_securite_anti_triangulation
  def initialize
    @path = "gestion du systeme"
    @password = "chicken-dinner"
    @list = [
      {name: "Liste emails", slug: "admin_emails", kind: :file, removable: false, hidden: false, editable: true, locked: false, content: ""},
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
      puts "\n/!\\ ATTENTION ! L'ETAT DE SÉCURITÉ DU SYSTÈME EST TRÈS CRITIQUE\n".colorize(:red)
    elsif @securite_vpn_activee && @encryptage_avance_des_donnees && @niveau_de_securite_anti_triangulation >= 10
      puts "\nLa sécurité du système est optimale\n".colorize(:green)
    else
      puts "\nAttention, la sécurité du système est compromise\n".colorize(:yellow)
    end
  end

  def destroy_ship
    (puts "Il faut d'abord modifier le mot de passe d'un administrateur."; return) if !mdp_changed?
    (puts "Il faut d'abord envoyer un mail aux associés du voleur et leur donner un rendez-vous surprise avec la police." ; return) if !mails_sent?
    if @localized
      puts "\nLe voleur a déjà été arrêté, félicitations.\n"
    elsif !@securite_vpn_activee && !@encryptage_avance_des_donnees && @niveau_de_securite_anti_triangulation <= 1
      @localized = true
      cursor = TTY::Cursor
      str = "Interception des messages cryptés...\n".colorize(:red)
      display_letters(str) ; sleep(1.5)
      str = "Décryptage des informations réussi !\n".colorize(:green)
      display_letters(str) ; sleep(1)
      str = "Triangulation des coordonées du voleur...\n".colorize(:red)
	  display_letters(str) ; sleep(1.5)
	  str = "Localisation réussie!\n".colorize(:green)
      display_letters(str) ; sleep(1)
      str = "Envoi des coordonnées du voleur et des emails admin à la police...\n".colorize(:cyan)
      display_letters(str)
      cursor.invisible {
        0.upto(5) { print "\r🚨   " ; sleep 0.4 ; print "\r🚔    " ; sleep 0.4 }
      }
      screen_clear
      a = Artii::Base.new(font: 'slant')
      puts a.asciify('MISSION REUSSIE!').colorize(:green)
      puts "\n\n\n"
      $current_dir = $home_dir
      system "cat charly.less"
      $prompt.ask("Félicitations!\nLe voleur de diamant a été arrêté et identifié par la police! Il s'agirait du légendaire \"Charly\", mondialement connu pour ses talents de cache-cache.\nLa police tient à te remercier personnellement et espère pouvoir faire appel à tes talents dans le futur.\nAppuie sur entrée pour continuer ")
    else
      puts "\nLe système de sécurité est trop élevé pour localiser le voleur!\n\n"
    end
  end

  def hint
	puts "\n\n"
	puts "____________________________________________________________________________________________________________________________________________________________________________________\n".colorize(:light_black)
	puts "🤖   4LFR3D:\n".colorize(:light_blue)
    puts "    Dans la partie de gestion du système, tu vas pouvoir trouver les coordonnées du voleur de diamant !\n".colorize(:light_black)
    puts "    Pour cela, il va falloir désactiver ses différents protocoles de sécurité qui t'empêchent de le localiser !\n".colorize(:light_black)
    puts "    En éditant le fichier correspondant, tu vas pouvoir modifier et desactiver ses différentes techniques de protection. \n".colorize(:light_black)
    puts "    Tu vas pouvoir constater l'état de sécurité du système grâce à la commande ".colorize(:light_black) + "status".colorize(:light_yellow) + " et tenter d'envoyer les coordonnées\n".colorize(:light_black)
    puts "    du voleur à la police grâce à la commande ".colorize(:light_black) + "localiser".colorize(:light_yellow) + ".".colorize(:light_black)
	puts "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
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
    elem[:content] += "\n\n---- POUR SORTIR DU FICHIER, APPUYEZ SUR CTRL+X ----"
  end

  def mails_sent?
    $planetes_dir.list.each do |l|
      return false unless l[:target].emailed
    end
    true
  end

  def mdp_changed?
    return true unless $admins[20][:password] == "E2R5"
    false
  end

end
