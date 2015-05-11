require 'rails_helper'

describe Extra do
  let(:extra) { FactoryGirl.build(:extra) }

  describe 'validations' do
    it 'should require name' do 
      extra.name = nil
      expect(extra).not_to be_valid
    end
    it 'should require unique name' do
      existing_extra = FactoryGirl.create(:extra)
      extra.name = existing_extra.name
      expect(extra).not_to be_valid 
    end
  end
end