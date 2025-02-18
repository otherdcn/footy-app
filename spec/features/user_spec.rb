require 'rails_helper'

RSpec.feature 'User navigation', type: :feature do
  let(:user) { FactoryBot.build(:user) }

  feature 'create user' do
    scenario 'can register with email and password' do
      VCR.use_cassette("api-football/countries/all_countries") do
        visit new_user_registration_path

        fill_in 'user[email]',                    with: "test@email.com"
        fill_in 'user[password]',                 with: "password1"
        fill_in 'user[password_confirmation]',    with: "password1"

        click_on "Sign up"

        expect(page).to have_content("Welcome! You have signed up successfully.")
      end
    end
  end

  feature 'edit user' do
    let(:user) { FactoryBot.create(:user) }

    before do
      visit new_user_session_path

      fill_in 'user[email]',                    with: user.email
      fill_in 'user[password]',                 with: user.password

      click_on "Log in"
    end

    scenario "will log in first" do
      VCR.use_cassette("api-football/countries/all_countries") do
        expect(page).to have_content("Hi joe_doe")
      end
    end

    scenario 'can edit the full set of user attributes' do
      VCR.use_cassette("api-football/countries/all_countries") do
        visit edit_user_registration_url

        fill_in 'user[username]',           with: "jodo"
        fill_in 'user[favourite_team]',     with: "Hope FC"
        fill_in 'user[favourite_country]',  with: "Namibia"
        fill_in 'user[current_password]',   with: "password1"

        click_on "Update"

        expect(page).to have_content("Hi jodo")
      end
    end

    scenario "will prohibit saving if username is blank" do
      VCR.use_cassette("api-football/countries/all_countries") do
        visit edit_user_registration_url

        fill_in 'user[username]',           with: ""
        fill_in 'user[current_password]',   with: "password1"

        click_on "Update"

        expect(page).to have_content("Username can't be blank")
      end
    end
  end

  feature 'log in' do
    let(:user) { FactoryBot.create(:user) }

    scenario "will successfully login with correct credentials" do
      VCR.use_cassette("api-football/countries/all_countries") do
        visit new_user_session_path

        fill_in 'user[email]',      with: user.email
        fill_in 'user[password]',    with: user.password

        click_on "Log in"

        expect(page).to have_content("Signed in successfully.")
      end
    end

    scenario "will reject if email is incorrect" do
      VCR.use_cassette("api-football/countries/all_countries") do
        visit new_user_session_path

        fill_in 'user[email]',      with: "joey_doey@mail.com"
        fill_in 'user[password]',    with: user.password

        click_on "Log in"

        expect(page).to have_content("Invalid Email or password.")
      end
    end

    scenario "will reject if password is incorrect" do
      VCR.use_cassette("api-football/countries/all_countries") do
        visit new_user_session_path

        fill_in 'user[email]',      with: user.email
        fill_in 'user[password]',    with: "wrong_password"

        click_on "Log in"

        expect(page).to have_content("Invalid Email or password.")
      end
    end
  end

  feature 'log out' do
    let(:user) { FactoryBot.create(:user) }

    before do
      visit new_user_session_path

      fill_in 'user[email]',                    with: user.email
      fill_in 'user[password]',                 with: user.password

      click_on "Log in"
    end

    scenario "will successfully sign out" do
      VCR.use_cassette("api-football/countries/all_countries") do
        visit root_path

        click_on "Sign out"

        expect(page).to have_content("Signed out successfully.")
      end
    end
  end
end
