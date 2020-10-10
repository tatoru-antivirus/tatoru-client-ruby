require 'bundler/setup'
require 'spec_helper'
require 'tatoru_client'

RSpec.describe Tatoru::Client do
  it { expect(described_class).to respond_to(:configure) }
  # it { expect(described_class).to respond_to(:safe?) }
  # it { expect(described_class).to respond_to(:virus?) }
end
