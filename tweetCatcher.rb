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


  book = Spreadsheet::Workbook.new
  sheet1 = book.create_worksheet
  sheet1.row(0).concat %w{tweet}
  
  collect_with_max_id do |max_id|
    break if $global_counter > 6500
    options = {:count => 200, :include_rts => false}
    options[:max_id] = max_id unless max_id.nil?
    begin
      num_attempts += 1
      client.search(cont, options).each do |result|
        break if $global_counter > 6500
        print_tweet(result, sheet1.row($global_counter))
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
  
  book.write 'marijuana_tweets.xls'

  #book.write 'marijuana-excel.xls'
end

def print_tweet(result, r)
  $global_counter += 1
  puts "#$global_counter " + result.text + "\n"
  r.push(result.text)
end

$global_counter = 1
get_all_tweets("marijuana");
