$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "seed_fixtures"

require "minitest/autorun"
Dir[File.expand_path("support/**/*.rb", __dir__)].sort.each { |rb| require(rb) }

require "combustion"
Combustion.path = "test/internal"
Combustion.initialize! :all

require "rails/test_help"
class ActiveSupport::TestCase
  fixtures_from_seeds

  parallelize(workers: :number_of_processors) if ENV["PARALLEL_WORKERS"]

  # This is needed for local development using SQLite:
  teardown { FileUtils.rm(".seeds_hash", force: true) }
end
