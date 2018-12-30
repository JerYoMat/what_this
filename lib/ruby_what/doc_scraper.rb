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
end
