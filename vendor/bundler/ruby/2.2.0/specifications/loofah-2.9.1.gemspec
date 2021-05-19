# -*- encoding: utf-8 -*-
# stub: loofah 2.9.1 ruby lib

Gem::Specification.new do |s|
  s.name = "loofah"
  s.version = "2.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/flavorjones/loofah/issues", "changelog_uri" => "https://github.com/flavorjones/loofah/blob/main/CHANGELOG.md", "documentation_uri" => "https://www.rubydoc.info/gems/loofah/", "homepage_uri" => "https://github.com/flavorjones/loofah", "source_code_uri" => "https://github.com/flavorjones/loofah" } if s.respond_to? :metadata=
  s.require_paths = ["lib"]
  s.authors = ["Mike Dalessio", "Bryan Helmkamp"]
  s.date = "2021-04-07"
  s.description = "Loofah is a general library for manipulating and transforming HTML/XML documents and fragments, built on top of Nokogiri.\n\nLoofah excels at HTML sanitization (XSS prevention). It includes some nice HTML sanitizers, which are based on HTML5lib's safelist, so it most likely won't make your codes less secure. (These statements have not been evaluated by Netexperts.)\n\nActiveRecord extensions for sanitization are available in the [`loofah-activerecord` gem](https://github.com/flavorjones/loofah-activerecord)."
  s.email = ["mike.dalessio@gmail.com", "bryan@brynary.com"]
  s.homepage = "https://github.com/flavorjones/loofah"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "Loofah is a general library for manipulating and transforming HTML/XML documents and fragments, built on top of Nokogiri"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.5.9"])
      s.add_runtime_dependency(%q<crass>, ["~> 1.0.2"])
      s.add_development_dependency(%q<rake>, ["~> 13.0"])
      s.add_development_dependency(%q<minitest>, ["~> 5.14"])
      s.add_development_dependency(%q<rr>, ["~> 1.2.0"])
      s.add_development_dependency(%q<json>, ["~> 2.2"])
      s.add_development_dependency(%q<concourse>, ["~> 0.33"])
      s.add_development_dependency(%q<rubocop>, ["~> 1.1"])
      s.add_development_dependency(%q<rdoc>, ["< 7", ">= 4.0"])
      s.add_development_dependency(%q<hoe-markdown>, ["~> 1.3"])
    else
      s.add_dependency(%q<nokogiri>, [">= 1.5.9"])
      s.add_dependency(%q<crass>, ["~> 1.0.2"])
      s.add_dependency(%q<rake>, ["~> 13.0"])
      s.add_dependency(%q<minitest>, ["~> 5.14"])
      s.add_dependency(%q<rr>, ["~> 1.2.0"])
      s.add_dependency(%q<json>, ["~> 2.2"])
      s.add_dependency(%q<concourse>, ["~> 0.33"])
      s.add_dependency(%q<rubocop>, ["~> 1.1"])
      s.add_dependency(%q<rdoc>, ["< 7", ">= 4.0"])
      s.add_dependency(%q<hoe-markdown>, ["~> 1.3"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 1.5.9"])
    s.add_dependency(%q<crass>, ["~> 1.0.2"])
    s.add_dependency(%q<rake>, ["~> 13.0"])
    s.add_dependency(%q<minitest>, ["~> 5.14"])
    s.add_dependency(%q<rr>, ["~> 1.2.0"])
    s.add_dependency(%q<json>, ["~> 2.2"])
    s.add_dependency(%q<concourse>, ["~> 0.33"])
    s.add_dependency(%q<rubocop>, ["~> 1.1"])
    s.add_dependency(%q<rdoc>, ["< 7", ">= 4.0"])
    s.add_dependency(%q<hoe-markdown>, ["~> 1.3"])
  end
end
