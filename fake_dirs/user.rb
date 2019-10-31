require_relative '_base'

class User < FakeDir
  attr_reader :name, :slug, :path
  attr_accessor :age, :blood, :card, :list, :parent_dir

  def initialize
    @path = @name.downcase
    @parent_dir = $analyses_dir
  end

  def edit args
    elem = @list.select { |l| l[:slug] == args.first and l[:kind] == :file }
    if !elem.blank?
      if elem.first[:locked]
        puts "Vous n'avez pas le droit de faire ça."
      else
        filename = args.first.strip
        File.open(filename, "w+") {|f| f.puts elem.first[:content].split("\n").map {|l| l} }
        system "nano -t #{filename}"
        f = File.read(filename)
        elem.first[:content] = f
        File.delete(filename) if File.exist?(filename)
      end
    else
      puts "Le fichier n'existe pas ou n'est pas un fichier."
    end
    self
  end

end
