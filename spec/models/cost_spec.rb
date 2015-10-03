require 'spec_helper'

describe Cost do
  describe '#formatted_date' do
    let(:cost) { create(:cost, date: '01-01-2010') }

    it "calls the DateFormatter with this cost's date" do
      expect(DateFormatter).to receive(:format).with(cost.date)
      cost.formatted_date
    end
  end
end
