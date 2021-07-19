RSpec.describe Tatoru::Client::File, vcr: true do
  before(:each) do
    allow(Tatoru::Client::Configuration).to receive(:base_url).and_return("http://localhost:3002")
    allow(Tatoru::Client::Configuration).to receive(:api_token).and_return("31e37aa387cf0eb628d6e44cf457f4e2")
  end

  it { expect(described_class).to respond_to(:safe?) }

  describe "class methods" do
    describe "#safe?" do
      describe "with a clean file" do
        let(:filename) { Tatoru::Client.root.join *%w(spec files clean.pdf) }

        subject { described_class }

        it { expect(subject.safe?(filename)).to be_truthy }
      end

      describe "with an infected file" do
        let(:filename) { Tatoru::Client.root.join *%w(spec files infected.zip) }

        subject { described_class }

        it { expect(subject.safe?(filename)).to be_falsey }
      end
    end

    describe "#scan" do
      describe "with a clean file" do
        let(:filename) { Tatoru::Client.root.join *%w(spec files clean.pdf) }

        subject { described_class }

        it { expect(subject.scan(filename)).to be_a(Hash) }
        it { expect(subject.scan(filename).keys).to match_array(["callback_url", "uuid", "status", "url", "filename", "content_length", "sha1", "matches", "created_at", "updated_at"]) }
        it { expect(subject.scan(filename)['filename']).to eq(File.basename(filename)) }
      end

      describe "with an infected file" do
        let(:filename) { Tatoru::Client.root.join *%w(spec files infected.zip) }

        subject { described_class }

        it { expect(subject.scan(filename)).to be_a(Hash) }
        it { expect(subject.scan(filename).keys).to match_array(["callback_url", "uuid", "status", "url", "filename", "content_length", "sha1", "matches", "created_at", "updated_at"]) }
        it { expect(subject.scan(filename)['filename']).to eq(File.basename(filename)) }
      end
    end
  end
end
