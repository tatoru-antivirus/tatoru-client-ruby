require 'bundler/setup'
require 'spec_helper'
require 'tatoru_client'

RSpec.describe Tatoru::Client::Node do
  it { expect(subject).to respond_to(:scan_url) }
  it { expect(subject).to respond_to(:scan_file) }
end
