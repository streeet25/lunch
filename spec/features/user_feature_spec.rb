require 'spec_helper'

describe 'User', type: :feature do
  let!(:admin) { FactoryGirl.create(:user) }
  let!(:user) { FactoryGirl.create(:user) }

  feature 'User signs up' do
    feature 'Sign in' do
      before { visit 'users/sign_in' }

      scenario 'with valid information' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'

        expect(page).to have_content 'successfully'
        expect(current_path).to eql('/')

        expect(page).to have_content(user.first_name)
        expect(page).to have_link('Выйти')
      end

      scenario 'with invalid information' do
        click_button 'Log in'

        expect(page).to have_content('Sign in Sign Up Invalid Email or password.')
        expect(current_path).to eql('/users/sign_in')
      end
    end
  end

  feature 'Sign in' do
    before { visit 'users/sign_in' }

    scenario 'with valid information' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      expect(page).to have_content 'successfully'
      expect(current_path).to eql('/')

      expect(page).to have_content(user.first_name)
      expect(page).to have_link('Выйти')
    end

    scenario 'with invalid information' do
      click_button 'Log in'

      expect(page).to have_content('Sign in Sign Up Invalid Email or password.')
      expect(current_path).to eql('/users/sign_in')
    end
  end

  feature 'Profile' do
    before do
      login(user.email, user.password)
      visit edit_users_profile_path
    end

    scenario 'check information' do
      expect(page).to have_content(user.first_name)
    end
  end

  feature 'User edit profile' do
    before (:each) do
      @user = FactoryGirl.create(:user, first_name: 'Example', email: 'example.@gmail.com', password: '123456', password_confirmation: '123456')
    end

    scenario 'update profile data with valid params' do
      login('example.@gmail.com', '123456')
      visit edit_users_profile_path(@user)
      fill_in 'Email', with: 'example.@gmail.com'
      fill_in 'user_password', with: '123456'
      fill_in 'user_password_confirmation', with: '123456'
      fill_in 'First Name', with: 'Changed first'
      fill_in 'Last name', with: 'Changed second'
      click_button 'Save'

      expect(current_path).to eql(root_path)
    end

    scenario 'update profile data with invalid password' do
      login('example.@gmail.com', '123456')
      visit edit_users_profile_path(@user)
      fill_in 'Email', with: 'example.@gmail.com'
      fill_in 'user_password', with: '123456'
      fill_in 'user_password_confirmation', with: '123'
      fill_in 'First Name', with: 'Changed first'
      fill_in 'Last name', with: 'Changed second'
      click_button 'Save'

      expect(page).to have_content("Password confirmationdoesn't match Password")
    end

    scenario 'update profile data without first name' do
      login('example.@gmail.com', '123456')
      visit edit_users_profile_path(@user)
      fill_in 'Email', with: 'example.@gmail.com'
      fill_in 'user_password', with: '123456'
      fill_in 'user_password_confirmation', with: '123'
      fill_in 'First Name', with: ''
      fill_in 'Last name', with: ''
      click_button 'Save'

      expect(page).to have_content("can't be blank")
    end
  end
end
