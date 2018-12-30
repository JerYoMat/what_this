class RubyMethod < ActiveRecord::Base
  belongs_to :ruby_class
  validates :name, uniqueness: { scope: :ruby_class_id,
    message: "should only have each method for a specific class once" }

end
