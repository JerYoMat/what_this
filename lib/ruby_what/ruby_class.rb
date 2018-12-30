class RubyClass < ActiveRecord::Base
  has_many :ruby_methods
  validates :name, uniqueness: true

  def create_class_methods_from_name_array(ary)
    ary.each { |a| assoc_method = self.ruby_methods.create(name: a)}
  end


end
