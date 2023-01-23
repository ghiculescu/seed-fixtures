require "active_support/concern"

module SeedFixtures
  module Core
    extend ActiveSupport::Concern

    module ClassMethods
      def fixtures_from_seeds
        ActiveSupport.on_load(:active_support_test_case) do
          prepend SeedFixtures::Implementation
        end

        parallelize_setup { SeedFixtures::Implementation.truncate_and_seed }
      end
    end
  end
end
