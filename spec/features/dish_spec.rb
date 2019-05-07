require 'rails_helper'

feature 'Dish management' do

  let(:user) { create(:user) }
  let(:dish) { create(:dish) }

  before :each do
    login user
    visit root_path
  end

  context 'for logged user' do
    scenario 'adds a new dish' do
      expect {
        click_link 'Add new dish'
        fill_in 'Name', with: 'test_dish'
        fill_in 'Details', with: 'very easy dish'
        click_button 'Submit'
      }.to change(Dish, :count).by(1)
      expect(page).to have_content 'test_dish'
      expect(page).to have_content 'Dish has been added'
    end

    context 'for private dish of current user' do
      before :each do
        @dish = create(:dish, user: user, public: false)
        click_link 'All dishes'
      end

      scenario 'shows it on the list' do
        expect(current_path).to eq dishes_path
        expect(page).to have_link "#{@dish.name}"
      end

      scenario 'shows it' do
        click_link "#{@dish.name}"
        expect(current_path).to eq dish_path(@dish)
        expect(page).to have_content "#{@dish.name}"
      end

      scenario 'edits it' do
        click_link "#{@dish.name}"
        click_link 'Edit dish'
        fill_in 'Name', with: 'edited_dish'
        click_button 'Submit'
        expect(page).to have_content 'edited_dish'
        expect(current_path).to eq dish_path(@dish)
        expect(page).to have_content 'Dish has been changed'
      end

      scenario 'clones it' do
        expect {
        click_link "#{@dish.name}"
        click_link 'Clone'
        }.to change(Dish, :count).by(1)
        expect(page).to have_content "#{Dish.last.name}"
        expect(page).to have_content 'Dish has been cloned'
      end

      scenario 'deletes it' do
        expect {
          click_link "#{@dish.name}"
          click_link 'Delete dish'
        }.to change(Dish, :count).by(-1)
        expect(current_path).to eq dishes_path
        expect(page).not_to have_content "#{@dish.name}"
      end
    end

    context 'for public dish of current user' do
      before :each do
        @dish = create(:dish, user: user)
        click_link 'All dishes'
      end

      scenario 'shows it on the list' do
        expect(current_path).to eq dishes_path
        expect(page).to have_link "#{@dish.name}"
      end

      scenario 'shows it' do
        click_link "#{@dish.name}"
        expect(current_path).to eq dish_path(@dish)
        expect(page).to have_content "#{@dish.name}"
      end

      scenario 'edits it' do
        click_link "#{@dish.name}"
        click_link 'Edit dish'
        fill_in 'Name', with: 'edited_dish'
        click_button 'Submit'
        expect(page).to have_content 'edited_dish'
        expect(current_path).to eq dish_path(@dish)
        expect(page).to have_content 'Dish has been changed'
      end

      scenario 'clones it' do
        expect {
        click_link "#{@dish.name}"
        click_link 'Clone'
        }.to change(Dish, :count).by(1)
        expect(page).to have_content "#{Dish.last.name}"
        expect(page).to have_content 'Dish has been cloned'
      end

      scenario 'deletes it' do
        expect {
          click_link "#{@dish.name}"
          click_link 'Delete dish'
        }.to change(Dish, :count).by(-1)
        expect(current_path).to eq dishes_path
        expect(page).not_to have_content "#{@dish.name}"
      end
    end

    context 'for public dish of other user' do
      before :each do
        user1 = create(:user)
        @dish = create(:dish, user: user1)
        click_link 'All dishes'
      end

      scenario 'shows it on the list' do
        expect(current_path).to eq dishes_path
        expect(page).to have_content "#{@dish.name}"
      end

      scenario 'shows it' do
        click_link "#{@dish.name}"
        expect(page).to have_content "#{@dish.name}"
      end

      scenario 'does not edit it' do
        click_link "#{@dish.name}"
        expect(page).to have_content "#{@dish.name}"
        expect(page).not_to have_link 'Edit dish'
      end

      scenario 'clones it' do
        expect {
          click_link "#{@dish.name}"
          click_link 'Clone'
        }.to change(Dish, :count).by(1)
        expect(page).to have_content "#{Dish.last.name}"
        expect(page).to have_content 'Dish has been cloned'
      end

      scenario 'does not delete it' do
        click_link "#{@dish.name}"
        expect(page).to have_content "#{@dish.name}"
        expect(page).not_to have_link 'Delete dish'
      end
    end

    context 'for private dish of other user' do
      scenario 'does not show it on the list' do
        user1 = create(:user)
        dish = create(:dish, user: user1, public: false)
        click_link 'All dishes'
        expect(page).not_to have_content "#{dish.name}"
      end

    end
  end

  context 'for logged out user' do
    before :each do
      dish
      logout
    end

    scenario 'does not show any dish' do
      visit dishes_path
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    scenario 'does not show specific dish' do
      visit dish_path(dish)
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
