require 'spec_helper'

describe "StaticPages" do

  let(:base_title) {"Ruby on Rails Tutorial Sample App |"}
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should_not have_title("| Home") }
    it { should have_title("Ruby on Rails Tutorial Sample App") }
  	it { should have_content('Sample App') }
  end

  describe "Help page" do

    it "should have the title 'Help'" do
      visit help_path
      expect(page).to have_title("#{base_title} Help")
    end

  	it "should have the content 'Help'" do
  	  visit help_path
  	  expect(page).to have_content('Help')
  	end
  end

  describe "About page" do

    it "should have the title 'About Us'" do
      visit about_path
      expect(page).to have_title("#{base_title} About Us")
    end

  	it "should have the content 'About Us'" do
  	  visit about_path
  	  expect(page).to have_content('About Us')
  	end
  end

  describe "Contact page" do

    it "should have the title 'Contact'" do
      visit contact_path
      expect(page).to have_title("#{base_title} Contact")
    end

    it "should have the content 'Contact'" do
      visit contact_path
      expect(page).to have_content('Contact')
    end
  end
end
