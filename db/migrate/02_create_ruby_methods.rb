class CreateRubyMethods < ActiveRecord::Migration
  def change
    create_table :ruby_methods do |t|
      t.belongs_to :ruby_class
      t.string :name
      t.text :headers
      t.text :short_description
      t.text :long_description
      t.text :sample_code


      t.timestamps null: false
    end
  end
end
