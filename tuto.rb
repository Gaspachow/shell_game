# include Curses

def screen_clear
  system "clear"
end

def nano filename
  system "nano -t #{filename}"
end

class Tuto
  def initialize
    @hint = Hint.new
    @help = HelpCommands.new
    @auth_logins = ["Chipeur", "Joker", "Arist0t3", "Bowser", "Megamind", "Farqu4d", "Mojo", "Jojo", "Dante", "Roger", "Hercule", "Drevil", "Palerme", "Rio", "1p0", "Unkn0wn", "Bogota", "Kamelot", "Nicolas", "Root", "---------ECRIT_TON_PRENOM_TOUT_EN_HAUT_PUIS_APPUIE_SUR_CTRL+X_POUR_SAUVEGARDER--------"]
    File.open("autorisations", "w+") {|f| f.puts @auth_logins.map {|l| l} }
    screen_clear
    first_part
    second_part
    last_part
  end

  def first_part
    cursor = TTY::Cursor
    ascii_slant = Artii::Base.new(font: 'slant')
    a = Artii::Base.new
    puts a.asciify('- 4LFR3D -').colorize(:light_blue)
    introduction_str = "Bienvenue détective,\n\nJe suis 4LFR3D, l'intelligence artificielle d'assistance aux détectives privés.\n\n"
    introduction_str += "Votre mission est de localiser un légendaire voleur de diamant et ses deux complices grâce à vos talents de déduction, mais aussi informatiques.\n\n"
    introduction_str += "En effet, lors de son dernier casse à la place Vendôme, ce dernier a laissé tomber son sac dans lequel se trouvait son ordinateur portable.\n\n"
    introduction_str += "Bien évidemment, ce voleur de légende sait couvrir ses traces, et accéder à ses données ne sera pas chose aisée!\n\n"
    introduction_str += "\nVos instructions sont les suivantes:\n\n"
    introduction_str += " - Dans un premier temps, vous devrez vous connecter à son ordinateur et vérifer qu'aucunes de vos données n'ont été collectées.\n\n"
    introduction_str += " - Une fois cela fait, il faudra changer le mot de passe d'un des admins pour s'échauffer.\n\n"
    introduction_str += " - Ensuite, il faudra donner un faux rendez-vous à ses deux complices dans un lieu où la police les attendra en leur envoyant un email.\n\n"
    introduction_str += " - Enfin, il faudra rentrer dans la gestion de système de l'ordinateur pour désactiver les différents systèmes de sécurité et localiser le voleur!\n\n"
    introduction_str += "\n\nAllez! Il est temps de se lancer.\n"
    introduction_str += "Quel identifiant souhaites-tu essayer pour te connecter à son ordinateur?"
    display_letters(introduction_str, 1.0 / 75)
    answer = nil
    puts "\n\n"
    while !answer
      answer = $prompt.ask("Identifiant :") do |q|
        if answer
          q.modify   :downcase
        end
      end
    end
    Whirly.start spinner: "random_dots" do
      sleep 2
    end
    cursor.invisible {
      0.upto(5) { print "\r☠️   " ; sleep 0.4 ; print "\r     " ; sleep 0.4 }
    }
    screen_clear
    sleep 0.5
    puts ascii_slant.asciify('ACCES INTERDIT !').colorize(:red)
    puts @hint.infiltrate_computer
    puts @help.edit

    tuto_prompt("", "edit autorisations")

    user_name = (add_self_name.first.split(' ').first.downcase).tr('.,()\/;:"\'-_=+*&|!@%^()', '')
    new_user_class({ name: user_name, blood: "$" + rand(15000..35000).to_s, code_cb: ((0...8).map { (65 + rand(26)) }.join), age: rand(11..16), :address=>"5399 Passage Mouffetard - 49560 - Toulouse", :phone=>"06 38 06 96 61"})
    $current_user = "User#{user_name.camelize}".constantize.new

    screen_clear
    sleep 0.5
    puts ascii_slant.asciify('ACCES INTERDIT !').colorize(:red)
    puts @hint.rewrite_firstname($current_user.name)

    answer = nil

    while !answer
      answer = $prompt.ask("Identifiant :") do |q|
        if answer
          q.modify :downcase
        end
      end
      if answer && answer.downcase.tr('.,()\/;:"\'-_=+*&|!@%^()', '') == $current_user.name.downcase
        break
      elsif answer && answer == "exit"
        exit
      end
      answer = nil
    end

    Whirly.start spinner: "random_dots" do
      sleep 2
    end
    screen_clear
    sleep 0.5

    # system "less alan_turing.less"
    puts ascii_slant.asciify('ACCES AUTORISE !').colorize(:green)
  end

  def second_part

    $analyses_dir.list << {name: $current_user.name, slug: $current_user.name.downcase, removable: false, locked: false, kind: :dir, target: $current_user} unless $analyses_dir.list.any? {|h| h[:slug] == $current_user.name.downcase}
    $current_dir = $current_user

    puts @hint.after_authorized
    puts @help.after_authorized

    tuto_prompt("", "ls")
    $analyses_dir.ls
    puts @hint.after_ls
    puts @help.after_ls


    tuto_prompt("", "cd #{$current_user.slug}")

    puts @hint.after_cd

    tuto_prompt($current_user.name, 'ls')

    $current_user.ls

    puts @hint.after_enter_user
    puts @help.after_enter_user("prochaine-analyse")

    tuto_prompt($current_user.name, 'cat prochaine-analyse')

    $current_user.cat(["prochaine-analyse"])

    puts @hint.after_cat
    puts @help.after_cat("prochaine-analyse")

    tuto_prompt($current_user.name, 'rm prochaine-analyse')

    $current_user.rm(["prochaine-analyse"])


    puts @hint.after_rm
    puts @help.after_enter_user('derniere-analyse')

    tuto_prompt($current_user.name, 'cat derniere-analyse', true)

    $current_user.cat(["derniere-analyse"])

    puts @hint.after_cat_user
    puts @help.after_cat("derniere-analyse")

    tuto_prompt($current_user.name, 'rm derniere-analyse', true)

    $current_user.rm(["derniere-analyse"])

    puts @hint.after_failed_rm
    puts @help.edit("derniere-analyse")

    tuto_prompt($current_user.name, 'edit derniere-analyse', true)
    $current_user.edit(["derniere-analyse"])
    # system "less ada_lovelace.less"

  end

  def last_part
    screen_clear
    puts @hint.after_edit_analyse
    puts @help.after_edit_analyse
    $prompt.ask("Appuie sur entrée pour continuer...")
  end

  private

  def add_self_name
    nano "autorisations"
    file_logins = []
    f = File.open("autorisations", "r").read
    f.each_line do |l|
      name = l.gsub(/\s+/, "")
      file_logins << name unless name.empty?
    end
    diff = file_logins.sort - @auth_logins.sort
    if @auth_logins.count >= file_logins.count || diff.count > 1
      File.open("autorisations", "w+") {|fi| fi.puts @auth_logins.map {|l| l} }
      screen_clear
      puts @hint.invalid_login
      $prompt.ask("Appuie sur entrée pour continuer...")
      diff = add_self_name
    end
    File.delete("autorisations") if File.exist?("autorisations")
    return diff
  end

  def tuto_prompt path, answer, allow_ls = false
    cmd = nil
    i = 0
    while !cmd || cmd.strip != answer
      hint = ""
      cmd = $prompt.ask("$ #{path} >") do |q|
        if cmd
          q.modify   :downcase
          q.modify   :strip
        end
      end
      if cmd && cmd == "ls" && allow_ls == true
        $current_dir.ls
      else
        exit if cmd && cmd == "exit"
        hint = "(Essaye " + "#{answer}".colorize(:light_yellow) + ")" if i >= 2
		if !cmd || cmd.strip != answer
		  puts "🤖   4LFR3D : ".colorize(:light_blue) + "Ce n'est pas la bonne commande. #{hint}"
          cmd = nil
        end
      end
      i += 1
    end

  end
end
