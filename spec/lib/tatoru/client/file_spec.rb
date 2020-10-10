require 'bundler/setup'
require 'spec_helper'
require 'tatoru_client'

RSpec.describe Tatoru::Client::File do
  it { expect(described_class).to respond_to(:safe?) }

  describe "class methods" do
    describe "#safe?" do
      describe "with a clean file" do
        let(:file) { Tatoru::Client.root.join *%w(spec files clean.pdf) }

        subject { described_class }

        it { expect(subject.safe?(file)).to be_truthy }
      end

      describe "with an infected file" do
        let(:file) { Tatoru::Client.root.join *%w(spec files infected.zip) }

        subject { described_class }

        it { expect(subject.safe?(file)).to be_falsey }
      end
    end

    describe "#scan" do
      describe "with a clean file" do
        let(:file) { Tatoru::Client.root.join *%w(spec files clean.pdf) }

        subject { described_class }

        it { expect(subject.scan(file)).to be_a(Hash) }
        it { expect(subject.scan(file).keys).to eq(["id", "uuid", "status", "url", "filename", "content_length", "sha1", "matches", "created_at", "updated_at"]) }
      end

      describe "with an infected file" do
        let(:file) { Tatoru::Client.root.join *%w(spec files infected.zip) }

        subject { described_class }

        it { expect(subject.scan(file)).to be_a(Hash) }
        it { expect(subject.scan(file).keys).to eq(["id", "uuid", "status", "url", "filename", "content_length", "sha1", "matches", "created_at", "updated_at"]) }
      end
    end
  end
end
