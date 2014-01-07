require 'twitter'

# recursively get pages of 200 tweets until receive an empty response
def collect_with_max_id(collection=[], max_id=nil, &block)
  response = yield max_id
  collection += response
  response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id-1, &block)
end

def get_all_tweets(cont)
  # provide authorization key/token
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = "keJ2l5mveq8uh9eL3zgVQ"
    config.consumer_secret = "iZ9poJ5MEKqv7SzV6M8aMrXgaFMlI0BWA9loDfv4fg"
    config.access_token = "72216027-XfCkzRRucHLOrEP0pCieIuaReikS5WLEUAJy9cD5G"
    config.access_token_secret = "eUmxAVeX6rD8TLMcKjEFsSFZEu3n2WreqW4nqIUmqOR20"
  end

  collect_with_max_id do |max_id|
    options = {:count => 200, :include_rts => true}
    options[:max_id] = max_id unless max_id.nil?
    client.search(cont, options).each do |result|
      print_tweet(result)
    end
  end
end

def print_tweet(result)
  puts result.text
end


get_all_tweets("marijuana");
