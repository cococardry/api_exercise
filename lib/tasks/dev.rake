namespace :dev do
  task :fetch_city => :environment do
    puts "Fetch city data..."
    response = RestClient.get "http://v.juhe.cn/weather/citys", :params => { :key => JUHE_CONFIG["api_key"] }
    data = JSON.parse(response.body)

    data["result"].each do |c|
      existing_city = City.find_by_juhe_id( c["id"] )
      if existing_city.nil?
        City.create!( :juhe_id => c["id"], :province => c["province"],
                      :city => c["city"], :district => c["district"] )
      end
    end

    puts "Total: #{City.count} cities"
  end

  task :fetch_currency => :environment do
    puts "Fetch currency data..."
    response = RestClient.get "http://op.juhe.cn/onebox/exchange/query", :params => { :key => JUHE_CONFIG["api_key_currency"] }
    data = JSON.parse(response.body)

    data["result"]["list"].each do |cr|
      # binding.pry
        Currency.create!(:currency_name => cr[0], :unit => cr[1], :spot_buying_rate => cr[2],
                         :cash_buying_rate => cr[3], :cash_selling_rate => cr[4])


    end

    puts "Total: #{Currency.count} currencies"
  end


end
