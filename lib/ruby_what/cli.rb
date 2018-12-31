require 'pry'

class CommandLineInterface

  def setup
    #Get the names of the ruby versions' different classes and instanstiate a RubyClass object for each.
    DocScraper.scrape_and_create_classes
    #For each class scrape the method information
    #Create a RubyMethod for all of the method sections found on the various class pages.
    #Associate each method with the class that it is applicable for
    RubyClass.create_methods_for_each_ruby_class_page
  end



end
