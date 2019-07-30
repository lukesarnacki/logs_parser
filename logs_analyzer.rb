require_relative 'web_page'

class LogsAnalyzer
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
