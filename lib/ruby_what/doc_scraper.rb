class DocScraper
  @@core_path = "https://ruby-doc.org/core-2.3.1/"

  def self.scrape_classes
    core_page = Nokogiri::HTML(open(@@core_path))
      core_page.xpath("//div [@id='class-index']/div[2]/p/a").each do |class_name|
        if !class_name.children.text.include?("::")
          source_url = "#{@@core_path + class_name}.html"
          RubyClass.create(:name => class_name.text, :link_id => source_url)
        end
    end
  end


#Returns an array of the names of all of the methods associated with the provided ruby_class name
  def self.scrape_class_methods(class_instance_name)
       class_methods = []
     method_link = "#{@@core_path}/#{class_instance_name}.html"
     method_page = Nokogiri::HTML(open(method_link))
       method_page.xpath("//div[@id='method-list-section']/ul/li/a").each do |method_name|
          name = method_name.text.gsub(/[:#]/,'')
          class_methods << name
       end
      class_methods
    end



  def self.scrape_method_content_from_class_page(ind_class)
   method_dets = []
   class_instance_link = ind_class.source_link
   class_instance_data = Nokogiri::HTML(open(class_instance_link))
     class_instance_data.css(".method-detail").each do |section|
          method_hash = {}
          method_hash[:headings] =section.xpath("div [@class='method-heading'] / span").text
          method_hash[:mini_description] = section.xpath("div / p[1]").text.split("\n").join(' ')
          method_hash[:full_description] = section.xpath("div / p").text  #Not currently used
          method_hash[:code] = section.css(".ruby").text.split("\n")
          method_dets << method_hash
     end
    method_dets
  end

end
