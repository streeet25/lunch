require 'spec_helper'

feature 'Users' do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:user) { FactoryGirl.create(:user, email: 'user@gmail.com') }

  feature 'Users index page' do
    before do
      login(admin.email, admin.password)
      visit '/admins/users'
    end

    it { expect(page).to have_content('Users') }

    scenario 'delete user' do
      expect { click_link('', href: admins_user_path(user)) }.to change(User, :count).by(-1)

      expect(page).to have_content 'User was successfully destroyed.'
      expect(current_path).to eql('/admins/users')
    end
  end

  feature 'Users edit page' do
    before do
      login(admin.email, admin.password)
      visit edit_admins_user_path(user)
    end

    it { expect(page).to have_content("Edit #{user.first_name}") }

    scenario 'with valid information' do
      click_button 'Save'

      expect(page).to have_content('User was successfully updated.')
      expect(current_path).to eql('/admins/users')
    end

    scenario 'with invalid information' do
      fill_in 'user[first_name]', with: ' '
      fill_in 'user[profile_attributes][last_name]', with: ' '
      click_button 'Save'

      expect(page).to have_content("can't be blank")
      expect(current_path).to eql("/admins/users/#{user.id}")
    end
  end
end
