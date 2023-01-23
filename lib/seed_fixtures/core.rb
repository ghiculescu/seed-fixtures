require "active_support/concern"

module SeedFixtures
  module Core
    extend ActiveSupport::Concern

    module ClassMethods
      def fixtures_from_seeds
        ActiveRecord::TestFixtures.prepend SeedFixtures::Implementation

        parallelize_setup { SeedFixtures::Implementation.truncate_and_seed }
      end
    end
  end
end
