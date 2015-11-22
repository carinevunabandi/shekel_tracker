require 'spec_helper'

describe Category do
  let!(:category_1) { create(:category, name: 'Donations') }
  let!(:category_2) { create(:category, name: 'Transport') }
  let!(:category_3) { create(:category, name: 'Entertainment') }

  describe '.all_names' do
    it 'gets the name of all categories from the database' do
      expect(Category.all_names).to eq %w(Donations Transport Entertainment)
    end
  end
end
