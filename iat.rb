require 'bundler'
Bundler.require :default
require 'json'
require 'data_mapper'

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

test[1] = [
  ["good_pic", 9, "e"], ["bad_pic", 2, "i"], ["good_pic", 6, "e"], ["good_pic", 4, "e"], ["bad_pic", 6, "i"], ["bad_pic", 9, "i"], ["bad_pic", 10, "i"], ["good_pic", 8, "e"], ["good_pic", 7, "e"], ["bad_pic", 4, "i"], ["bad_pic", 3, "i"], ["good_pic", 3, "e"], ["good_pic", 2, "e"], ["bad_pic", 1, "i"], ["bad_pic", 5, "i"], ["good_pic", 10, "e"], ["bad_pic", 7, "i"], ["bad_pic", 8, "i"], ["good_pic", 1, "e"], ["good_pic", 5, "e"]
]

test[2] = [
  ["good_word", 5, "e"], ["bad_word", 9, "i"], ["bad_word", 7, "i"], ["good_word", 10, "e"], ["bad_word", 8, "i"], ["good_word", 8, "e"], ["bad_word", 2, "i"], ["bad_word", 6, "i"], ["bad_word", 10, "i"], ["good_word", 4, "e"], ["good_word", 3, "e"], ["bad_word", 3, "i"], ["bad_word", 5, "i"], ["good_word", 2, "e"], ["good_word", 7, "e"], ["good_word", 6, "e"], ["good_word", 9, "e"], ["bad_word", 1, "i"], ["good_word", 1, "e"], ["bad_word", 4, "i"]
]

test[3] = [
  ["bad_pic", 7, "i"], ["bad_word", 1, "i"], ["bad_pic", 4, "i"], ["bad_word", 4, "i"], ["bad_pic", 5, "i"], ["good_word", 8, "e"], ["good_pic", 5, "e"], ["good_word", 4, "e"], ["good_pic", 4, "e"], ["good_word", 2, "e"], ["good_pic", 8, "e"], ["bad_word", 10, "i"], ["good_pic", 1, "e"], ["bad_word", 3, "i"], ["good_pic", 3, "e"], ["good_word", 9, "e"], ["bad_pic", 2, "i"], ["bad_word", 6, "i"], ["bad_pic", 8, "i"], ["good_word", 7, "e"]
]

test[4] = [
  ["bad_pic", 8, "i"], ["bad_word", 1, "i"], ["bad_pic", 2, "i"], ["bad_word", 4, "i"], ["good_pic", 7, "e"], ["good_word", 8, "e"], ["bad_pic", 6, "i"], ["good_word", 4, "e"], ["bad_pic", 5, "i"], ["good_word", 2, "e"], ["good_pic", 1, "e"], ["bad_word", 10, "i"], ["good_pic", 4, "e"], ["bad_word", 3, "i"], ["bad_pic", 3, "i"], ["good_word", 9, "e"], ["good_pic", 2, "e"], ["bad_word", 6, "i"], ["bad_pic", 9, "i"], ["good_word", 7, "e"], ["good_pic", 3, "e"], ["good_word", 5, "e"], ["bad_pic", 7, "i"], ["bad_word", 2, "i"], ["bad_pic", 1, "i"], ["good_word", 1, "e"], ["good_pic", 5, "e"], ["good_word", 3, "e"], ["good_pic", 10, "e"], ["good_word", 6, "e"], ["good_pic", 8, "e"], ["bad_word", 5, "i"], ["good_pic", 9, "e"], ["bad_word", 9, "i"], ["bad_pic", 10, "i"], ["bad_word", 8, "i"], ["good_pic", 6, "e"], ["bad_word", 7, "i"], ["bad_pic", 4, "i"], ["good_word", 10, "e"]
]

test[5] = [
  ["bad_pic", 7, "e"], ["good_pic", 1, "i"], ["bad_pic", 4, "e"], ["good_pic", 7, "i"], ["bad_pic", 9, "e"], ["bad_pic", 3, "e"], ["bad_pic", 10, "e"], ["good_pic", 9, "i"], ["bad_pic", 1, "e"], ["bad_pic", 5, "e"], ["good_pic", 10, "i"], ["good_pic", 8, "i"], ["good_pic", 4, "i"], ["bad_pic", 8, "e"], ["bad_pic", 2, "e"], ["good_pic", 2, "i"], ["good_pic", 5, "i"], ["good_pic", 3, "i"], ["good_pic", 6, "i"], ["bad_pic", 6, "e"]
]

test[6] = [
  ["good_pic", 5, "i"], ["bad_word", 4, "i"], ["good_pic", 2, "i"], ["bad_word", 5, "i"], ["bad_pic", 4, "e"], ["bad_word", 8, "i"], ["bad_pic", 2, "e"], ["good_word", 7, "e"], ["bad_pic", 1, "e"], ["good_word", 4, "e"], ["good_pic", 7, "i"], ["bad_word", 3, "i"], ["good_pic", 4, "i"], ["bad_word", 10, "i"], ["bad_pic", 10, "e"], ["good_word", 5, "e"], ["good_pic", 9, "i"], ["bad_word", 1, "i"], ["good_pic", 6, "i"], ["good_word", 2, "e"]
]

test[7] = [
  ["good_pic", 8, "i"], ["bad_word", 4, "i"], ["good_pic", 6, "i"], ["bad_word", 5, "i"], ["bad_pic", 3, "e"], ["bad_word", 8, "i"], ["bad_pic", 4, "e"], ["good_word", 7, "e"], ["bad_pic", 2, "e"], ["good_word", 4, "e"], ["good_pic", 9, "i"], ["bad_word", 3, "i"], ["good_pic", 1, "i"], ["bad_word", 10, "i"], ["good_pic", 5, "i"], ["good_word", 5, "e"], ["bad_pic", 1, "e"], ["bad_word", 1, "i"], ["bad_pic", 6, "e"], ["good_word", 2, "e"], ["bad_pic", 5, "e"], ["good_word", 1, "e"], ["bad_pic", 10, "e"], ["good_word", 3, "e"], ["good_pic", 4, "i"], ["bad_word", 6, "i"], ["good_pic", 7, "i"], ["bad_word", 7, "i"], ["bad_pic", 7, "e"], ["bad_word", 9, "i"], ["good_pic", 10, "i"], ["bad_word", 2, "i"], ["bad_pic", 9, "e"], ["good_word", 9, "e"], ["bad_pic", 8, "e"], ["good_word", 8, "e"], ["good_pic", 3, "i"], ["good_word", 10, "e"], ["good_pic", 2, "i"], ["good_word", 6, "e"]
]

TEST_Q = {
  1 => 20,
  2 => 20,
  3 => 20,
  4 => 40,
  5 => 20,
  6 => 20,
  7 => 40
}

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

class Result
  include DataMapper::Resource
  property :id,      Serial
  property :quest,   Text
  property :results, Text
end

DataMapper.auto_upgrade!

enable :sessions
get '/' do
  haml :index
end

get '/app.js' do
  content_type "text/javascript"
  coffee :app
end

get '/test/:number' do
  session[:test] = params[:number].to_i
  session[:sub_test] = 0
  session[:test_results] = ""
  haml "test_#{params[:number]}".to_sym
end

get '/tests.json' do
  test[session[:test]].size.to_json
end

get '/next' do
  if session[:sub_test].nil? or TEST_Q[session[:test]] > session[:sub_test]
    session[:sub_test] ||= 1
    puts "Sub_test is: " + session[:sub_test].to_i.to_s
    puts "Pic is: " + test[session[:test]][session[:sub_test]-1].join(" ")
    @type, @number, @key = test[session[:test]][session[:sub_test]-1]
    @tt = TEST_Q[session[:test]]
    session[:sub_test] += 1
    haml :showcase, :layout => (request.xhr? ? false : :layout)
  elsif session[:test] == 7
    puts session[:test_results].inspect
    puts session[:quest].inspect
    Result.create(:quest => session[:quest], :results => session[:test_results])
    session.clear
    haml :index
  else
    puts "Sub_test is: " + session[:sub_test].to_i.to_s
    haml "#showcase.final\n\t%a.btn{:href => '/test/#{session[:test]+1}'}\n\t\tNext",
         :layout => (request.xhr? ? false : :layout)
  end
end

post '/quest' do
  session[:quest] = params[:quest].to_json
  puts params[:quest]
  redirect '/test/1'
end

post '/results.json' do
  session[:test_results] << request.body << "\n"
  p request.body.read.to_s
end
