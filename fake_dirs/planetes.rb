require_relative '_base'
class PlanetesDir < FakeDir
  attr_reader :list
  def initialize
    @path = "planetes"
    @list = [
      {name: "Terre", slug: "terre", removable: false, locked: false, kind: :dir, target: "PlanetTerre".constantize.new},
      {name: "Mars", slug: "mars", removable: false, locked: false, kind: :dir, target: "PlanetMars".constantize.new }
    ]
    set_parent_dir
  end

  def hint
    puts "\n\n"
    puts "💡  Conseil : Dans ce dossier, tu trouveras les planetes qui sont analysées par le vaisseau."
    puts "\n-----------\n"

  end

  private
  def set_parent_dir
    @list.each  { |l| l[:target].parent_dir = self }
  end
end
