# -*- encoding: utf-8 -*-
# stub: tty-prompt 0.10.1 ruby lib

Gem::Specification.new do |s|
  s.name = "tty-prompt".freeze
  s.version = "0.10.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Murach".freeze]
  s.date = "2017-02-06"
  s.description = "A beautiful and powerful interactive command line prompt with a robust API for getting and validating complex inputs.".freeze
  s.email = ["".freeze]
  s.homepage = "https://piotrmurach.github.io/tty".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2.3".freeze
  s.summary = "A beautiful and powerful interactive command line prompt.".freeze

  s.installed_by_version = "2.5.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<necromancer>.freeze, ["~> 0.3.0"])
      s.add_runtime_dependency(%q<pastel>.freeze, ["~> 0.7.0"])
      s.add_runtime_dependency(%q<tty-cursor>.freeze, ["~> 0.3.0"])
      s.add_runtime_dependency(%q<wisper>.freeze, ["~> 1.6.1"])
      s.add_development_dependency(%q<bundler>.freeze, ["< 2.0", ">= 1.5.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    else
      s.add_dependency(%q<necromancer>.freeze, ["~> 0.3.0"])
      s.add_dependency(%q<pastel>.freeze, ["~> 0.7.0"])
      s.add_dependency(%q<tty-cursor>.freeze, ["~> 0.3.0"])
      s.add_dependency(%q<wisper>.freeze, ["~> 1.6.1"])
      s.add_dependency(%q<bundler>.freeze, ["< 2.0", ">= 1.5.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    end
  else
    s.add_dependency(%q<necromancer>.freeze, ["~> 0.3.0"])
    s.add_dependency(%q<pastel>.freeze, ["~> 0.7.0"])
    s.add_dependency(%q<tty-cursor>.freeze, ["~> 0.3.0"])
    s.add_dependency(%q<wisper>.freeze, ["~> 1.6.1"])
    s.add_dependency(%q<bundler>.freeze, ["< 2.0", ">= 1.5.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
  end
end
