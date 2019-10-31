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
    @auth_logins = ["Vrezeok", "Krerrin", "Vrils", "Iktoks", "Daldrar", "Choldal", "Ghid", "Teivil", "Ruldeth", "Coknals", "Tenqids", "Korkeids", "Arkrils", "Ulmae", "Uval", "Yudda", "Khoknuts", "Gulxot", "Fodreas"]
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
    puts ascii_spaceship
    puts a.asciify('XZ120F')
    introduction_str = "Bienvenue sur le système informatique du XZ120F, le plus grand vaisseau alien.\n"
    introduction_str += "Veuillez vous identifier en inscrivant votre prénom."
    display_letters(introduction_str)
    answer = nil
    puts "\n\n"
    while !answer
      answer = $prompt.ask("Prénom :") do |q|
        if answer
          q.modify   :downcase
        end
      end
    end
    Whirly.start spinner: "random_dots" do
      sleep 4
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

    user_name = add_self_name.first.split(' ').first
    new_user_class({ name: user_name, blood: "O+", code_cb: ((0...8).map { (65 + rand(26)) }.join), age: rand(11..16), :address=>"5399 Passage Mouffetard - 49560 - Toulouse", :phone=>"06 38 06 96 61"})
    $current_user = "User#{user_name.camelize}".constantize.new

    screen_clear
    sleep 0.5
    puts ascii_slant.asciify('ACCES INTERDIT !').colorize(:red)
    puts @hint.rewrite_firstname($current_user.name)

    answer = nil

    while !answer
      answer = $prompt.ask("Prénom :") do |q|
        if answer
          q.modify :downcase
        end
      end
      if answer && answer.downcase == $current_user.name.downcase
        break
      elsif answer && answer == "exit"
        exit
      end
      answer = nil
    end

    Whirly.start spinner: "random_dots" do
      sleep 4
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
        hint = "(💡  #{answer})".colorize(:light_yellow) if i >= 2
        if !cmd || cmd.strip != answer
          puts "Ce n'est pas la bonne commande. #{hint}"
          cmd = nil
        end
      end
      i += 1
    end

  end
end
