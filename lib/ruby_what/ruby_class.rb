class RubyWhat::RubyClass < ActiveRecord::Base
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
  method_dets = RubyWhat::DocScraper.scrape_method_data_from_this_class_page(self)
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



def printf_method_list

      counter = 0
    rows = self.ruby_methods.count.to_f / 3.00
    remainder = self.ruby_methods.count % 3
    rows.floor.times do
      printf(" %3d.%-25s %3d.%-25s %3d.%-25s \n",
        counter += 1, self.ruby_methods[counter - 1].name,
        counter += 1, self.ruby_methods[counter - 1].name,
        counter += 1, self.ruby_methods[counter - 1].name)
    end
    remainder.times do
     printf(" %3d.%-25s", counter += 1, self.ruby_methods[counter - 1].name)
    end
    printf("\n")
    puts 'Enter the name of the method or exit to quit'

end



end
