require 'twitter'
require 'rubygems'
require 'spreadsheet'

# recursively get pages until receive an empty response
def collect_with_max_id(collection=[], max_id=nil, &block)
  response = yield max_id
  #puts Twitter::SearchResults.methods(false)
  collection.push(response)
  response.nil? ? collection.flatten : collect_with_max_id(collection, response.reverse_each.first.id-1, &block)
end

# ask for 200 tweets recursively until an empty response is returned by collect_with_max method
def get_all_tweets(cont)
  num_attempts = 0

  # provide authorization key/token
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = "keJ2l5mveq8uh9eL3zgVQ"
    config.consumer_secret = "iZ9poJ5MEKqv7SzV6M8aMrXgaFMlI0BWA9loDfv4fg"
    config.access_token = "72216027-XfCkzRRucHLOrEP0pCieIuaReikS5WLEUAJy9cD5G"
    config.access_token_secret = "eUmxAVeX6rD8TLMcKjEFsSFZEu3n2WreqW4nqIUmqOR20"
  end

=begin
  book = Spreadsheet::Workbook.new
  sheet1 = book.create_worksheet
  sheet1.row(0).concat %w{tweet}
  row = sheet1.row(1)
=end  

  collect_with_max_id do |max_id|
    options = {:count => 200, :include_rts => false}
    options[:max_id] = max_id unless max_id.nil?
    begin
      num_attempts += 1
      client.search(cont, options).each do |result|
        print_tweet(result)
      end
    rescue Twitter::Error::TooManyRequests => error
      if num_attempts <= 3
        sleep error.rate_limit.reset_in
        retry
      else
        raise
      end
    end
  end

  #book.write 'marijuana-excel.xls'
end

def print_tweet(result)
  $global_counter += 1
  puts "#$global_counter " + result.text + "\n"
  #row.push(result.text)
end

$global_counter = 1
get_all_tweets("marijuana");
