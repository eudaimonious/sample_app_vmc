require 'spec_helper'

describe "User pages" do

  subject { page }


  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" } 

    it { should have_content('Sign Up') }
    it { should have_title(full_title('Sign Up')) }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign Up') }
        it { should have_content('error') }
        it { should have_content("Password can't be blank") }
        it { should have_content('Password is too short (minimum is 6 characters)') }
        it { should have_content("Name can't be blank") }
        it { should have_content("Email can't be blank") }
        it { should have_content('Email is invalid') }
      end

      describe "and a bad password confirmation" do
        before do
          fill_in "Password", with: "foobar"
          fill_in "Confirmation", with: "barfoo"
          click_button submit
        end

        it { should have_content("Password confirmation doesn't match Password") }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after save the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end
end
