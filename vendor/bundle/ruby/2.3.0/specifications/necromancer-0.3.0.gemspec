# -*- encoding: utf-8 -*-
# stub: necromancer 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "necromancer".freeze
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Murach".freeze]
  s.date = "2014-12-14"
  s.description = "Conversion from one object type to another with a bit of black magic.".freeze
  s.email = ["".freeze]
  s.homepage = "https://github.com/peter-murach/necromancer".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2.3".freeze
  s.summary = "Conversion from one object type to another with a bit of black magic.".freeze

  s.installed_by_version = "2.5.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.6"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
  end
end
