require "test_helper"

class SeedFixturesTest < ActiveSupport::TestCase
  10.times do |n|
    test "that it loads seeds (run #{n})" do
      assert_equal 2, User.count
    end
  end
end
