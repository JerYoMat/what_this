require_relative './lib/ruby_what/version'


 Gem::Specification.new do |spec|
   spec.name          = "ruby_what"
   spec.version       = RubyWhat::VERSION
   spec.authors       = ["JerYoMat"]
   spec.email         = ["jeremy.emata@gmail.com"]
   spec.summary       = "A gem to display ruby-doc info within the terminal"
   spec.homepage      = "https://github.com/JerYoMat/what_this"
   spec.license       = "MIT"

   spec.files         =  ["lib/ruby_what.rb", "lib/ruby_what/cli.rb", "lib/ruby_what/doc_scraper.rb", "lib/ruby_what/ruby_class.rb", "lib/ruby_what/ruby_method.rb", "config/environment.rb", "db/schema.rb", "db/development.sqlite"]
  spec.homepage    = "https://github.com/JerYoMat/what_this"
  spec.license     = 'MIT'
  spec.executables << 'what_the_ruby'



   spec.add_development_dependency "bundler", "~> 1.5"
   spec.add_development_dependency "rake"
   spec.add_development_dependency "activerecord",  ">= 4.2.7.1"
   spec.add_development_dependency "sinatra"
   spec.add_development_dependency "sinatra-activerecord"
   spec.add_development_dependency "require_all"
   spec.add_development_dependency "nokogiri"
   spec.add_development_dependency "pry"
   spec.add_development_dependency "colorize"
 end
