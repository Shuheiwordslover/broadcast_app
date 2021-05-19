# -*- encoding: utf-8 -*-
# stub: debug_inspector 1.1.0 ruby lib
# stub: ext/debug_inspector/extconf.rb

Gem::Specification.new do |s|
  s.name = "debug_inspector"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/banister/debug_inspector/releases", "homepage_uri" => "https://github.com/banister/debug_inspector", "source_code_uri" => "https://github.com/banister/debug_inspector" } if s.respond_to? :metadata=
  s.require_paths = ["lib"]
  s.authors = ["John Mair (banisterfiend)"]
  s.date = "2021-03-23"
  s.description = "Adds methods to RubyVM::DebugInspector to allow for inspection of backtrace frames.\n\nThe debug_inspector C extension and API were designed and built by Koichi Sasada, this project is just a gemification of his work.\n\nThis library makes use of the debug inspector API which was added to MRI 2.0.0.\nOnly works on MRI 2 and 3. Requiring it on unsupported Rubies will result in a no-op.\n\nRecommended for use only in debugging situations. Do not use this in production apps.\n"
  s.email = ["jrmair@gmail.com"]
  s.extensions = ["ext/debug_inspector/extconf.rb"]
  s.files = ["ext/debug_inspector/extconf.rb"]
  s.homepage = "https://github.com/banister/debug_inspector"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0")
  s.rubygems_version = "2.4.5.1"
  s.summary = "A Ruby wrapper for the MRI 2.0 debug_inspector API"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version
end
