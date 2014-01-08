require 'twitter'

# recursively get pages until receive an empty response
def collect_with_max_id(collection=[], max_id=nil, &block)
  response = yield max_id
  #puts Twitter::SearchResults.methods(false)
  collection.push(response)
  response.nil? ? collection.flatten : collect_with_max_id(collection, response.reverse_each.first.id-1, &block)
end

# ask for 200 tweets recursively until an empty response is returned by collect_with_max method
def get_all_tweets(cont)
  # provide authorization key/token
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = "keJ2l5mveq8uh9eL3zgVQ"
    config.consumer_secret = "iZ9poJ5MEKqv7SzV6M8aMrXgaFMlI0BWA9loDfv4fg"
    config.access_token = "72216027-XfCkzRRucHLOrEP0pCieIuaReikS5WLEUAJy9cD5G"
    config.access_token_secret = "eUmxAVeX6rD8TLMcKjEFsSFZEu3n2WreqW4nqIUmqOR20"
  end

  collect_with_max_id do |max_id|
    options = {:count => 200, :include_rts => false}
    options[:max_id] = max_id unless max_id.nil?
    client.search(cont, options).each do |result|
      print_tweet(result)
    end
  end
end

def print_tweet(result)
  puts result.text + "\n"
end


get_all_tweets("marijuana");
