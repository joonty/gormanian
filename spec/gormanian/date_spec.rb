require "spec_helper"

describe Gormanian::Date do
  describe "::today" do
    subject { Gormanian::Date.new(2016, 1) }
    its(:year) { is_expected.to eq 2016 }
    its(:yday) { is_expected.to eq 1 }
  end

  describe "::today" do
    subject { Gormanian::Date.today }
    it { is_expected.to be_a Gormanian::Date }
    it { is_expected.to eq Date.today }
    its(:yday) { is_expected.to eq Date.today.yday }
  end

  describe "date attributes" do
    context "on the 1st day of the year" do
      let(:date) { Date.new(2015, 1, 1) }
      subject { Gormanian::Date.from_gregorian_date(date) }

      it { is_expected.to eq date }
      its(:day_of_year) { is_expected.to eq 1 }
      its(:day) { is_expected.to eq 1 }
      its(:day_name) { is_expected.to eq "Sunday" }
      its(:saturday?) { is_expected.to be_falsey }
      its(:sunday?) { is_expected.to be_truthy }
      its(:intermission?) { is_expected.to be_falsey }
      its(:month) { is_expected.to eq 1 }
      its(:month_name) { is_expected.to eq "March" }
      its(:to_s) { is_expected.to eq "1 March, 2015" }
    end

    context "on the 29th day of the year" do
      let(:date) { Date.new(2015, 1, 29) }
      subject { Gormanian::Date.from_gregorian_date(date) }

      it { is_expected.to eq date }
      its(:day_of_year) { is_expected.to eq 29 }
      its(:day) { is_expected.to eq 1 }
      its(:day_name) { is_expected.to eq "Sunday" }
      its(:saturday?) { is_expected.to be_falsey }
      its(:sunday?) { is_expected.to be_truthy }
      its(:intermission?) { is_expected.to be_falsey }
      its(:month) { is_expected.to eq 2 }
      its(:month_name) { is_expected.to eq "April" }
      its(:to_s) { is_expected.to eq "1 April, 2015" }
    end

    context "on the 364th day of the year" do
      let(:date) { Date.new(2015, 12, 30) }
      subject { Gormanian::Date.from_gregorian_date(date) }

      it { is_expected.to eq date }
      its(:day_of_year) { is_expected.to eq 364 }
      its(:day) { is_expected.to eq 28 }
      its(:day_name) { is_expected.to eq "Saturday" }
      its(:saturday?) { is_expected.to be_truthy }
      its(:sunday?) { is_expected.to be_falsey }
      its(:intermission?) { is_expected.to be_falsey }
      its(:month) { is_expected.to eq 13 }
      its(:month_name) { is_expected.to eq "Gormanuary" }
      its(:to_s) { is_expected.to eq "28 Gormanuary, 2015" }
    end

    context "on the 365th day of the year" do
      let(:date) { Date.new(2015, 12, 31) }
      subject { Gormanian::Date.from_gregorian_date(date) }

      it { is_expected.to eq date }
      its(:day_of_year) { is_expected.to eq 365 }
      its(:day) { is_expected.to eq :intermission }
      its(:day_name) { is_expected.to eq :intermission }
      its(:saturday?) { is_expected.to be_falsey }
      its(:sunday?) { is_expected.to be_falsey }
      its(:intermission?) { is_expected.to be_truthy }
      its(:month) { is_expected.to eq :intermission }
      its(:month_name) { is_expected.to eq :intermission }
      its(:to_s) { is_expected.to eq "Intermission, 2015" }
    end

    context "on the 366th day of a leap year" do
      let(:date) { Date.new(2016, 12, 31) }
      subject { Gormanian::Date.from_gregorian_date(date) }

      it { is_expected.to eq date }
      its(:day_of_year) { is_expected.to eq 366 }
      its(:day) { is_expected.to eq :intermission }
      its(:day_name) { is_expected.to eq :intermission }
      its(:saturday?) { is_expected.to be_falsey }
      its(:sunday?) { is_expected.to be_falsey }
      its(:intermission?) { is_expected.to be_truthy }
      its(:month) { is_expected.to eq :intermission }
      its(:month_name) { is_expected.to eq :intermission }
      its(:to_s) { is_expected.to eq "Intermission, 2016" }
    end

    context "on the 29th of Feb in a leap year" do
      subject { Gormanian::Date.from_gregorian_date(Date.new(2016, 2, 29)) }

      its(:day_of_year) { is_expected.to eq 60 }
      its(:day) { is_expected.to eq 4 }
      its(:day_name) { is_expected.to eq "Wednesday" }
      its(:saturday?) { is_expected.to be_falsey }
      its(:wednesday?) { is_expected.to be_truthy }
      its(:intermission?) { is_expected.to be_falsey }
      its(:month) { is_expected.to eq 3 }
      its(:month_name) { is_expected.to eq "May" }
      its(:to_s) { is_expected.to eq "4 May, 2016" }
    end
  end

  describe "#+" do
    context "from the 1st day of the year" do
      let(:date) { Gormanian::Date.new(2015, 1) }
      subject { date + 1 }

      it { is_expected.to be_a Gormanian::Date }
      its(:yday) { is_expected.to eq 2 }
    end

    context "from the 28th day of the year" do
      let(:date) { Gormanian::Date.new(2015, 28) }
      subject { date + 1 }

      it { is_expected.to be_a Gormanian::Date }
      its(:yday) { is_expected.to eq 29 }
      its(:day) { is_expected.to eq 1 }
      its(:month) { is_expected.to eq 2 }
    end

    context "from the 364th day of the year" do
      let(:date) { Gormanian::Date.new(2015, 364) }
      subject { date + 1 }

      it { is_expected.to be_a Gormanian::Date }
      its(:yday) { is_expected.to eq 365 }
      its(:day) { is_expected.to eq :intermission }
      its(:month) { is_expected.to eq :intermission }
    end

    context "from the 365th day of the year" do
      let(:date) { Gormanian::Date.new(2015, 365) }
      subject { date + 1 }

      it { is_expected.to be_a Gormanian::Date }
      its(:yday) { is_expected.to eq 1 }
      its(:year) { is_expected.to eq 2016 }
      its(:day) { is_expected.to eq 1 }
      its(:month) { is_expected.to eq 1 }
    end

    context "adding 2 days from the 365th day of the year" do
      let(:date) { Gormanian::Date.new(2015, 365) }
      subject { date + 2 }

      it { is_expected.to be_a Gormanian::Date }
      its(:yday) { is_expected.to eq 2 }
      its(:year) { is_expected.to eq 2016 }
      its(:day) { is_expected.to eq 2 }
      its(:month) { is_expected.to eq 1 }
    end
  end
end
