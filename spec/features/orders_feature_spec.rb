require 'spec_helper'

describe 'Order', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  let!(:order) { FactoryGirl.create(:order) }

  let!(:weekday) { create(:weekday) }

  feature 'Menu page' do
    before do
      login(user.email, user.password)
      visit root_path
    end

    scenario 'check weekdays name' do
      expect(page).to have_content(weekday.name.to_s)
    end
  end

  feature 'Order index' do
    before { login(user.email, user.password) }

    scenario 'order button is inactive' do
      day = Date.today + 1.day
      visit 'users/orders/?weekday=' + day.strftime('%Y.%m.%d')

      expect(page).to_not have_link('Make order')
    end
  end
end
