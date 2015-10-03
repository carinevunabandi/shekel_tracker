require 'spec_helper'

describe DateFormatter, '.format' do
  it 'returns a formatted date' do
    date = Date.parse('01-01-2010')
    expect(DateFormatter.format(date)).to eq '01-Jan-2010'
  end
end
