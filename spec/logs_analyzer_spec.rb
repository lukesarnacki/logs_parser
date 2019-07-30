require_relative "../logs_analyzer"
require_relative "../logs"

RSpec.describe LogsAnalyzer do
  subject { described_class.new(logs) }

  context "empty logs" do
    let(:logs) { Logs.new }
    specify { expect(subject.webpages_by_views).to be_empty }
    specify { expect(subject.webpages_by_unique_views).to be_empty }
  end

  context "non empty logs" do
    let(:logs) do
      Logs.new.tap do |logs|
        logs.append('/index 126.318.035.038')
        logs.append('/home 184.123.665.067')
        logs.append('/index 126.318.035.038')
        logs.append('/index 235.313.352.950')
        logs.append('/about 235.313.352.950')
        logs.append('/about 184.123.665.067')
        logs.append('/about 126.318.035.038')
        logs.append('/about 126.318.035.038')
      end
    end

    it "sorts by pages views" do
      expect(subject.webpages_by_views.map {|w| [w.path, w.views]}).to match_array([
        ["/about", 4],
        ["/index", 3],
        ["/home", 1]
      ])
    end

    it "sorts webpages unique views" do
      expect(subject.webpages_by_unique_views.map{|w| [w.path, w.unique_views]}).to match_array([
        ["/about", 3],
        ["/index", 2],
        ["/home", 1]
      ])
    end
  end
end
