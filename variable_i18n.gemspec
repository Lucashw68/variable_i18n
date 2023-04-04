# frozen_string_literal: true

require_relative "lib/variable_i18n/version"

Gem::Specification.new do |spec|
  spec.name = "variable_i18n"
  spec.version = VariableI18n::VERSION

  spec.authors = ["lucashw68"]
  spec.email = ["lucas.heitzmann@epitech.eu"]

  spec.summary = "Use variables in I18n translations."
  spec.description = "A gem which allows you to re-use I18n keys."

  spec.homepage = "https://github.com/Lucashw68/variable_i18n"
  spec.license = "MIT"

  spec.required_ruby_version = ">= 3.1.2"

  # spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Lucashw68/variable_i18n"
  spec.metadata["changelog_uri"] = "https://github.com/Lucashw68/variable_i18n/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.3.16"
  spec.add_development_dependency "i18n", "~> 1.12.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.metadata["rubygems_mfa_required"] = "true"
end
