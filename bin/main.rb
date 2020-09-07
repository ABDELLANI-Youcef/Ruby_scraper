require 'nokogiri'
require 'open-uri'

# Fetch and parse HTML document
page = URI.open('https://github.com/trending')
doc = Nokogiri::HTML(page)

# title = doc.css('Box div Box-row h1')main div.Box
# element = doc.css('article h1 a')
# 
# element.css('svg').remove
element = doc.css("article")
element.each do |trend|
  trend.css('float-right').remove
  description = trend.css('p').text
  print description
end
