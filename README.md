# Grabbit

**Grabbit** is a simple URL scraper. 
It returns the best *image* (or several images) that represents the content on a given web page. 
Grabbit also returns a *title*, and a *description* for the page.

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

		scrape = Grabbit.url("http://www.this-is-a-valid-url-but-page-does-not-exist.com")
		
		scrape
			=> nil		


#### Example: Usage with a Rails 3.2 app

In a Rails app, I recommend creating a **model** to store page scrapes in a database. Then you have a persistent store/cache of remote page scrapes, if the same url is entered more that once you can instantly return the correct results. 

Here is an example of a **Scrape** model:
```ruby
# scrape.rb
# Generate migration and model with: rails generate Scrape url:string title:string description:text images:text

class Scrape < ActiveRecord::Base
	
	attr_accessible :url

	serialize :images 	# Store images array as YAML in the database

	validates :url, presence: true, :format => URI::regexp(%w(http https))

	before_save :scrape_with_grabbit

	private

	def scrape_with_grabbit

		data = Grabbit.url(url)
		
		if data
			self.title = data.title
			self.description = data.description
			self.images = data.images
		end

	end
end

# == Schema Information
#
# Table name: scrapes
#
#  id          :integer          not null, primary key
#  url         :string(255)
#  title       :string(255)
#  description :text
#  images      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
```

Now set up a controller with just one action you can post to, then either find by the url stored in the database, or create a new scrape and perform the grabbit. Consider calling this controller with a jQuery.post() to create the scrape dynamically with javascript right as your user enters the URL.

```ruby
# scrapes_controller.rb
class ScrapesController < ApplicationController

  def create

    @scrape = Scrape.find_or_create_by_url(params[:scrape][:url])

    respond_to do |format|
      if @scrape.valid?
        format.js 										# /app/views/scrapes/create.js.erb 
        															# --> Use JS to display the preview to the user.
      else
        format.js { render "error" } 	# /app/views/scrapes/error.js.erb 
        															# --> Bad URL, Cancel the AJAX loading image or whatever...
      end
    end
  end

end
```

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
