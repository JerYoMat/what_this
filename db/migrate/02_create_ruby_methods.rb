class CreateRubyMethods < ActiveRecord::Migration
  def change
    create_table :ruby_methods do |t|
      t.belongs_to :ruby_class
      t.string :name
      t.string :headers
      t.string :short_description
      t.string :long_description
      t.string :sample_code
      t.timestamps null: false
    end
  end
end
