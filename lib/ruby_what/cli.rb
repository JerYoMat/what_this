require 'pry'

class CommandLineInterface

  def setup
    #get the names and destination links from the core path
    #create the different ruby_class instances and populate with name and source_link
    DocScraper.scrape_classes
    #get the ruby_method info from the ruby_class page
    #create the different ruby_methods and associate them with the correct ruby_clas
    RubyClass.create_methods_for_each_ruby_class
    #Add in method detail to ruby_methods for each ind_class
    t = RubyClass.find(3)
    t.populate_ind_class_w_methods

  end

end
