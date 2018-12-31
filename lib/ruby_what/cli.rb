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


  def run
     prompt_text
  end

  def prompt_text
     3.times {puts ''}
    enter = bold_and_green("ENTER")
    c_name = bold_and_green("Class_name")
    m_name = bold_and_green("method_name")
    puts "Options:".colorize(:mode => :underline, :color => :light_blue)
    puts "For a list of all available classes: press #{enter}"
    puts "For a list of methods of a particular class: #{c_name}"
    puts "To see description and sample code for a specific class and method: #{c_name}, #{m_name}"
    puts ""
  end

  def bold_and_green(string)
    string.colorize(:mode => :bold, :color => :green)
  end



end
