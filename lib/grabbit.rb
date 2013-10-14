require "grabbit/version"
require "grabbit/scrape"
require "grabbit/configuration"

module Grabbit
  extend self

	def url(url = "")
    Grabbit::Scrape.new(url) if url =~ URI::regexp(%w(http https))
  end
end
