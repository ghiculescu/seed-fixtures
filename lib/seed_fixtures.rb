require "active_support/test_case"

module SeedFixtures
  autoload :VERSION, "seed_fixtures/version"
  autoload :Core, "seed_fixtures/core"
  autoload :Implementation, "seed_fixtures/implementation"
end

ActiveSupport::TestCase.include SeedFixtures::Core
