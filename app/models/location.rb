class Location < ActiveRecord::Base
  belongs_to :country
  
  def self.build(object, geo_session, ip)
    self.create(
      :lat => geo_session.lat,
      :lng => geo_session.lng,
      :country_id => Country.find_by_iso(geo_session.country_code.upcase).used_id,
      :country_code => geo_session.country_code,
      :city => geo_session.city,
      :precision => geo_session.precision,
      :locatable_id => object.id
      )
  end

end
