require 'spec_helper'

describe "Locations" do

  def create_location
    fill_in "Name", with: "Clearwater"
    fill_in "Urn", with: "g5-cl-8cz7tip-clearwater"
    click_button "Create Location"
  end

  def stub_env_var(name, value)
    stub_const('ENV', ENV.to_hash.merge(name => value))
  end

  describe "Locations index" do
    describe "with http basic auth" do
      before do
        http_login
        visit locations_path
      end

      it "has locations heading" do
        expect(page).to have_content "Locations"
      end

      it "shows all locations" do
        click_link "New Location"
        create_location
        visit locations_path
        expect(page).to have_content "Clearwater"
        expect(page).to have_content "g5-cl-8cz7tip-clearwater"
      end
    end

    describe "without http basic auth" do
      before do
        visit locations_path
      end

      it "doesnt show all locations" do
        expect(page).to have_content "HTTP Basic: Access denied."
      end
    end

    it "has client apps navigation" do
      stub_env_var('CMS_URL', 'https://my-cms.example.com')
      stub_env_var('CPNS_URL', 'https://my-digits.example.com')
      stub_env_var('CXM_URL', 'https://my-cxm.example.com')
      http_login
      visit locations_path
      expect(page).to have_link("CMS", ENV['CMS_URL'])
      expect(page).to have_link("Phone Numbers", ENV['CPNS_URL'])
      expect(page).to have_link("Pricing and Availability", root_url)
      expect(page).to have_link("Customer Experience Management", ENV['CXM_URL'])
    end
  end

  describe "New Location" do
    describe "with http basic auth" do
      before do
        http_login
        visit new_location_path
      end

      it "has new location heading" do
        expect(page).to have_content "New Location"
      end

      it "lets me create a new location" do
        create_location
        expect(page).to have_content "Clearwater Floor Plans"
      end
    end

    describe "without http basic auth" do
      before do
        visit new_location_path
      end

      it "doesnt let me create a new location" do
        expect(page).to have_content "HTTP Basic: Access denied."
      end
    end
  end

  describe "Show Location" do
    before do
      @location = Location.create! "urn" => "g5-cl-6cx7rin-hollywood", "name" => "Hollywood"
      visit location_path(@location)
    end

    it "displays location" do
      expect(page).to have_content "Hollywood Floor Plans"
    end
  end

  describe "Edit Locations" do
    describe "with http basic auth" do
      before do
        http_login
        visit new_location_path
        create_location
        click_link "Edit Location and Floor Plans"
      end

      it "has edit location heading" do
        expect(page).to have_content "Edit Location"
      end

      it "has form filled in with location data" do
        expect(page).to have_field("location[name]", with: "Clearwater")
        expect(page).to have_field("location[urn]", with: "g5-cl-8cz7tip-clearwater")
      end

      it "can edit a location" do
        fill_in "Name", with: "Tampa"
        fill_in "Urn", with: "g5-cl-8cz7tip-tampa"
        click_button "Update Location"
        visit locations_path
        expect(page).to have_content "Tampa"
        expect(page).to have_content "g5-cl-8cz7tip-tampa"
      end
    end

    describe "without http basic auth" do
      before do
        @location = Location.create! "urn" => "g5-cl-6cx7rin-hollywood", "name" => "Hollywood"
        visit edit_location_path(@location)
      end

      it "cannot edit a location" do
        expect(page).to have_content "HTTP Basic: Access denied."
      end
    end
  end

  describe "Destroy Locations" do
    describe "with http basic auth" do
      before do
        http_login
        visit new_location_path
        create_location
      end

      it "can destroy a location" do
        visit locations_path
        click_link "Destroy"
        expect(page).not_to have_content "Clearwater"
      end
    end

    describe "without http basic auth" do
      before do
        visit new_location_path
      end
      it "cannot destroy a location" do
        expect(page).to have_content "HTTP Basic: Access denied."
      end
    end
  end
end
