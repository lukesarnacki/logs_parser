#!/usr/bin/env ruby

require 'ostruct'
require_relative 'web_page'
require_relative 'logs'

class Parser
  attr_reader :logs

  def initialize(logs)
    @logs = logs
  end

  def webpages_by_views
    @webpages_by_views ||= calculate_views.sort { |a, b| b.views <=> a.views }
  end

  def webpages_by_unique_views
    @webpages_by_unique_views ||= calculate_views.sort { |a, b| b.unique_views <=> a.unique_views }
  end

  private

  def calculate_views
    logs.each_with_object({}) do |log, hash|
      webpage = hash[log.path] ||= WebPage.new(path: log.path)
      webpage.record_view(log.ip)
    end.values
  end
end

# Run only if it was called from command line
if __FILE__== $0
  logs = Logs.new
  open(ARGV[0]).each_line { |line| logs.append(line) }

  parser = Parser.new(logs)
  puts "List of webpages with most views"
  parser.webpages_by_views.each do |webpage|
    puts "#{webpage.path} #{webpage.views} unique views"
  end

  puts "List of webpages with most unique views"
  parser.webpages_by_unique_views.each do |webpage|
    puts "#{webpage.path} #{webpage.unique_views} unique views"
  end
end
