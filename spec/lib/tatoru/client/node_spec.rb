require 'bundler/setup'
require 'spec_helper'
require 'tatoru_client'

RSpec.describe Tatoru::Client::Node do
  it { expect(subject).to respond_to(:scan_url) }
  it { expect(subject).to respond_to(:scan_file) }
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
