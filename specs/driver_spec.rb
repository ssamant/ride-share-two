require_relative 'spec_helper.rb'

describe "Drivers" do
  let(:drivers) {RideShare::Driver.all ../support/drivers.csv}

  describe "initialize" do

    #responds to all the arguments

  end

  describe "all" do
    it "returns an Array" do
      drivers.must_be_instance_of Array
    end

    it "everything in the Array is a Driver instance" do
      drivers.each do |driver|
        driver.must_be_instance_of RideShare::Driver
      end
    end

    it "gets everything in the csv" do
       drivers.length.must_equal 100
    end

    it "gets the first item" do
        drivers[0].name.must_equal "Bernardo Prosacco"
    end

    it "gets the last item"  do
        drivers.last.name.must_equal "Minnie Dach"
    end


    it "rescues an invalid vin and replaces with a bunch of 0000s" do
      skip
      bad_vin = RideShare::Driver.all("../support/drivers_bad.csv")

      #correct line 1: 1,Bernardo Prosacco,WBWSS52P9NEYLVDE9

    end


    describe "Error Checking" do
      #name is a string
      #rider_id is an integer
      #phone_number is ??
    end
  end

  describe "find" do

    it "returns an instance of Driver" do
      driver = RideShare::Driver.find 80
      driver.must_be_instance_of RideShare::Driver
      driver.id.must_equal 80
      driver.name.must_equal "Victoria Windler"
    end

    it "returns nil if Driver is not found" do
      driver = RideShare::Driver.find 450
      driver.must_be_instance_of NilClass
    end
  end

  describe "trips" do

    it "returns an Array of trips" do
      driver = drivers[50]
      driver.trips.must_be_instance_of Array
      driver.trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
      #all elements in Array are Trip instances
    end

    it "returns empty Array if no trips found" do
      driver = RideShare::Driver.new(607, "Ada", "617546450KABGNF98")
      driver_trips = driver.trips
      driver_trips.must_be_instance_of Array
      driver_trips.length.must_equal 0
    end

    it "finds all trips associated with the driver" do
      #all rider_ids match the rider's rider_id
      #no trips left behind
    end

  end

  describe "rating" do

    it "returns a float" do
      driver = drivers[34]
      driver.rating.must_be_instance_of Float
      driver.rating.must_be :<=, 5
      driver.rating.must_be :>=, 1
    end
  end
end
