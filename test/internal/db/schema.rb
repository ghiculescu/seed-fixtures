# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.text :name, null: false
    t.timestamps
  end
end
