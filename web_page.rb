class WebPage
  attr_reader :ips, :views, :unique_views, :path

  def initialize(path:)
    @unique_views = 0
    @views = 0
    @ips = []
    @path = path
  end

  def record_view(ip)
    unless viewed_by?(ip)
      increase_unique_views
      ips.append(ip)
    end

    increase_views
  end

  private

  def increase_views
    @views += 1
  end

  def increase_unique_views
    @unique_views += 1
  end

  def viewed_by?(ip)
    ips.include?(ip)
  end
end

