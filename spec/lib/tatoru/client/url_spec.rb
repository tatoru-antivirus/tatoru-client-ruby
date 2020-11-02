require 'bundler/setup'
require 'spec_helper'
require 'tatoru_client'

RSpec.describe Tatoru::Client::Url, vcr: true do
  it { expect(described_class).to respond_to(:safe?) }

  describe "class methods" do
    describe "#safe?" do
      describe "with a clean url" do
        let(:url) { "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf" }

        subject { described_class }

        it { expect(subject.safe?(url)).to be_truthy }
      end

      describe "with an infected url" do
        let(:url) { "https://secure.eicar.org/eicar.com" }

        subject { described_class }

        it { expect(subject.safe?(url)).to be_falsey }
      end
    end
  end
end
