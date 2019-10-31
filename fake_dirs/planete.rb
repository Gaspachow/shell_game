require_relative '_base'

class PlanetDir < FakeDir
  attr_accessor :emailed, :email
  def initialize
    @emailed = false
  end

  def mail args
    (puts "Tu dois préciser un email." ; return ) if args.empty?
    arg = args.first.strip
    elem = @list.select { |l| l[:content] == arg}.first
    if elem
      puts "-- Taper ici l'email. Pour terminer, tapez : finish"
      email = nil
      content = []
      while !email || email != "finish"
        email = $prompt.ask("Contenu de l'email :")
        content << email unless email.blank?
      end
      puts "\nL'email suivant a bien été envoyé à #{self.email} :"
      puts content
      @emailed = true if !content.nil? && !content.empty?
    else
      puts "Ce n'est pas le bon email."
    end

  end

  def hint
    puts "\n\n"
    puts "💡  Conseil : Ici, tu trouveras l'email des aliens chargés d'analyser les planètes.\n"
    puts "    Avant de détruire le vaisseau, il serait judicieux de leur envoyer un mail afin qu'ils\n"
    puts "    retournent sur le vaisseau principal pendant la catastrophe !"
    puts "\n-----------\n"

  end
end

def populate_planets
  planets = [{name: "Terre", slug: "terre", removable: false, locked: false, kind: :dir},
  {name: "Mars", slug: "mars", removable: false, locked: false, kind: :dir }
  ]

  planets.each do |pl|
    klass_name = "Planet#{pl[:name].camelize}"
    klass = class_exists?(klass_name)
    slug = pl[:name] == "Terre" ? "slikj" : "kogh"
    return klass if klass
    t1 = Time.now
    t2 = Time.parse("2019-11-16 14:40:34")
    klass = Class.new(PlanetDir) do
      # class_variable_set(:@@age, user[:age])
      define_method :initialize do
        @slug = pl[:name].downcase
        @path = pl[:name]
        @email = "#{slug}@xz120f.com"
        @list = [
          {name: "Email", slug: "email", kind: :file, removable: false, locked: false, editable: false, content: "#{slug}@xz120f.com"}
        ]
      end
    end
    Object.const_set(klass_name, klass)
  end
end
