require 'bundler'
Bundler.require :default
require 'json'
require 'data_mapper'
require 'dm-timestamps'

=begin
good_words = Array.new(10, 'good_word')
                  .zip((1..10).to_a)
                  .zip(Array.new(10,'e'))
                  .map(&:flatten)

good_pics_str = Array.new(10, 'good_pic')
                     .zip((1..10).to_a)
                     .zip(Array.new(10,'e'))
                     .map(&:flatten)

good_pics_inv = good_pics_str.map{|a| a[2] = 'i';a}

bad_words  = Array.new(10, 'bad_word')
                  .zip((1..10).to_a)
                  .zip(Array.new(10,'i'))
                  .map(&:flatten)

bad_pics_str = Array.new(10, 'bad_pic')
                    .zip((1..10).to_a)
                    .zip(Array.new(10,'i'))
                    .map(&:flatten)

bad_pics_inv = bad_pics_str.map{|a| a[2] = 'e';a}

test = []

# First test
test[1] = (good_pics_str + bad_pics_str).shuffle

# Test 2
test[2] = (good_words + bad_words).shuffle

# Test 3
words_it = (good_words + bad_words).shuffle.each
test[3] = (good_pics_str + bad_pics_str)
            .shuffle.shuffle.shuffle
            .inject([]){|a,n| a<<n; a<<words_it.next; a}
            .first(20)

# Test 4
words_it.rewind
test[4] = (good_pics_str + bad_pics_str).shuffle.shuffle.shuffle.inject([]){|a,n| a<<n; a<<words_it.next; a}

# Test 5
test[5] = (good_pics_inv + bad_pics_inv).shuffle.shuffle.shuffle

# Test 6
words_it = (good_words + bad_words).shuffle.shuffle.shuffle.each
test[6] = (good_pics_inv + bad_pics_inv).shuffle.shuffle.shuffle.inject([]){|a,n| a<<n; a<<words_it.next; a}.first(20)

# Test 7
words_it.rewind
test[7] = (good_pics_inv + bad_pics_inv).shuffle.shuffle.shuffle.inject([]){|a,n| a<<n; a<<words_it.next; a}

=end

test = Array.new

test[0] = [
  ["good_pic", 9, "e"], ["bad_pic", 2, "i"], ["good_pic", 6, "e"], ["good_pic", 4, "e"], ["bad_pic", 6, "i"], ["bad_pic", 9, "i"], ["bad_pic", 10, "i"], ["good_pic", 8, "e"], ["good_pic", 7, "e"], ["bad_pic", 4, "i"], ["bad_pic", 3, "i"], ["good_pic", 3, "e"], ["good_pic", 2, "e"], ["bad_pic", 1, "i"], ["bad_pic", 5, "i"], ["good_pic", 10, "e"], ["bad_pic", 7, "i"], ["bad_pic", 8, "i"], ["good_pic", 1, "e"], ["good_pic", 5, "e"]
]

test[1] = [
  ["good_word", 5, "e"], ["bad_word", 9, "i"], ["bad_word", 7, "i"], ["good_word", 10, "e"], ["bad_word", 8, "i"], ["good_word", 8, "e"], ["bad_word", 2, "i"], ["bad_word", 6, "i"], ["bad_word", 10, "i"], ["good_word", 4, "e"], ["good_word", 3, "e"], ["bad_word", 3, "i"], ["bad_word", 5, "i"], ["good_word", 2, "e"], ["good_word", 7, "e"], ["good_word", 6, "e"], ["good_word", 9, "e"], ["bad_word", 1, "i"], ["good_word", 1, "e"], ["bad_word", 4, "i"]
]

test[2] = [
  ["bad_pic", 7, "i"], ["bad_word", 1, "i"], ["bad_pic", 4, "i"], ["bad_word", 4, "i"], ["bad_pic", 5, "i"], ["good_word", 8, "e"], ["good_pic", 5, "e"], ["good_word", 4, "e"], ["good_pic", 4, "e"], ["good_word", 2, "e"], ["good_pic", 8, "e"], ["bad_word", 10, "i"], ["good_pic", 1, "e"], ["bad_word", 3, "i"], ["good_pic", 3, "e"], ["good_word", 9, "e"], ["bad_pic", 2, "i"], ["bad_word", 6, "i"], ["bad_pic", 8, "i"], ["good_word", 7, "e"]
]

test[3] = [
  ["bad_pic", 8, "i"], ["bad_word", 1, "i"], ["bad_pic", 2, "i"], ["bad_word", 4, "i"], ["good_pic", 7, "e"], ["good_word", 8, "e"], ["bad_pic", 6, "i"], ["good_word", 4, "e"], ["bad_pic", 5, "i"], ["good_word", 2, "e"], ["good_pic", 1, "e"], ["bad_word", 10, "i"], ["good_pic", 4, "e"], ["bad_word", 3, "i"], ["bad_pic", 3, "i"], ["good_word", 9, "e"], ["good_pic", 2, "e"], ["bad_word", 6, "i"], ["bad_pic", 9, "i"], ["good_word", 7, "e"], ["good_pic", 3, "e"], ["good_word", 5, "e"], ["bad_pic", 7, "i"], ["bad_word", 2, "i"], ["bad_pic", 1, "i"], ["good_word", 1, "e"], ["good_pic", 5, "e"], ["good_word", 3, "e"], ["good_pic", 10, "e"], ["good_word", 6, "e"], ["good_pic", 8, "e"], ["bad_word", 5, "i"], ["good_pic", 9, "e"], ["bad_word", 9, "i"], ["bad_pic", 10, "i"], ["bad_word", 8, "i"], ["good_pic", 6, "e"], ["bad_word", 7, "i"], ["bad_pic", 4, "i"], ["good_word", 10, "e"]
]

test[4] = [
  ["bad_pic", 7, "e"], ["good_pic", 1, "i"], ["bad_pic", 4, "e"], ["good_pic", 7, "i"], ["bad_pic", 9, "e"], ["bad_pic", 3, "e"], ["bad_pic", 10, "e"], ["good_pic", 9, "i"], ["bad_pic", 1, "e"], ["bad_pic", 5, "e"], ["good_pic", 10, "i"], ["good_pic", 8, "i"], ["good_pic", 4, "i"], ["bad_pic", 8, "e"], ["bad_pic", 2, "e"], ["good_pic", 2, "i"], ["good_pic", 5, "i"], ["good_pic", 3, "i"], ["good_pic", 6, "i"], ["bad_pic", 6, "e"]
]

test[5] = [
  ["good_pic", 5, "i"], ["bad_word", 4, "i"], ["good_pic", 2, "i"], ["bad_word", 5, "i"], ["bad_pic", 4, "e"], ["bad_word", 8, "i"], ["bad_pic", 2, "e"], ["good_word", 7, "e"], ["bad_pic", 1, "e"], ["good_word", 4, "e"], ["good_pic", 7, "i"], ["bad_word", 3, "i"], ["good_pic", 4, "i"], ["bad_word", 10, "i"], ["bad_pic", 10, "e"], ["good_word", 5, "e"], ["good_pic", 9, "i"], ["bad_word", 1, "i"], ["good_pic", 6, "i"], ["good_word", 2, "e"]
]

test[6] = [
  ["good_pic", 8, "i"], ["bad_word", 4, "i"], ["good_pic", 6, "i"], ["bad_word", 5, "i"], ["bad_pic", 3, "e"], ["bad_word", 8, "i"], ["bad_pic", 4, "e"], ["good_word", 7, "e"], ["bad_pic", 2, "e"], ["good_word", 4, "e"], ["good_pic", 9, "i"], ["bad_word", 3, "i"], ["good_pic", 1, "i"], ["bad_word", 10, "i"], ["good_pic", 5, "i"], ["good_word", 5, "e"], ["bad_pic", 1, "e"], ["bad_word", 1, "i"], ["bad_pic", 6, "e"], ["good_word", 2, "e"], ["bad_pic", 5, "e"], ["good_word", 1, "e"], ["bad_pic", 10, "e"], ["good_word", 3, "e"], ["good_pic", 4, "i"], ["bad_word", 6, "i"], ["good_pic", 7, "i"], ["bad_word", 7, "i"], ["bad_pic", 7, "e"], ["bad_word", 9, "i"], ["good_pic", 10, "i"], ["bad_word", 2, "i"], ["bad_pic", 9, "e"], ["good_word", 9, "e"], ["bad_pic", 8, "e"], ["good_word", 8, "e"], ["good_pic", 3, "i"], ["good_word", 10, "e"], ["good_pic", 2, "i"], ["good_word", 6, "e"]
]

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Result
  include DataMapper::Resource
  property :id,         Serial
  property :quest,      Text
  property :results,    Text
  property :created_at, DateTime
  property :created_on, Date
end

DataMapper.auto_upgrade!

class CoffeeHandler < Sinatra::Base
    set :views, File.join(File.dirname(__FILE__), 'public/coffee')

    get "/*.js" do
        filename = params[:splat].first
        coffee filename.to_sym
    end
end

class Array
  def mean
    val = self.select{|v| (v>=100) && (v<=3000)}
    ((val.inject(:+).to_f)/(val.size)).round(2)
  end
end

use CoffeeHandler
enable :sessions

get '/' do
  haml :index
end

get '/data' do
  Result.all.map do |r|
    begin
      lats = JSON.load(r['results'])['latencies'].map(&:mean)
      errors = JSON.load(r['results'])['errors']
      "#{r['quest']}<br/>Lat means: #{lats}<br/>Errors: #{errors}<br/>**************************<br/>"
    rescue
      "#{JSON.load(r['results'])}<br/>***********************************<br/>"
      next
    end
  end.join
end

get '/tests' do
  haml :tests
end

get '/testSequences.json' do
  test.to_json
end

post '/quest' do
  session[:quest] = params[:quest].to_json
  puts params[:quest]
  redirect '/tests'
end

post '/testResults.json' do
  p Result.create(:quest => session[:quest], :results => request.body.read.to_s)
  session.clear
end
