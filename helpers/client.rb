module Client

  def client
    @client ||= Harvest.client(ENV["HARVEST_DOMAIN"], ENV["HARVEST_EMAIL"], ENV["HARVEST_PASSWORD"])
  end

end
