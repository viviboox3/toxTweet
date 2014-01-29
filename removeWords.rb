require 'lemmatizer'
require 'spreadsheet'

$global_counter = 1

lem = Lemmatizer.new
common = {}

originalBook = Spreadsheet.open 'marijuana_tweets.xls'
originalSheet = originalBook.worksheet 0

modifiedBook = Spreadsheet::Workbook.new
modifiedSheet = modifiedBook.create_worksheet

originalSheet.each do |ori_row|
  newStr = ""

  %w{ a and or to the is in be rt}.each{|w| common[w] = true}
  ori_row[0].split(" ").each do |word|
    newStr += lem.lemma(word) + " "
  end
  newStr = newStr.downcase
  newStr = newStr.gsub(/\b\w+\b/){|word| common[word.downcase] ? '':word}.squeeze(' ')
  newStr = newStr.gsub(/\b(@\w*)\b/, '')
  newStr = newStr.gsub(/[^a-z\s]/,'')
  puts newStr
  modifiedSheet.row($global_counter).push(newStr)
  $global_counter += 1

end

modifiedBook.write 'modified_mari_tweets.xls'
