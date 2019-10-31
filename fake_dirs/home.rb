require_relative '_base'

class HomeDir < FakeDir
  def initialize
    @path = "home"
    @list = [
      {name: 'Planètes', slug: 'planetes', removable: false, locked: false, kind: :dir, target: $planetes_dir},
      {name: 'Analyses', slug: 'analyses', removable: false, locked: false, kind: :dir, target: $analyses_dir},
      {name: 'Securité', slug: 'securite', removable: false, locked: false, kind: :dir, target: $security_dir},
      {name: 'Admin', slug: 'admin', removable: false, locked: false, kind: :dir, target: $admin_dir}
    ]
    @list.each { |l| l[:target].parent_dir = self if l[:target]}
    $admin_part_dir.parent_dir = self
  end

  def hint
    puts "\n\n"
    puts "💡  Conseil : Dans ce dossier, tu vas pouvoir te balader dans le système informatique du vaisseau.\n"
    puts "   Tape les commandes ls et cd pour continuer."
    puts "\n-----------\n"
  end
end
