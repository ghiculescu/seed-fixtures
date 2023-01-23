require "active_support/concern"

module SeedFixtures
  module Implementation
    class << self
      def truncate_and_seed
        ActiveRecord::Tasks::DatabaseTasks.truncate_all
        Rails.application.load_seed
      end
    end

    def load_fixtures(*)
      return if defined?(@@has_loaded_fixtures)

      unless_seeds_in_db_match_files do
        SeedFixtures::Implementation.truncate_and_seed
      end

      @@has_loaded_fixtures = true
    end

    private

    def unless_seeds_in_db_match_files
      File.write(hash_file_path, "") unless File.exist?(hash_file_path)

      expected_hash = File.read(hash_file_path).strip
      if expected_hash == calculate_seeds_hash
        Rails.logger.debug "Seeds not changed since last run, skipping seeds generation. Delete #{hash_file_path} to force seeds to generate."
      else
        Rails.logger.debug "Generating seeds!"
        yield
        File.write(hash_file_path, calculate_seeds_hash)
      end
    end

    def hash_file_path
      ".seeds_hash"
    end

    def calculate_seeds_hash
      `find db* -type f | perl -e 'print sort <>' - | xargs md5sum | cut -c1-32 | md5sum | cut -c1-32`.strip
    end
  end
end
