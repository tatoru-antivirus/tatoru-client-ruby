RSpec.describe Tatoru::Client::Node, vcr: true do
  before(:each) do
    allow(Tatoru::Client::Configuration).to receive(:base_url).and_return("http://localhost:3002")
    allow(Tatoru::Client::Configuration).to receive(:api_token).and_return("31e37aa387cf0eb628d6e44cf457f4e2")
  end

  it { expect(subject).to respond_to(:scan_url) }
  it { expect(subject).to respond_to(:scan_file) }
  it { expect(subject).to respond_to(:get_scan) }
  it { expect(subject).to respond_to(:status) }
  it { expect(subject).to respond_to(:ready?) }

  describe "#status" do
    subject { described_class.new.status }

    it { expect(subject).to eq("authorized" => true) }
  end

  describe "#ready?" do
    subject { described_class.new.ready? }

    it { expect(subject).to be_truthy }
  end
end
