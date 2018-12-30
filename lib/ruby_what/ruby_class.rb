class RubyClass < ActiveRecord::Base
  has_many :ruby_methods
  validates :name, uniqueness: true

  def self.create_methods_for_each_ruby_class
    self.all.each do |ind_class|
      method_names = DocScraper.scrape_class_methods(ind_class.name)
      ind_class.create_class_methods_from_name_array(method_names)
    end
  end


  def self.populate_all_classes_with_method_data
   self.all.each { |ind_c| ind_c.populate_ind_class_w_methods}
   binding.pry
  end



  def create_class_methods_from_name_array(ary)
    ary.each { |a| assoc_method = self.ruby_methods.create(name: a)}
  end




  def populate_ind_class_w_methods
    method_data = DocScraper.scrape_method_content_from_class_page(self)
    counter = 0
    self.ruby_methods.each do |ind_meth|
    target_hash = method_data[counter]
      ind_meth.headers = target_hash[:headings]
      ind_meth.short_description = target_hash[:mini_description]
      ind_meth.long_description = target_hash[:full_description]
      ind_meth.sample_code = target_hash[:code]
      counter += 1
    end
    binding.pry 
  end

end
