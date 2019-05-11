require 'rails_helper'

feature 'Menu management' do

  let(:user) { create(:user) }
  let(:dish) { create(:dish) }
  let(:menu_item) {create(:menu_item)}

  context 'for logged user' do
    before :each do
      login user
    end

    context 'for own dish' do
      before :each do
        @dish = create(:dish, user: user)
      end

      scenario 'adds new item to menu' do
        visit dish_path(@dish)
        expect {
          click_link 'Add to MENU'
          select('tuesday', from: 'menu_item[day]')
          select('snack', from: 'menu_item[meal]')
          click_button 'Submit'
        }.to change(MenuItem, :count).by(1)
        expect(page).to have_content 'Dish has been added to Menu'
        expect(page).to have_content "Tuesday Wednesday Thursday Friday Saturday Sunday breakfast brunch lunch snack #{@dish.name} E D dinner supper"
      end

      scenario 'edits menu' do
        menu_item = create(:menu_item, dish: @dish, user: user)
        visit '/menu'
        click_link 'E'
        expect(current_path).to eq edit_dish_menu_item_path(@dish, menu_item)
        select('friday', from: 'menu_item[day]')
        select('lunch', from: 'menu_item[meal]')
        click_button 'Submit'
        expect(current_path).to eq menu_path
        expect(page).to have_content 'Dish has been moved in Menu'
        expect(page).to have_content "Tuesday Wednesday Thursday Friday Saturday Sunday breakfast brunch lunch #{@dish.name} E D snack dinner supper"
      end

      scenario 'deletes item from menu' do
        menu_item = create(:menu_item, dish: @dish, user: user)
        visit '/menu'
        expect {
          click_link 'D'
        }.to change(MenuItem, :count).by(-1)
        expect(current_path).to eq menu_path
      end
    end

    context 'for dish of other user' do
      before :each do
        @user1 = create(:user)
        @dish = create(:dish, user: @user1)
      end

      scenario 'does not add new item to menu' do
        visit dish_path(@dish)
        expect(page).not_to have_link 'Add to MENU'
        expect {
          visit new_dish_menu_item_path(@dish)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      scenario 'does not edit menu' do
        menu_item = create(:menu_item, dish: @dish, user: @user1)
        expect {
          visit edit_dish_menu_item_path(@dish, menu_item)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

  context 'for logged out user' do
    before :each do
      dish
      logout
    end

    scenario 'does not show menu' do
      visit menu_path
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
 end
end
