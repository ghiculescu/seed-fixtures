require_relative "lib/seed_fixtures/version"

Gem::Specification.new do |spec|
  spec.name = "seed_fixtures"
  spec.version = SeedFixtures::VERSION
  spec.authors = ["Alex Ghiculescu"]
  spec.email = ["alexghiculescu@gmail.com"]

  spec.summary = "Use seeds.rb as test fixtures"
  spec.homepage = "https://github.com/ghiculescu/seed-fixtures"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/ghiculescu/seed-fixtures/issues",
    "changelog_uri" => "https://github.com/ghiculescu/seed-fixtures/releases",
    "source_code_uri" => "https://github.com/ghiculescu/seed-fixtures",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true"
  }

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob(%w[LICENSE.txt README.md {exe,lib}/**/*]).reject { |f| File.directory?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 7"
end
