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

		scrape = Grabbit.url("https://github.com")

		if scrape
			scrape.title = "GitHub · Build software better, together."
			scrape.description = "Build software better, together."
			scrape.images = ["https://github.global.ssl.fastly.net/images/modules/logos_page/Octocat.png"]
			scrape.images.first = "https://github.global.ssl.fastly.net/images/modules/logos_page/Octocat.png"
		end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
