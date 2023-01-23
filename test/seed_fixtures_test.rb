require "test_helper"

class SeedFixturesTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SeedFixtures::VERSION
  end
end
