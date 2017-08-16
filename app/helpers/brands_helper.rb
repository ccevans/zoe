module BrandsHelper
  def status_for(brand)
    if brand.published_at?
      if brand.published_at > Time.zone.now
        "Scheduled"
      else
        "Published"
      end
    else
      "Draft"
    end
  end
end
