require 'pry'

class RubyWhat::CommandLineInterface
  attr_accessor :current_class, :current_method, :user_input

  def setup
    #Get the names of the ruby versions' different classes and instanstiate a RubyClass object for each.
      RubyWhat::DocScraper.scrape_and_create_classes
    #From each class page scrape the method information
    #Create a RubyMethod for each method listed on the class page through RubyClass to include association.
      RubyWhat::RubyClass.create_methods_for_each_ruby_class_page
  end


  def run
  @user_input = " "
#First loop ensures that a @current_class is set
  until !@current_class.nil? || @user_input.downcase == "exit"
    prompt_text
    @user_input = gets.strip
    set_current_class_and_method_if_valid unless @user_input == ""
    if @current_class.nil?  && @user_input.downcase != "exit"
      printf_class_list
      @user_input = gets.strip
      set_current_class_and_method_if_valid unless @user_input == ""
    end
  end

  until !@current_method.nil? || @user_input.downcase == "exit"
    if @current_method.nil? && @user_input.downcase != "exit"
      @current_class.printf_method_list
      @user_input = gets.strip
      set_method_if_valid unless @user_input.downcase == "exit"
    end
   end

    if !@current_method.nil?
      @current_method.display_method_details
    end
    sleep(3)
    puts "Type exit to leave or press enter to look up another method"
    @user_input = gets.strip
    @current_class = nil
    @current_method = nil
    run if  @user_input.downcase != "exit"

  end







def set_method_if_valid
@current_method = set_method(@current_class, @user_input) if set_method(@current_class, @user_input)
end




  #set current_class and current_method if values are provided
  def set_current_class_and_method_if_valid
      if isolate_inputs(@user_input).first != @user_input
        @user_input = isolate_inputs(@user_input)
        @current_class = set_class(@user_input[0]) if set_class(@user_input[0])
      else
        @current_class = set_class(@user_input) if set_class(@user_input)
      end

      if !@current_class.nil? && @user_input.class == Array
        @current_method = set_method(@current_class, @user_input[1]) if set_method(@current_class, @user_input[1])
      end

  end



  def set_class(string)
    RubyWhat::RubyClass.all.select{ |ind_c| ind_c.name.upcase == string.upcase}.first
  end


  def set_method(class_instance, method_string_name)
      class_instance.ruby_methods.select {|ind_m| ind_m.name.downcase == method_string_name.downcase}.first
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

  def printf_class_list
    counter = 0
    rows = RubyWhat::RubyClass.all.count.to_f / 4.0
    remain = RubyWhat::RubyClass.all.count % 4
    rows.floor.times do
      printf(" %2d.%-22s %2d.%-22s %2d.%-22s %2d.%-22s \n",
        counter += 1, RubyWhat::RubyClass.all[counter - 1].name,
        counter += 1, RubyWhat::RubyClass.all[counter - 1].name,
        counter += 1, RubyWhat::RubyClass.all[counter - 1].name,
        counter += 1, RubyWhat::RubyClass.all[counter - 1].name)
    end
    remain.times do
      printf(" %2d.%-22s", counter += 1, RubyWhat::RubyClass.all[counter - 1].name)
    end
    printf("\n\n")
    puts "Type the name of the class to see available methods.".colorize(:mode => :bold)
  end





  def bold_and_green(string)
    string.colorize(:mode => :bold, :color => :green)
  end

  def isolate_inputs(str)
    str.scan(/\w+/)
  end

end
