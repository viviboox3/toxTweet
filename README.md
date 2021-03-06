# ToxTweet

## Description

A Ruby project to identify what features of tweets are useful for distinguishing discussions on the medical use of marijuana from the those on the recreational use of marijuana.

## Installation

* Currently working on creating a gem to handle installation.
* Requires
 * Access token, token secret, consumer key, consumer token which may be acquired from Twitter developer site.
 * ```gem install spreadsheet```
   * https://github.com/zdavatz/spreadsheet
 * ```gem install lemmatizer```
   * https://github.com/yohasebe/lemmatizer
 * ```gem install twitter```
   * https://github.com/sferik/twitter

## Testing

```sh
ruby tweetCatcher.rb
```
* returns a spreadsheet of 6,500 most recent tweets found using a query string 'marijuana.'

```sh
ruby removeWords.rb
```
* takes the spreadsheet created from ```tweetCatcher.rb``` and returns a new spreadsheet with strings lemmatized and stopwords removed.

## Examples

  n/a

## Apps Wiki

* https://github.com/viviboox3/toxTweet/wiki