require 'spec_helper'

describe "Locations" do

  def create_location
    fill_in "Name", with: "Clearwater"
    fill_in "Urn", with: "g5-cl-8cz7tip-clearwater"
    click_button "Create Location"
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
        click_link "Pricing and Availability"
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
        click_link "Pricing and Availability"
        expect(page).to have_content "Tampa"
        expect(page).to have_content "g5-cl-8cz7tip-tampa"
      end
    end

    describe "without http basic auth" do
      before do
        visit edit_location_path(1)
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
        click_link "Pricing and Availability"
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



