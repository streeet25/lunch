require 'spec_helper'

feature 'Products' do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:category) { FactoryGirl.create(:category) }
  let!(:product) { FactoryGirl.create(:product, category_id: category.id) }

  feature 'Products index' do
    before do
      login(admin.email, admin.password)
      visit '/admins/products'
    end

    it { expect(page).to have_content('Products') }
    it { expect(page).to have_link('Add product') }

    scenario 'delete item' do
      expect { click_link('', href: admins_product_path(product)) }.to change(Product, :count).by(-1)

      expect(page).to have_content 'Product was successfully destroyed.'
      expect(current_path).to eql('/admins/products')
    end
  end

  feature 'Products new page' do
    before do
      login(admin.email, admin.password)
      visit '/admins/products/new'
    end

    scenario 'with valid information' do
      select category.name, from: 'product[category_id]'

      fill_in 'product[name]', with: product.name
      fill_in 'product[price]', with: product.price

      expect { click_button 'Save' }.to change(Product, :count).by(1)

      expect(page).to have_content 'created'
      expect(current_path).to eql('/admins/products')
    end

    scenario 'with invalid information' do
      expect { click_button 'Save' }.not_to change(Product, :count)

      expect(page).to have_content("can't be blank")
      expect(current_path).to eql('/admins/products')
    end
  end

  feature 'Products edit page' do
    before do
      login(admin.email, admin.password)
      visit edit_admins_product_path(product)
    end

    it { expect(page).to have_content("Edit #{product.name}") }

    scenario 'with valid information' do
      select category.name, from: 'product[category_id]'
      fill_in 'product[name]', with: product.name
      fill_in 'product[price]', with: product.price
      click_button 'Save'

      expect(page).to have_content('updated')
      expect(current_path).to eql('/admins/products')
    end

    scenario 'with invalid information' do
      fill_in 'product[name]', with: ' '
      click_button 'Save'

      expect(page).to have_content("can't be blank")
      expect(current_path).to eql("/admins/products/#{product.id}")
    end
  end
end
