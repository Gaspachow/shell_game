# -*- encoding: utf-8 -*-
# stub: artii 2.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "artii".freeze
  s.version = "2.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mike Tierney".freeze]
  s.date = "2016-10-19"
  s.description = "A Figlet-based ASCII art generator, useful for comand-line based ASCII Art Generation.".freeze
  s.email = "mike@panpainter.com".freeze
  s.executables = ["artii".freeze]
  s.extra_rdoc_files = ["README.rdoc".freeze]
  s.files = ["README.rdoc".freeze, "bin/artii".freeze]
  s.homepage = "http://github.com/miketierney/artii".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2.3".freeze
  s.summary = "A little Figlet-based ASCII art generator.".freeze

  s.installed_by_version = "2.5.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.1.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7.3"])
      s.add_development_dependency(%q<jeweler>.freeze, ["~> 2.0.1"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.9.0"])
    else
      s.add_dependency(%q<rspec>.freeze, ["~> 3.1.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7.3"])
      s.add_dependency(%q<jeweler>.freeze, ["~> 2.0.1"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.9.0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["~> 3.1.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7.3"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 2.0.1"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.9.0"])
  end
end
