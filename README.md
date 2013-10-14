# Grabbit

Grabbit is a simple URL scraper. 
It returns the best image(s) to represent the content on a given web page. 
Grabbit also returns a Title, and a Description for the page.

This Gem was inspired by Facebook: When you share a URL on Facebook in a post, FB goes off in the background and pulls the title, description, and best thumbnail image(s) to accompany your post. 

This gem is a simple scraper to do the same. Have fun using it in your Rails App!

## Installation

Add this line to your application's Gemfile:

    gem 'grabbit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grabbit

## Usage
		
Call Grabbit, with a remote URL to scrape:
		
		scrape = Grabbit.url("http://www.google.com/")

Display the page's Title:
		
		scrape.title 
		 => "Google"

Display the page's Description:
		
		scrape.description 
		 => "Search the world's information, including webpages, images, videos and
		 more. Google has many special features to help you find exactly what you're looking for."

Array of image URLs from the page. (In this example there is only one, but some pages may have several suitable images):
		
		scrape.images 
		 => ["http://www.google.com/intl/en_ALL/images/srpr/logo1w.png"]
		
URL of the first image:

		scrape.images.first 
		 => "http://www.google.com/intl/en_ALL/images/srpr/logo1w.png"

Loop through all images:

		scrape.images.each do |img|
			puts img
		end
		 => "http://www.google.com/intl/en_ALL/images/srpr/logo1w.png"		

Failure:
	
		scrape = Grabbit.url("this is an invalid url")
		
		scrape
			=> nil	

		scrape = Grabbit.url("http://www.this-is-a-valid-url-but-page-exists.com")
		
		scrape
			=> nil							  

## How it works

Grabbit uses HTTParty to grab the remote page, and then uses Nokogiri to parse the document to return the data. 

#### Finding the Title of a given web page

Grabbit works on the following precedence to find the Title of the page:

> 1. Look for Facebook og:title meta-tag first. See http://ogp.me/
> 2. Look for a Twitter Card twitter:title meta-tag. See https://dev.twitter.com/docs/cards
> 3. Use the contents of the &lt;title&gt; tags.
> 4. Otherwise, return a blank string.

#### Finding the Description of a web page

Grabbit works on the following precedence to find the Description of the page:

> 1. Look for Facebook og:description meta-tag first. See http://ogp.me/
> 2. Look for a Twitter Card twitter:description meta-tag. See https://dev.twitter.com/docs/cards
> 3. Use the contents of the &lt;meta name='description'&gt; tags.
> 4. Otherwise, return a blank string.

#### Finding the Image(s) for the web page

Grabbit works on the following precedence to return an array of Image URLs:

> 1. Look for Facebook og:image meta-tag first. See http://ogp.me/
> 2. Look for a Twitter Card twitter:image:src meta-tag. See https://dev.twitter.com/docs/cards
> 3. Look for image with id of main-image or prodImage (Amazon).
> 3. Look for images within divs with id="content" excluding sidebar, comment, footer and header sections.
> 4. Look for images within the whole page excluding sidebar, comment, footer and header sections.
> 3. Find every image in the given page.

		



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
