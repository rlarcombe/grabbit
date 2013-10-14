# Grabbit

Grabbit is a simple URL scraper, to return the best Thumbnail image(s) to represent the content on the page. Grabbit also returns the page Title, and Description.
This Gem was inspired by Facebook: When you share a URL on Facebook in a post, FB goes off in the background and pulls the title, description, and best thumbnail image(s) to accompany your post. This gem is a simple scraper to do the same.

## Installation

Add this line to your application's Gemfile:

    gem 'grabbit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grabbit

## Usage
		
		# Call Grabbit, with a remote URL to scrape:
		
		scrape = Grabbit.url("https://www.google.com/")

		# Title of the remote web page:
		
		scrape.title 
		 => "Google"

		# Description of the remote web page:
		
		scrape.description 
		 => "Search the world's information, including webpages, 	images, videos and
		 more. Google has many special features to help you find exactly what you're looking for."

		# Array of full URLs of images in the remote web page (only returns best images to describe the content on the given page:
		
		scrape.images 
		 => ["http://www.google.com/intl/en_ALL/images/srpr/logo1w.png"]
		
		 # URL of first image in the array:

		scrape.images.first 
		 => "http://www.google.com/intl/en_ALL/images/srpr/logo1w.png"

## How it works

Grabbit uses HTTParty to grab the remote page, and then uses Nokogiri to parse the document to return the data. 

#### Finding the Title of a given web page

Grabbit works on the following precedence to find the Title of the page:

> 1. Look for Facebook og:title meta-tag first. See http://ogp.me/
> 2. Look for a Twitter Card twitter:title meta-tag. See https://dev.twitter.com/docs/cards
> 3. Use the contents of the <title> tags.
> 4. Otherwise, return a blank string.

#### Finding the Description of a web page

Grabbit works on the following precedence to find the Description of the page:

> 1. Look for Facebook og:description meta-tag first. See http://ogp.me/
> 2. Look for a Twitter Card twitter:description meta-tag. See https://dev.twitter.com/docs/cards
> 3. Use the contents of the <meta name='description'> tags.
> 4. Otherwise, return a blank string.

		



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
