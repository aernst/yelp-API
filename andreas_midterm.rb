# Gems we worked with on the reddit API
# rest-client = is one of the many gems that does an HTTP request to an API for you. Particularly
# a "get" request, this is possible by adding a .json (like http://reddit/.json) to end of a url
# and this would return you API data


# pry - is a great gem that helps with debugging. By setting a binding.pry in your code, 
# the computer will stop reading when it reaches the line with binding.pry and turn pry on
# the pry environment is like irb where you can perform create variables or use methods. What's great
# when on binding.pry is that you can access the variables before the binding.pry line and see
# if data is being processed correctly.


# json - "Javascript Object Notation", basically turns a string of data into a JSON object/Hash
# Everytime we communicate with an API, it will always return us a string of data which isn't very useful
# by parsing or loading it into a JSON object, we can easily access the data by using the key, value pair!

# before you get started with the practice, visit yelps developer site and sign up for a API keys.
# the code below can be found here: https://github.com/Yelp/yelp-api/blob/master/v2/ruby/example.rb

require 'rubygems' #load the rubygems
require 'oauth' #this is a gem that takes care of authentication for you, this also takes care
# of the http request. Therefore, we won't be needing to require rest-client anymore.
require 'pry'
require 'json'


# authentication tokens
consumer_key = 'emYovFd_Hou1UJ4nO3G3vA'
consumer_secret = 'h4ujPpXVPik1UrWWQjXQk6g98Uo'
token = 'MRmagzDnnL_Uk4PWhEmD85JJl5UVOIl1'
token_secret = 'Na7atKGOzUZdS2d1OcApZciat64'


# this is a variable that holds the api url
api_host = 'api.yelp.com'

# consumer holds the value of the Module "Oauth" and we are creating a new instance of a Consumer
# passing in three arguments
consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})

# access_token shares a similar step to creating a new instance of a Consumer.
access_token = OAuth::AccessToken.new(consumer, token, token_secret)

# the path varialble contains the parameters when we do a query to the Yelp API. Yelp is well documented
# in this case, we are searching for restaurants in the new york location as shown below:
# path = "/v2/search?term=restaurants&location=new%20york"

# however, let's change it to San Francisco instead and we'll do that by setting it to a variable called city

# puts "What are you looking for?"
# search_term = gets.chomp.to_s
puts "What are you looking for?"
search_term = gets.chomp.to_s
search_term.gsub!(" ", "%20")


puts "In what city? Leave empty if you live in SF"
city = gets.chomp.to_s
city.gsub!(" ", "%20")
	if city = "%20" || city = nil
		city = "San%20Francisco"
	end


#city = "San+Francisco"
limit_response = 5

# notice how I added a "+" to the space, alternatively, you can use %20 as well
# you can chain parameters in yelp by adding & then the parameter. In this case, I've added a limit=1
path = "/v2/search?term=#{search_term}&location=#{city}&limit=#{limit_response}"

# response contains the value or the body of the API request. This is possible because the class
# AccessToken has a method called get which takes in an argument path and we are only getting the body
# which is the content.
response = access_token.get(path).body

# parsed is a variable that contains the JSON object of the response variable. This makes it more
# readable and accessible as compared to a string
parsed = JSON.load(response) 

#binding.pry

# Things to try:
# uncomment out binding.pry on line 67 and run this file on your terminal >> ruby sample_yelp.rb
# play around and see what the variable contains! 
# what do you see in the response variable?
# what do you see in the parsed variable?
# see how structured the data we are getting in parsed variable? Try and figure out a way to access
# the name of the business.



# the code below displays the name of the restaurant and also shows if the restaurant is current closed 
# or open.
city.gsub!("%20", " ")
puts "Below are #{limit_response} matches with #{search_term} in #{city}:" 

parsed["businesses"].each do |restaurant|
  puts "Name: " + restaurant["name"] +  " Rating:" + restaurant["rating"].to_s
end








