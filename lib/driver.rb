require 'csv'
require 'bad_vin_error'

module RideShare
  class Driver

    attr_reader :id, :name, :vin

    def initialize driver_id, name, vin #order matches csv file
      raise BadVinError.new("invalid entry for vin; must be 17 characters and only letters or numbers. (you entered #{vin})") if vin.length != 17 || vin !~ /^[0-9A-Z]+$/

      @id = driver_id
      @name = name
      @vin = vin
    end

    def self.all (csv)
      drivers = []
      temp_csv = CSV.read(csv)
      temp_csv.shift #removes first row, which is a header row (thx, google)
      temp_csv.each do |driver|
        begin
          drivers << Driver.new(driver[0].to_i, driver[1], driver[2])
        rescue
          puts "invalid vin. dummy vin (000000000000000000) entered for driver #{driver} at line #{drivers.index(driver)} of CSV file"
        end

      end

      return drivers
      #check to make sure the entries are valid, if they are not make decisions about how to handle them
    end

    def self.find driver_id
      all_drivers = Driver.all
      return all_drivers.find { |driver| driver_id == driver.id}
    end

    def trips
      return Trip.find_trips_by_driver @id
    end

    def rating
      driver_trips = Trip.find_trips_by_driver @id
      ratings = driver_trips.map { |trip| trip.rating}
      total_rating = ratings.inject(:+).to_f
      return total_rating/driver_trips.length
      #returns average rating of those trips
    end


  end
end
