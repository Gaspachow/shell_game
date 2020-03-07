require_relative '_base'

class HomeDir < FakeDir
  def initialize
    @path = "home"
    @list = [
      {name: 'Associés', slug: 'associes', removable: false, locked: false, kind: :dir, target: $planetes_dir},
      {name: 'Analyses', slug: 'analyses', removable: false, locked: false, kind: :dir, target: $analyses_dir},
      {name: 'Securité', slug: 'securite', removable: false, locked: false, kind: :dir, target: $security_dir},
      {name: 'Admin', slug: 'admin', removable: false, locked: false, kind: :dir, target: $admin_dir}
    ]
    @list.each { |l| l[:target].parent_dir = self if l[:target]}
    $admin_part_dir.parent_dir = self
  end

  def hint
	puts "\n\n"
	puts "____________________________________________________________________________________________________________________________________________________________________________________\n".colorize(:light_black)
	puts "🤖   4LFR3D:\n".colorize(:light_blue)
    puts "    Dans ce dossier, tu vas pouvoir te balader dans le système informatique du voleur.\n".colorize(:light_black)
    puts "    Tape les commandes ".colorize(:light_black) + "ls".colorize(:light_yellow) + " et ".colorize(:light_black) + "cd".colorize(:light_yellow) + " pour continuer.".colorize(:light_black)
    puts "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
  end

  def progress
    puts "\n🤖 4LFR3D:".colorize(:light_blue)
    if !mdp_changed?
      puts "Mot de passe d'un administrateur changé : " + " non".colorize(:red)
    else
      puts "Mot de passe d'un administrateur changé : " + " oui".colorize(:green)
    end
    if !mails_sent?
      puts "Mails envoyés aux collaborateurs :" + " non".colorize(:red)
    else
      puts "Mails envoyés aux collaborateurs :" + " oui".colorize(:green)
    end
    if !$admin_part_dir.securite_vpn_activee && !$admin_part_dir.encryptage_avance_des_donnees && $admin_part_dir.niveau_de_securite_anti_triangulation <= 1
      puts "Sécurité du système affaiblie :" + " oui".colorize(:green)
    else
      puts "Sécurité du système affaiblie :" + " non".colorize(:red)
    end
    puts "\n"
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
