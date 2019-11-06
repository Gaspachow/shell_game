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
    puts "    Tape les commandes".colorize(light_black) + "ls".colorize(light_yellow) + "et".colorize(light_black) + "cd".colorize(light_yellow) + "pour continuer.".colorize(:light_black)
    puts "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)
  end
end
