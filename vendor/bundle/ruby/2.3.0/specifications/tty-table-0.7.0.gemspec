# -*- encoding: utf-8 -*-
# stub: tty-table 0.7.0 ruby lib

Gem::Specification.new do |s|
  s.name = "tty-table".freeze
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Murach".freeze]
  s.date = "2017-01-15"
  s.description = "A flexible and intuitive table generator".freeze
  s.email = ["".freeze]
  s.homepage = "http://piotrmurach.github.io/tty/".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2.3".freeze
  s.summary = "A flexible and intuitive table generator".freeze

  s.installed_by_version = "2.5.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<equatable>.freeze, ["~> 0.5.0"])
      s.add_runtime_dependency(%q<necromancer>.freeze, ["~> 0.3.0"])
      s.add_runtime_dependency(%q<pastel>.freeze, ["~> 0.7.0"])
      s.add_runtime_dependency(%q<tty-screen>.freeze, ["~> 0.5.0"])
      s.add_runtime_dependency(%q<verse>.freeze, ["~> 0.5.0"])
      s.add_runtime_dependency(%q<unicode-display_width>.freeze, ["~> 1.1.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["< 2.0", ">= 1.5.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<equatable>.freeze, ["~> 0.5.0"])
      s.add_dependency(%q<necromancer>.freeze, ["~> 0.3.0"])
      s.add_dependency(%q<pastel>.freeze, ["~> 0.7.0"])
      s.add_dependency(%q<tty-screen>.freeze, ["~> 0.5.0"])
      s.add_dependency(%q<verse>.freeze, ["~> 0.5.0"])
      s.add_dependency(%q<unicode-display_width>.freeze, ["~> 1.1.0"])
      s.add_dependency(%q<bundler>.freeze, ["< 2.0", ">= 1.5.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<equatable>.freeze, ["~> 0.5.0"])
    s.add_dependency(%q<necromancer>.freeze, ["~> 0.3.0"])
    s.add_dependency(%q<pastel>.freeze, ["~> 0.7.0"])
    s.add_dependency(%q<tty-screen>.freeze, ["~> 0.5.0"])
    s.add_dependency(%q<verse>.freeze, ["~> 0.5.0"])
    s.add_dependency(%q<unicode-display_width>.freeze, ["~> 1.1.0"])
    s.add_dependency(%q<bundler>.freeze, ["< 2.0", ">= 1.5.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
