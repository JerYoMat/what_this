class DocScraper
  @@core_path = "https://ruby-doc.org/core-2.3.1/"
  attr_accessor :current_class

#creates a ruby_class instance for each class labeled on ruby-docs core page.
  def self.scrape_and_create_classes
    core_page = Nokogiri::HTML(open(@@core_path))
      core_page.xpath("//div [@id='class-index']/div[2]/p/a").each do |class_name|
        if !class_name.children.text.include?("::") && !class_name.children.text.include?("Error")
          source_url = "#{@@core_path + class_name}.html"
          RubyClass.create(:name => class_name.text, :link_id => source_url)
        end
    end
  end


#Returns an array of the names of all of the methods associated with the provided ruby_class name
  def self.scrape_method_data_from_this_class_page(class_instance)
    method_names= []
  method_dets = []
    class_instance_data = Nokogiri::HTML(open(class_instance.link_id))
      class_instance_data.xpath("//div[@id='method-list-section']/ul/li/a").each do |method_name|
          name = method_name.text.gsub(/[:#]/,'')
          method_names<< name
      end
      counter = 0
      class_instance_data.css(".method-detail").each do |section|
        method_hash = {}
        method_hash[:name] = method_names[counter]
        counter += 1

        method_hash[:headers] = section.xpath("div [@class='method-heading'] / span").text.split("click to toggle source")
        method_hash[:short_description] = section.xpath("div / p[1]").text.split("\n").join(' ')
        method_hash[:long_description] = section.xpath("div / p").text  #Not currently used
        method_hash[:sample_code] = section.css(".ruby").text.split("\n")
        method_dets << method_hash
      end
    method_dets

  end




end
