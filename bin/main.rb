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
# example = "youcef"
# puts example[0]

element.each_with_index do |trend,index|
  trend.css('float-right').remove
  # paragraph of descroption
  description = trend.css('p').text
  
  unless description.size == 0
    description2 = ''
    j = description.size-1
    while description[j].ord ==32 do
      j -= 1
    end
    j -= 1
    i=1
    while (description[i].ord == 32) do
      i +=1
    end
    while i<=j do
      description2 << description[i]
      i +=1
    end
    description=description2
  end 
  
  # .bytes
  # owner
  title = trend.css("h1")
  title.css('svg').remove
  owner = title.css('span').text
  owner = owner.chomp
  owner2 = ""
  owner2 = owner2
  i=1
  while (owner[i].ord == 32) do
    i +=1
  end
  while i<owner.size do
    owner2 << owner[i]
    i +=1
  end
  owner = owner2
  # project title
  title.css("span").remove
  title = title.text
  
  title2 = ''
  j = title.size-1
  while title[j].ord ==32 || title[j].ord ==10 do
    j -= 1
  end
  j -= 1
  i=1
  while (title[i].ord == 32 || title[i].ord == 10) do
    i +=1
  end
  while i<=j do
    title2 << title[i]
    i +=1
  end
  title=title2
  # Programming language
  prog = trend.css("div span[itemprop='programmingLanguage']")

  # .bytes
  puts prog.text+ "==>"+index.to_s
end
