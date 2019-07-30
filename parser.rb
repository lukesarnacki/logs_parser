#!/usr/bin/env ruby

require_relative 'web_pages_statistics_view'
require_relative 'logs'
require_relative 'logs_analyzer'

logs = Logs.new
IO.foreach(ARGV[0]).each_line { |line| logs.append(line) }
logs_analyzer = LogsAnalyzer.new(logs)

puts WebPagesStatisticsView.new(
  title: 'List of webpages with most views',
  webpages: logs_analyzer.webpages_by_views,
  webpage_partial: ->(webpage) { "#{webpage.path} #{webpage.views} views" }
).text

puts WebPagesStatisticsView.new(
  title: 'List of webpages with most unique views',
  webpages: logs_analyzer.webpages_by_unique_views,
  webpage_partial: ->(webpage) { "#{webpage.path} #{webpage.unique_views} unique views" }
).text
