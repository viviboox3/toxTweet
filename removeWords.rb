require 'lemmatizer'
require 'spreadsheet'


lem = Lemmatizer.new
common = {}

book = Spreadsheet.open 'marijuana_tweets.xls'
sheet = book.worksheet 0

sheet.each do |row|
  newStr = ""

  %w{ a and or to the is in be rt}.each{|w| common[w] = true}
  row[0].split(" ").each do |word|
    newStr += lem.lemma(word) + " "
  end
  puts newStr.gsub(/\b\w+\b/){|word| common[word.downcase] ? '':word}.squeeze(' ')

end

book.write 'modified_mari_tweets.xls'
