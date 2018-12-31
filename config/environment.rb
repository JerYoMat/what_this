ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

#Turns off the SqlLogging
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

require 'sinatra'
require 'active_record'
require 'sqlite3'
require 'nokogiri'
require 'colorize'
require 'pry'
require 'open-uri'
require 'fileutils'
require 'require_all'


require_relative "../lib/ruby_what.rb"
require_relative "../lib/ruby_what/doc_scraper"
require_relative "../lib/ruby_what/ruby_class"
require_relative "../lib/ruby_what/ruby_method"
require_relative "../lib/ruby_what/cli"
