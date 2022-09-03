require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    before do
      @user = create(:user)
    end

    context 'when user has a name' do
      it 'is valid' do
        expect(@user).to be_valid
      end
    end

    context 'when user has no name' do
      it 'is invalid' do
        @user.name = nil
        expect(@user).to_not be_valid
      end
    end
  end
end
