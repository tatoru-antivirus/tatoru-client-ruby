RSpec.describe Tatoru::Client::Scan, vcr: true do
  before(:each) do
    allow(Tatoru::Client::Configuration).to receive(:base_url).and_return("http://localhost:3002")
    allow(Tatoru::Client::Configuration).to receive(:api_token).and_return("31e37aa387cf0eb628d6e44cf457f4e2")
  end

  subject { described_class.new("uuid") }

  it { expect(subject).to respond_to(:safe?) }
  it { expect(subject).to respond_to(:infected?) }
  it { expect(subject).to respond_to(:scan) }

  let(:filename) { Tatoru::Client.root.join *%w(spec files infected.zip) }
  let(:scan_result) { Tatoru::Client::Node.new.scan_file(filename) }
  let(:uuid) { scan_result['uuid'] }

  describe "#scan" do
    subject { described_class.new(uuid).scan }

    it { expect(subject).to be_a(Hash) }
  end

  describe "#infected?" do
    subject { described_class.new(uuid).infected? }

    it { expect(subject).to be_truthy }
  end

  describe "#safe?" do
    subject { described_class.new(uuid).safe? }

    it { expect(subject).to be_falsey }
  end

  describe "#status?" do
    subject { described_class.new(uuid).status }

    it { expect(subject).to eq("infected") }
  end
end
