# encoding: utf-8

#TODO is this needed?
require 'rspec'

require_relative '../lib/internal_geocoder_query_generator.rb'

=begin
The class should generate queries to be used by the InternalGeocoder depending on the inputs.

* Different types of inputs:
  - kind: namedplace, ipaddress, postalcode, admin0, admin1
  - geometry_type: point, polygon
  - country: column, freetext

* Where queries are needed:
  - to query the data-services
  - to import results into table
=end

describe CartoDB::InternalGeocoderQueryGenerator do

  before do
    @query_gen = CartoDB::InternalGeocoderQueryGenerator.new()
  end

  describe '#dataservices_query_template' do

    it 'should return a query template suitable for <namedplace, point, freetext>' do
      query = @query_gen.dataservices_query_template
      query.should == 'WITH geo_function AS (SELECT (geocode_namedplace(Array[{cities}], null, {country})).*) SELECT q, null, geom, success FROM geo_function'
    end
  end

end