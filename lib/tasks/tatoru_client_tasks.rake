namespace :tatoru_client do
  desc "Shows the tatoru node status"
  task :status => :environment do
    status = Tatoru::Client::Node.new.status
    status.each do |k,v|
      puts "#{k}: #{v}"
    end

    unless status['authorized'
    ]
      if Tatoru::Client.const_defined?("Engine")
        puts "The client could not authorize. Please make you have configured your api token in config/initializers/tatoru_client.rb"
      else
        puts "The client could not authorize. Please make you have configured your api token by calling Tatoru::Client::Configuration.api_token = '<your-api-key>"
      end
    end
  end
end
