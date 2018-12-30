class CreateRubyClasses < ActiveRecord::Migration
  def change
    create_table :ruby_classes do |t|
      t.string :name
      t.string :link_id
      t.timestamps null: false
    end
  end
end
