class AhController < ActionController::Base
  def index
    require 'httparty'
    require 'pp'
    require 'json'

    response = HTTParty.get('https://us.api.blizzard.com/data/wow/connected-realm/60/auctions?namespace=dynamic-us&locale=en_US&access_token=USjogZT4pFcGcY0Aro6vKKVXh0fXmjs0Ur')
    if response.code == 200
      parsed_body = JSON.parse(response.body)
      if parsed_body["auctions"]
        File.open("storage/auctions.txt", "w") do |f|
          f.puts parsed_body["auctions"]
        end
      end
      render html: "success"
    else
      render html: "fail"
    end
  end
end
