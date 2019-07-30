require_relative "../parser"

RSpec.describe Parser do
  subject { described_class.new(logs) }

  context "empty logs" do
    let(:logs) { "" }
    specify { expect(subject.views).to be_empty }
    specify { expect(subject.unique_views).to be_empty }
  end
end
