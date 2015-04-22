require 'spec_helper'

describe FloorPlan do
  describe 'default_scope' do
    let!(:floor_plan_a) { create(:floor_plan, row_order: 2) }
    let!(:floor_plan_b) { create(:floor_plan, row_order: 1) }

    it 'sorts by row_order' do
      expect(FloorPlan.all).to eq([floor_plan_b, floor_plan_b])
    end
  end
end
