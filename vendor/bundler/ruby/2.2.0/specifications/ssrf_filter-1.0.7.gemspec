# -*- encoding: utf-8 -*-
# stub: ssrf_filter 1.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "ssrf_filter"
  s.version = "1.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Arkadiy Tetelman"]
  s.date = "2019-10-21"
  s.description = "A gem that makes it easy to prevent server side request forgery (SSRF) attacks"
  s.homepage = "https://github.com/arkadiyt/ssrf_filter"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.4.5.1"
  s.summary = "A gem that makes it easy to prevent server side request forgery (SSRF) attacks"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler-audit>, ["~> 0.6.1"])
      s.add_development_dependency(%q<coveralls>, ["~> 0.8.22"])
      s.add_development_dependency(%q<rspec>, ["~> 3.8.0"])
      s.add_development_dependency(%q<webmock>, ["~> 3.5.1"])
      s.add_development_dependency(%q<rubocop>, ["~> 0.65.0"])
    else
      s.add_dependency(%q<bundler-audit>, ["~> 0.6.1"])
      s.add_dependency(%q<coveralls>, ["~> 0.8.22"])
      s.add_dependency(%q<rspec>, ["~> 3.8.0"])
      s.add_dependency(%q<webmock>, ["~> 3.5.1"])
      s.add_dependency(%q<rubocop>, ["~> 0.65.0"])
    end
  else
    s.add_dependency(%q<bundler-audit>, ["~> 0.6.1"])
    s.add_dependency(%q<coveralls>, ["~> 0.8.22"])
    s.add_dependency(%q<rspec>, ["~> 3.8.0"])
    s.add_dependency(%q<webmock>, ["~> 3.5.1"])
    s.add_dependency(%q<rubocop>, ["~> 0.65.0"])
  end
end
