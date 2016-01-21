require 'spec_helper'
require 'gormanian/date'

describe Date do
  describe "#to_gor" do
    subject { Date.today.to_gor }

    it { is_expected.to be_a Gormanian::Date }
  end

  describe "#to_gormanian" do
    subject { Date.today.to_gormanian }

    it { is_expected.to be_a Gormanian::Date }
  end
end
