#!/usr/bin/env ruby

require "ostruct"

class Parser
  def initialize(raw_logs)
    @raw_logs = raw_logs
  end

  def logs
    @logs ||= @raw_logs.split("\n").map do |line|
      path, ip = line.split(/\s+/)
      OpenStruct.new(path: path, ip: ip)
    end
  end

  def views_stats
    @views_stats ||= calculate_views
      .sort_by { |path, stats| stats.views }
      .reverse
      .map { |path, stats| [path, stats.views] }
  end

  def unique_views_stats
    @unique_views_stats ||= calculate_views
      .sort_by { |path, stats| stats.unique_views }
      .reverse
      .map { |path, stats| [path, stats.unique_views] }
  end

  private

  def calculate_views
    logs.each_with_object({}) do |log, hash|
      stats = hash[log.path] ||= OpenStruct.new(unique_views: 0, views: 0, ips: [])

      stats.views += 1
      unless stats.ips.include?(log.ip)
        stats.unique_views += 1
        stats.ips << log.ip
      end
    end
  end
end

# Run only if it was called from command line
if __FILE__== $0
  logs = File.read(ARGV[0])
  parser = Parser.new(logs)
  puts "List of webpages with most views"
  parser.views_stats.each do |stats|
    puts stats.join(" ") + " views"
  end

  puts "List of webpages with most unique views"
  parser.unique_views_stats.each do |stats|
    puts stats.join(" ") + " unique views"
  end
end
