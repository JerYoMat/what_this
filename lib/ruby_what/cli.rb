require 'pry'

class CommandLineInterface

  def run
    #Get the names of the ruby versions' different classes and instanstiate a RubyClass object for each.
    DocScraper.scrape_and_create_classes
    #For each class scrape the method information
    #Create a RubyMethod for all of the method sections found on the various class pages.
    #Associate each method with the class that it is applicable for
    test = RubyClass.find(3)
    test.create_and_associate_methods_for_this_class_instance
    ms = test.ruby_methods
    binding.pry

  end



end
