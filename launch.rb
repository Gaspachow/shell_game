#!/usr/bin/env ruby

# TODO: CTRL + C
# TODO: EN | FR
# TODO: only for camelize and constantize

require 'tty-prompt'
require 'tty-cursor'
require 'tty-table'
require 'rubygems'
require 'active_support/all'
require 'artii'
require 'whirly'
require 'paint'
# require "curses"
require 'colorize'
require 'time'
# require 'faker'
require 'securerandom'
# require "i18n"



# Faker::Config.locale = 'fr'
$prompt = TTY::Prompt.new(interrupt: :noop)
# I18n.config.available_locales = :en
# I18n.config.available_locales = :fr

class String
def bold;           "\e[1m#{self}\e[22m" end
def italic;         "\e[3m#{self}\e[23m" end
def underline;      "\e[4m#{self}\e[24m" end
def blink;          "\e[5m#{self}\e[25m" end
def reverse_color;  "\e[7m#{self}\e[27m" end
  def epur
    self.gsub(/\s+/, "")
  end
end

def display_prompt

end

def display_letters str, speed=nil
  speed = speed || (1.0 / 60)
  str.split("").each do |c|
    print c
    sleep(speed)
  end
end

$admins = [
  {:name=>"Chipeur", :slug=>"chipeur", :password=>"90e51a2"},
  {:name=>"Joker", :slug=>"joker", :password=>"ff46339"},
  {:name=>"Arist0t3", :slug=>"arist0t3", :password=>"79e1fdc"},
  {:name=>"Bowser", :slug=>"bowser", :password=>"1fb301d"},
  {:name=>"Megamind", :slug=>"megamind", :password=>"597c2ff"},
  {:name=>"Farqu4d", :slug=>"farqu4d", :password=>"d2ee10e"},
  {:name=>"Mojo", :slug=>"mojo", :password=>"b84142a"},
  {:name=>"Jojo", :slug=>"jojo", :password=>"23fdbd6"},
  {:name=>"Dante", :slug=>"dante", :password=>"12fb8d3"},
  {:name=>"Roger", :slug=>"roger", :password=>"c28a979"},
  {:name=>"Hercule", :slug=>"hercule", :password=>"803d086"},
  {:name=>"Drevil", :slug=>"drevil", :password=>"f869410"},
  {:name=>"Palerme", :slug=>"palerme", :password=>"3833b6a"},
  {:name=>"Rio", :slug=>"rio", :password=>"55c869c"},
  {:name=>"1p0", :slug=>"1p0", :password=>"d9955a1"},
  {:name=>"Unkn0wn", :slug=>"unkn0wn", :password=>"f52cabe"},
  {:name=>"Bogota", :slug=>"bogota", :password=>"989612898961289896128"},
  {:name=>"Kamelot", :slug=>"kamelot", :password=>"c27d749"},
  {:name=>"Forty3", :slug=>"forty3", :password=>"17e128d"}
]

def class_exists?(class_name)
  klass = Module.const_get(class_name)
  return klass.is_a?(Class)
rescue NameError
  return false
end

# require_relative './fake_dirs/base'
Dir["./fake_dirs/*.rb"].each {|file| require_relative file }

require_relative 'populate'

populate_users
populate_planets

$analyses_dir = AnalysesDir.new
$planetes_dir = PlanetesDir.new
$security_dir = SecurityDir.new
$admin_dir = AdminPwdDir.new
$admin_part_dir = AdminPartDir.new

$home_dir = HomeDir.new



# $admin_dir = AdminDir.new()
# $security_dir = SecurityDir.new
# $password_dir = PasswordDir.new()


require_relative 'hints_and_helps'
require_relative 'ascii_arts'


require_relative 'tuto'

class Shell
  def initialize(path="home")
    $current_dir = $home_dir
  end

  def display
	args = nil
	while !args || args.strip != "exit"
	  args = $prompt.ask("$ #{$current_dir.path} >") do |q|
		if args
         # q.modify   :down
		end
      end
      command_parse(args) if args
    end
  end

  def command_parse args
    if args
      cmd = args.strip.split.first
	  cmd_args = args.strip.split.drop(1)
    end
    case cmd
    when 'ls'
      $current_dir.ls(cmd_args)
    when 'cd'
      $current_dir.cd(cmd_args)
    when 'cat'
      $current_dir.cat(cmd_args)
    when 'chmod'
      $current_dir.chmod(cmd_args)
    when 'rm'
      $current_dir.rm(cmd_args)
    when 'edit'
      $current_dir.edit(cmd_args)
    when 'aide'
      system "less aide"
    when 'status'
      $current_dir.status
    when 'admin'
      access_admin
    when 'localiser'
      $current_dir.destroy_ship
    when '4lfr3d'
      $current_dir.hint
    when '4LFR3D'
      $current_dir.hint
    when 'alfred'
      $current_dir.hint
    when 'mail'
      $current_dir.mail(cmd_args)
    when 'progres'
      $home_dir.progres
    else
      puts "La commande a mal été formulée."
    end
  end

  private

  def access_admin
    pwd = nil
    while !pwd
      pwd = $prompt.ask("Mot de passe pour accéder à la gestion du vaisseau :")
      if pwd && pwd != $admin_part_dir.password
        puts "Mauvais mot de passe"
      else
        $current_dir.cd(["admin_part"])
      end
    end
  end
end

Tuto.new
@shell = Shell.new
@shell.display
