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
  {:name=>"Vrezeok", :slug=>"vrezeok", :password=>"90e51a2"},
  {:name=>"Krerrin", :slug=>"krerrin", :password=>"ff46339"},
  {:name=>"Vrils", :slug=>"vrils", :password=>"79e1fdc"},
  {:name=>"Iktoks", :slug=>"iktoks", :password=>"1fb301d"},
  {:name=>"Daldrar", :slug=>"daldrar", :password=>"597c2ff"},
  {:name=>"Choldal", :slug=>"choldal", :password=>"d2ee10e"},
  {:name=>"Ghid", :slug=>"ghid", :password=>"b84142a"},
  {:name=>"Teivil", :slug=>"teivil", :password=>"23fdbd6"},
  {:name=>"Ruldeth", :slug=>"ruldeth", :password=>"12fb8d3"},
  {:name=>"Coknals", :slug=>"coknals", :password=>"c28a979"},
  {:name=>"Tenqids", :slug=>"tenqids", :password=>"803d086"},
  {:name=>"Korkeids", :slug=>"korkeids", :password=>"f869410"},
  {:name=>"Arkrils", :slug=>"arkrils", :password=>"3833b6a"},
  {:name=>"Ulmae", :slug=>"ulmae", :password=>"55c869c"},
  {:name=>"Uval", :slug=>"uval", :password=>"d9955a1"},
  {:name=>"Yudda", :slug=>"yudda", :password=>"f52cabe"},
  {:name=>"Khoknuts", :slug=>"khoknuts", :password=>"9896128"},
  {:name=>"Gulxot", :slug=>"gulxot", :password=>"c27d749"},
  {:name=>"Fodreas", :slug=>"fodreas", :password=>"17e128d"}
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
          q.modify   :downcase
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
    when 'destruction'
      $current_dir.destroy_ship
    when 'hint'
      $current_dir.hint
    when 'mail'
      $current_dir.mail(cmd_args)
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
