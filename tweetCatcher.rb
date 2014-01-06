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
    config.access_token = "72216027-PgIkNRazxI5Nu2cCLdrz4zLWH90FFvofnkCJvzEBs"
    config.access_token_secret = "wTuHEG4J31SBxRjG46jG07FUVOhNcEZVLfXCwoMLoSBTJ"
  end

=begin
  collect_with_max_id do |max_id|
    options = {:count => 200, :include_rts => true}
    options[:max_id] = max_id unless max_id.nil?
    client.search(tweet, options).collect do "#{tweet.text}" end
  end
=end

  tweet = client.search(cont, :count =>3, :result_type => "recent").collect
  puts "#{tweet.text}"
end


get_all_tweets("marijuana");
