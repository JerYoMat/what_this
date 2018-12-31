class RubyClass < ActiveRecord::Base
  has_many :ruby_methods
  validates :name, uniqueness: true



  #For each class scrape the method information
  #Create a RubyMethod for all of the method sections found on the various class pages.
  #Associate each method with the class that it is applicable for
def self.create_methods_for_each_ruby_class_page
   self.all.each do |ind_class|
     ind_class.create_and_associate_methods_for_this_class_instance
   end
end




def create_and_associate_methods_for_this_class_instance
  method_dets = DocScraper.scrape_method_data_from_this_class_page(self)
binding.pry 
method_dets.each do |hash|

  self.ruby_methods.create(
    name: hash[:name],
    headers: hash[:headers],
    short_description: hash[:short_description],
    long_description: hash[:long_description],
    sample_code: hash[:sample_code]
  )


end
end
end
