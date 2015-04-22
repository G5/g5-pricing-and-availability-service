class FloorPlan < ActiveRecord::Base
  include RankedModel
  ranks :row_order, with_same: :location_id

  belongs_to :location
  validates :location, presence: true

  default_scope { order('row_order') }
end
