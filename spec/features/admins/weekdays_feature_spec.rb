require 'spec_helper'

feature 'Weekdays' do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:weekday) { FactoryGirl.create(:weekday) }

  feature 'Weekdays index' do
    before do
      login(admin.email, admin.password)
      visit '/admins/weekdays'
    end

    it { expect(page).to have_content('Weekdays') }
    it { expect(page).to have_link('Add weekday') }

    scenario 'delete weekdayday' do
      expect { find('.btn-danger').click }.to change(Weekday, :count).by(-1)

      expect(page).to have_content 'destroyed'
      expect(current_path).to eql('/admins/weekdays')
    end
  end

  feature 'Weekday new' do
    before do
      login(admin.email, admin.password)
      visit '/admins/weekdays/new'
    end

    it { expect(page).to have_content('New weekday') }
    it { expect(page).to have_button('Save') }

    scenario 'with valid information' do
      fill_in 'weekday[name]', with: 'Monday'
      find(:xpath, "(//input[@type='checkbox'])[1]").set(true)
      expect { click_button 'Save' }.to change(Weekday, :count).by(1)

      expect(page).to have_content 'created'
      expect(current_path).to eql('/admins/weekdays')
    end

    scenario 'with invalid information' do
      expect { click_button 'Save' }.not_to change(Weekday, :count)

      expect(page).to have_content('Something goes wrong')
      expect(current_path).to eql('/admins/weekdays')
    end
  end

  feature 'Weekday edit page' do
    before do
      login(admin.email, admin.password)
      visit edit_admins_weekday_path(weekday)
    end

    it { expect(page).to have_content("Edit #{weekday.name}") }

    scenario 'with valid information' do
      click_button 'Save'

      expect(page).to have_content('Weekday was successfully updated')
      expect(current_path).to eql('/admins/weekdays')
    end

    scenario 'with invalid information' do
      fill_in 'weekday[name]', with: ''
      click_button 'Save'

      expect(page).to have_content("can't be blank")
    end
  end
end
