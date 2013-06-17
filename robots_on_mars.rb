Dir["lib/*.rb"].each {|f| require_relative  f}

@nasa_station = NasaStation.new

@nasa_station.send_all_rovers

@nasa_station.write_final_positions

