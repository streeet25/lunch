require 'spec_helper'

describe 'Order', type: :feature do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:order) { FactoryGirl.create(:order) }

  feature 'Order index' do
    before do
      login(admin.email, admin.password)
      visit '/admins/orders'
    end

    it { expect(page).to have_content('Orders') }

    scenario 'filling date with invalid information' do
      day = Date.today
      fill_in 'q[created_at_casted_date_equals]', with: day.strftime('%Y.%m,%d')
      click_button 'Search'

      expect(page).to have_content admin.first_name
    end

    scenario 'filling date with invalid information' do
      fill_in 'q[user_first_name_cont]', with: 'Jhon Cena'
      click_button 'Search'

      expect(page).to have_content('No orders')
      expect(current_path).to eql('/admins/orders')
    end

    scenario 'when destroy order' do
      expect { find('.btn-danger').click }.to change(Order, :count).by(-1)

      expect(page).to have_content 'Order was successfully destroyed.'
      expect(current_path).to eql('/admins/orders')
    end
  end
end
