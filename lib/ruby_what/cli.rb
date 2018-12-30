require 'pry'

class CommandLineInterface

def run
  #get the names and destination links from the core path
  #create the different ruby_class instances and populate with name and source_link
  DocScraper.scrape_classes
  #get the ruby_method info from the ruby_class page
  #create the different ruby_methods and associate them with the correct ruby_clas
  RubyClass.all.each do |ind_class|
    method_names = DocScraper.scrape_class_methods(ind_class.name)
    ind_class.create_class_methods_from_name_array(method_names)
  end

end

end
