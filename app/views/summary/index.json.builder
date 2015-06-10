json.vendor_leads @locations do |l|
  json.urn l.urn
  json.name l.name
  json.created_at l.created_at
  json.updated_at l.updated_at
    l.floor_plans.each do |f|
      json.title f.title
      json.available_now f.available_now
      json.available_soon f.available_soon
      json.beds f.beds
      json.baths f.baths
      json.size f.size
      json.price f.price
      json.deposit f.deposit
      json.image_url f.image_url
      json.created_at f.created_at
      json.updated_at f.updated_at

      json.price_url f.price_url
      json.row_order f.row_order
    end
end