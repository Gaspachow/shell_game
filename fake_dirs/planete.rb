require_relative '_base'

class PlanetDir < FakeDir
  attr_accessor :emailed, :email
  def initialize
    @emailed = true # TO CHANGE AGAIN CESAR
  end

  def mail args
    (puts "Tu dois préciser un email." ; return ) if args.empty?
    arg = args.first.strip
    elem = @list.select { |l| l[:content] == arg}.first
    if elem
      puts "-- Taper ici l'email. Pour terminer, tapez : #{"finish".colorize(:green)}"
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
	puts "____________________________________________________________________________________________________________________________________________________________________________________\n".colorize(:light_black)
	puts "🤖   4LFR3D:\n".colorize(:light_blue) 
    puts "    Ici, tu trouveras l'email d'un des deux associés du voleur de diamant.\n".colorize(:light_black)
    puts "    Avant de localiser le voleur, il serait judicieux de chacun leur envoyer un mail afin de leur\n".colorize(:light_black)
    puts "    donner rendez-vous dans un lieu où la police les attendra !".colorize(:light_black)
	puts "____________________________________________________________________________________________________________________________________________________________________________________\n\n".colorize(:light_black)

  end
end

def populate_planets
  planets = [{name: "arsene", slug: "arsene", removable: false, locked: false, kind: :dir},
 			{name: "tonton", slug: "tonton", removable: false, locked: false, kind: :dir }
  ]

  planets.each do |pl|
    klass_name = "Planet#{pl[:name].camelize}"
    klass = class_exists?(klass_name)
    slug = pl[:name] == "arsene" ? "lupin" : "t0nt0n"
    return klass if klass
    t1 = Time.now
    t2 = Time.parse("2019-11-16 14:40:34")
    klass = Class.new(PlanetDir) do
      # class_variable_set(:@@age, user[:age])
      define_method :initialize do
        @slug = pl[:name].downcase
        @path = pl[:name]
        @email = "#{slug}@evilcorp.com"
        @list = [
          {name: "Email", slug: "email", kind: :file, removable: false, locked: false, editable: false, content: "#{slug}@evilcorp.com"}
        ]
      end
    end
    Object.const_set(klass_name, klass)
  end
end
