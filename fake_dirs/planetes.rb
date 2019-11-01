require_relative '_base'
class PlanetesDir < FakeDir
  attr_reader :list
  def initialize
    @path = "asssocies"
    @list = [
      {name: "Arsene", slug: "arsene", removable: false, locked: false, kind: :dir, target: "PlanetArsene".constantize.new},
      {name: "Tonton", slug: "tonton", removable: false, locked: false, kind: :dir, target: "PlanetTonton".constantize.new }
    ]
    set_parent_dir
  end

  def hint
    puts "\n\n"
    puts "💡  Conseil : Dans ce dossier, tu trouveras les deux associés du voleur de diamant."
    puts "\n-----------\n"

  end

  private
  def set_parent_dir
    @list.each  { |l| l[:target].parent_dir = self }
  end
end
