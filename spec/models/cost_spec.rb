require 'spec_helper'

describe Cost do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:category_id) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.not_to allow_value('abc').for(:price).with_message('valid characters: 0-9') }

    context "cost has a date within the current budget's period range, including boundary values" do
      let(:current_budget) { create(:budget) }

      it 'allows a cost with a valid date set for it.' do
        subject = build(:cost, date: '05-01-2010', budget: current_budget)
        expect(subject.save).to eq true
      end

      it 'allows creating a cost that has the same date as the starting date of the budget period' do
        subject = build(:cost, date: '01-01-2010', budget: current_budget)
        expect(subject.save).to eq true
      end

      it 'allows creating a cost that has the same date as the ending date of the budget period' do
        subject = build(:cost, date: '31-01-2010', budget: current_budget)
        expect(subject.save).to eq true
      end
    end

    context "date not within the current budget's period range" do
      let(:current_budget)   { create(:budget) }
      let(:subject)          { build(:cost, date: '31-12-2009', budget: current_budget) }

      it 'does not allow a cost with a invalid date(in the past)' do
        subject = build(:cost, date: '31-12-2009', budget: current_budget)
        expect(subject.save).to eq false
      end

      it 'does not allow a cost with a invalid date(in the future)' do
        subject = build(:cost, date: '01-02-2010', budget: current_budget)
        expect(subject.save).to eq false
      end
    end
  end

  describe '#formatted_date' do
    let(:cost) { create(:cost, date: '01-01-2010', budget: create(:budget)) }

    it "calls the DateFormatter with this cost's date" do
      expect(DateFormatter).to receive(:format).with(cost.date)
      cost.formatted_date
    end
  end

  describe '#formatted_error_message' do
    let(:cost) { build(:cost, date: '01-10-2010', price: nil, description: nil, budget: create(:budget)) }

    it "generates a formatted error message if the cost doesn't have all required fields set" do
      error_message = "- Description can't be blank<br />- Price can't be blank<br />- Price valid characters: 0-9<br />"
      cost.save
      expect(cost.formatted_error_message).to eq(error_message)
    end
  end
end
