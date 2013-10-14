require 'spec_helper'

describe Grabbit do

	context "Bad urls" do

	  it "should return nil for an blank url" do
	  	g = Grabbit.url
	  	g.should == nil
	  end

	  it "should return nil for a badly formatted url" do
	  	g = Grabbit.url("hello")
	  	g.should == nil
	  end 

	  it "should not return nil for a good url", :vcr do
	  	g = Grabbit.url("http://www.google.com")
	  	g.should_not == nil
	  end 

	end

	context "Title" do
	  it "should return a title for a good url", :vcr do
	  	g = Grabbit.url("http://www.drudgereport.com")
	  	g.title.should start_with "DRUDGE REPORT"
	  end   

	  it "should return a title from og:title when present", :vcr do
	  	g = Grabbit.url("http://ogp.me/")
	  	g.title.should == "Open Graph protocol"
	  end  

	  it "should return the title from the Twitter card when present", :vcr do
	  	g = Grabbit.url("https://dev.twitter.com/docs/cards/types/summary-card")
	  	g.title.should == "Summary Card"
	  end  

  end

	context "Description" do

	  it "should return a description from og:decription present", :vcr do
	  	g = Grabbit.url("http://ogp.me/")
	  	g.description.should == "The Open Graph protocol enables any web page to become a rich object in a social graph."  	
	  end  

	  it "should return the description from the Twitter card when present", :vcr do
	  	g = Grabbit.url("https://dev.twitter.com/docs/cards/types/summary-card")
	  	g.description.should == "The Summary Card can be used for many kinds of web content, from blog posts and news articles, to products and restaurants.   The screenshot below shows the expanded Tweet view for a New York Times article:"
	  end 

	  it "should return a description from description meta tags when present", :vcr do
	  	g = Grabbit.url("http://moz.com/learn/seo/meta-description")
	  	g.description.should == "Get SEO best practices for the meta description tag, including length and content."
	  end  

  end

  context "Images" do
	  it "should return an array", :vcr do
	  	g = Grabbit.url("http://www.google.com")
	  	g.images.is_a?(Array).should be_true
	  end 

	  it "should return only images from og:image when present", :vcr do
	  	g = Grabbit.url("http://ogp.me/")
	  	g.images.first.should == "http://ogp.me/logo.png"
	  	g.images.length.should == 1
	  end 

	  it "should return images from Twitter Card when present", :vcr do
	  	g = Grabbit.url("http://momwitha.com/2013/08/having-fun-with-pictures-at-google-headquarters/")
	  	g.images.first.should == "http://momwitha.com/wp-content/uploads/2013/08/Google-Lobby-Sign-300x200.jpg"
	  	g.images.length.should == 12
	  end 

	  it "should return image with id of main-image for Amazon", :vcr do
	  	g = Grabbit.url("http://www.amazon.com/gp/product/0975277324")
	  	g.images.first.should == "http://ecx.images-amazon.com/images/I/61dDQUfhuvL._SX300_.jpg"
	  	g.images.length.should == 1
	  end	 
  end
end