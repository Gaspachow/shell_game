# -*- encoding: utf-8 -*-
# stub: whirly 0.2.6 ruby lib

Gem::Specification.new do |s|
  s.name = "whirly".freeze
  s.version = "0.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jan Lelis".freeze]
  s.date = "2017-11-01"
  s.description = "Simple terminal spinner with support for custom spinners. Includes spinners from npm's cli-spinners.".freeze
  s.email = ["mail@janlelis.de".freeze]
  s.homepage = "https://github.com/janlelis/whirly".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new("~> 2.0".freeze)
  s.rubygems_version = "2.5.2.3".freeze
  s.summary = "Whirly: The friendly terminal spinner".freeze

  s.installed_by_version = "2.5.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<unicode-display_width>.freeze, ["~> 1.1"])
    else
      s.add_dependency(%q<unicode-display_width>.freeze, ["~> 1.1"])
    end
  else
    s.add_dependency(%q<unicode-display_width>.freeze, ["~> 1.1"])
  end
end
