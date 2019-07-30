class WebPagesStatisticsView
  def initialize(title:, webpages:, webpage_partial:)
    @webpages = webpages
    @title = title
    @webpage_partial = webpage_partial
  end

  def text
    @text = []
    @text << @title
    @webpages.map do |webpage|
      @text << @webpage_partial.call(webpage)
    end
    @text.join("\n")
  end
end
