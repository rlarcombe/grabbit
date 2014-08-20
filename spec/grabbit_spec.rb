require 'spec_helper'

describe Grabbit do

  context "Bad urls" do

    it "should return nil for an blank url" do
      g = Grabbit.url
      expect(g).to be_nil
    end

    it "should return nil for a badly formatted url" do
      g = Grabbit.url("hello")
      expect(g).to be_nil
    end

    it "should not return nil for a good url", :vcr do
      g = Grabbit.url("http://www.google.com")
      expect(g).not_to be_nil
    end

    it "should not return nil for 404 error", :vcr do
      g = Grabbit.url("http://www.thisurldoesnotexist.com/")
      expect(g.title).to be_nil
      expect(g.description).to be_nil
      expect(g.images).to be_empty
    end

  end

  context "Title" do
    it "should return a title for a good url", :vcr do
      g = Grabbit.url("http://www.drudgereport.com")
      expect(g.title).to start_with "DRUDGE REPORT"
    end

    it "should return a title from og:title when present", :vcr do
      g = Grabbit.url("http://ogp.me/")
      expect(g.title).to eq("Open Graph protocol")
    end

    it "should return the title from the Twitter card when present", :vcr do
      g = Grabbit.url("https://dev.twitter.com/docs/cards/types/summary-card")
      expect(g.title).to eq("Summary Card")
    end

  end

  context "Description" do

    it "should return a description from og:decription present", :vcr do
      g = Grabbit.url("http://ogp.me/")
      expect(g.description).to eq("The Open Graph protocol enables any web page to become a rich object in a social graph.")
    end

    it "should return the description from the Twitter card when present", :vcr do
      g = Grabbit.url("https://dev.twitter.com/docs/cards/types/summary-card")
      expect(g.description).to eq("The Summary Card can be used for many kinds of web content, from blog posts and news articles, to products and restaurants. It is designed to give the reader a preview of the content before clicking through to your website.   The Tweet below from the United Nations (@UN) shows a Summary Card (photo and text) below the 140 characters:")
    end

    it "should return a description from description meta tags when present", :vcr do
      g = Grabbit.url("http://moz.com/learn/seo/meta-description")
      expect(g.description).to eq("Get SEO best practices for the meta description tag, including length and content.")
    end

  end

  context "Images" do
    it "should return an array", :vcr do
      g = Grabbit.url("http://www.google.com")
      expect(g.images).to be_instance_of(Array)
    end

    it "should return only images from og:image when present", :vcr do
      g = Grabbit.url("http://ogp.me/")
      expect(g.images.first).to eq("http://ogp.me/logo.png")
      expect(g.images.length).to eq(1)
    end

    it "should return images from Twitter Card when present", :vcr do
      g = Grabbit.url("http://momwitha.com/2013/08/having-fun-with-pictures-at-google-headquarters/")
      expect(g.images.first).to eq("http://momwitha.com/wp-content/uploads/2013/08/Google-Lobby-Sign.jpg")
      expect(g.images.length).to eq(1)
    end

    it "should return image with id of main-image for Amazon", :vcr do
      g = Grabbit.url("http://www.amazon.com/gp/product/0975277324")
      expect(g.images.first).to eq("http://ecx.images-amazon.com/images/I/61dDQUfhuvL._SX300_.jpg")
      expect(g.images.length).to eq(1)
    end

    it "should not throw an URI not valid error", :vcr do
      g = Grabbit.url("http://www.nigerianwatch.com/news/4844-efcc-asks-interpol-to-arrest-oil-magnate-who-fled-to-switzerland-with-politicians-cash-")
      expect{g.images}.not_to raise_exception
    end

  end
end