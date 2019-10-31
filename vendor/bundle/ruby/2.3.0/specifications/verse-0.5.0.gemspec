# -*- encoding: utf-8 -*-
# stub: verse 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "verse".freeze
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Murach".freeze]
  s.date = "2016-10-25"
  s.description = "Text transformations such as truncation, wrapping, aligning, indentation and grouping of words.".freeze
  s.email = ["".freeze]
  s.homepage = "https://github.com/piotrmurach/verse".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2.3".freeze
  s.summary = "Text transformations such as truncation, wrapping, aligning, indentation and grouping of words.".freeze

  s.installed_by_version = "2.5.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<unicode_utils>.freeze, ["~> 1.4.0"])
      s.add_runtime_dependency(%q<unicode-display_width>.freeze, ["~> 1.1.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.5"])
    else
      s.add_dependency(%q<unicode_utils>.freeze, ["~> 1.4.0"])
      s.add_dependency(%q<unicode-display_width>.freeze, ["~> 1.1.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.5"])
    end
  else
    s.add_dependency(%q<unicode_utils>.freeze, ["~> 1.4.0"])
    s.add_dependency(%q<unicode-display_width>.freeze, ["~> 1.1.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.5"])
  end
end
