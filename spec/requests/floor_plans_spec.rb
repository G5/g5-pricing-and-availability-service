require 'spec_helper'

describe "Floor Plans" do

  def create_location
    visit locations_path
    click_link "New Location"
    fill_in "location_name", with: "Clearwater"
    fill_in "Urn", with: "g5-cl-8cz7tip-clearwater"
    click_button "Create Location"
  end

  def create_floor_plan
    click_link "Create New Floor Plan"
    fill_in "Title", with: "Cedar Point"
    fill_in "Beds", with: "3"
    fill_in "Baths", with: "2"
    fill_in "Size", with: "1400"
    fill_in "Price", with: "1600"
    click_button "Create Floor plan"
  end

  def drag_and_drop(source, target)
    builder = page.driver.browser.action
    source = source.native
    target = target.native

    builder.click_and_hold source
    builder.move_to        target, 1, 11
    builder.move_to        target
    builder.release        target
    builder.perform
  end

  describe "Floor plans index" do
    describe "with http basic auth" do
      before do
        http_login
        create_location
        create_floor_plan
      end

      it "has location floor plans heading" do
        expect(page).to have_content "Clearwater Floor Plans"
      end

      it "shows all floor plans" do
        expect(page).to have_content "Cedar Point"
        expect(page).to have_content "3"
      end

      it "shows check availability link when none entered" do
        expect(page).to have_content "Check Availability"
      end

      it "shows # available link when entered" do
        click_link "Edit Location and Floor Plans"
        within "#edit_floor_plan_1" do
          fill_in "Available now", with: "2"
        end
        expect(page).to have_content "  Available"
      end
    end

    describe "without http basic auth" do
      before do
        visit root_path
      end

      it "doesnt show all floor plans" do
        expect(page).to have_content "HTTP Basic: Access denied."
      end
    end
  end

  describe "New Floor Plan" do
    describe "with http basic auth" do
      before do
        http_login
        create_location
      end

      it "has new floor plan heading" do
        expect(page).to have_content "New Floor Plan"
      end

      it "lets me create a new floor plan" do
        create_floor_plan
        expect(page).to have_content "Cedar Point"
        expect(page).to have_content "1400"
      end
    end

    describe "without http basic auth" do
      before do
        @location = Location.create! "urn" => "g5-cl-6cx7rin-hollywood", "name" => "Hollywood"
        visit location_path(@location)
      end

      it "doesnt let me create a new floor plan" do
        click_link "Create New Floor Plan"
        expect(page).to have_content "HTTP Basic: Access denied."
      end
    end
  end

  describe "Edit Floor Plan" do
    describe "with http basic auth" do
      before do
        http_login
        create_location
        create_floor_plan
        click_link "Edit Location and Floor Plans"
      end

      it "has edit floor plan header" do
        expect(page).to have_content "Edit Floor Plans"
      end

      it "has form filled in with floor plan data" do
        expect(page).to have_field("floor_plan[title]", with: "Cedar Point")
        expect(page).to have_field("floor_plan[beds]", with: "3")
      end

      it "can edit a floor plan" do
        fill_in "Title", with: "Mountain Ridge"
        fill_in "Size", with: "1650"
        click_button "Update Floor plan"
        expect(page).to have_content "Mountain Ridge"
        expect(page).to have_content "1650"
      end
    end

    describe "without http basic auth" do
      before do
        @location = Location.create! "urn" => "g5-cl-6cx7rin-hollywood", "name" => "Hollywood"
        visit edit_location_path(@location)
      end

      it "cannot edit a floor plan" do
        expect(page).to have_content "HTTP Basic: Access denied."
      end
    end
  end

  describe "Destory Floor Plans" do
    describe "with http basic auth" do
      before do
        http_login
      end

      it "can destroy a floor plan" do
        create_location
        create_floor_plan
        click_link "Edit Location and Floor Plans"
        within(".edit_floor_plan") do
          click_link "Destroy"
        end
        expect(page).not_to have_content "Cedar Point"
      end
    end

    describe "without http basic auth" do
      before do
        @location = Location.create! "urn" => "g5-cl-6cx7rin-hollywood", "name" => "Hollywood"
        visit edit_location_path(@location)
      end

      it "cannot destroy a floor plan" do
        expect(page).to have_content "HTTP Basic: Access denied."
      end
    end
  end

  describe "Floor plans are drag and drop sortable", js: true do
    before do
      http_login
      @location = Location.create! "urn" => "g5-cl-6cx7rin-hollywood", "name" => "Hollywood"
      @floor_plan_1 = FloorPlan.create! "location_id" => @location.id, "title" => "Unit 1"
      @floor_plan_2 = FloorPlan.create! "location_id" => @location.id, "title" => "Unit 2"
      visit location_path(@location)
    end

    it "Updates database" do
      expect(page).to have_content("Hollywood")
      within "#sortable" do
        floor_plan_1 = find('.floorplan:first-child')
        floor_plan_2 = find('.floorplan:last-child')
        expect(@floor_plan_2.row_order > @floor_plan_1.row_order).to be_true
        floor_plan_2.drag_to(floor_plan_1)
        drag_and_drop(floor_plan_1, floor_plan_2)
        sleep 1
        expect(@floor_plan_2.reload.row_order < @floor_plan_1.reload.row_order).to be_true
      end
    end
  end
end
