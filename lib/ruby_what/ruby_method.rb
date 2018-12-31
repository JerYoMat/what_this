class RubyMethod < ActiveRecord::Base
  belongs_to :ruby_class
  serialize :headers, Array
  serialize :sample_code, Array
      def display_method_details
          parent_id = self.ruby_class_id
          class_instance  =  RubyClass.find(parent_id)
          puts ''
          puts '  Class: ' + class_instance.name.colorize(:mode => :bold) + ' Method: ' + self.name.colorize(:color => :red, :mode => :bold)
          printf("\t %s \n", self.short_description.colorize(:mode => :italic))
binding.pry
          self.headers.each do |heading|
           printf("\t#{heading.colorize(:light_blue)}\n")
          end
          self.sample_code.each do |code|
              line = code.colorize(:color => :white)
              printf("\t %-50s \n", line)
          end
          puts ''
          puts "Source: #{class_instance.link_id}"
          3.times do
            printf("\n")
          end

      end

end
