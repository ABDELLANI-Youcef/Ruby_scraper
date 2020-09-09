require 'nokogiri'
require 'open-uri'
require_relative '../lib/scraper'
require_relative '../lib/address'


class Main
  def initialize
    @developer = false
    @address_generator = nil
    @scraper = nil
  end

  def start
    puts "Welcome in this github trending page scraper."
    puts "In this application You can scrap the trending of github By repository and by developer."
    puts "You can also specify whether you would like to use according a specific programming language"
    puts "You can also choose if you want the trending for today, this week or this month"
    @address_generator = AddressUri.new
    @scraper = Scraper.new
    make_address
  end

  def make_address 
    puts "Would you like to scrape the page the page of trending of repositories or of developpers?"
    puts "1. Repositories\n2. Developers\nPlease type 1 or 2 to choose the page to scrape"
    input = ""
    valid = false
    until valid
      input = gets.chomp
      valid = %w[1 2].include?(input)
      puts "invalid input!\nPlease choose valid input 1 or 2" unless valid
    end
    @developer = input == '2'
    puts "Would you like to choose the rending for specific languague or for all languages in general"
    puts "1. All languages in general\n2. Specific language\nPlease type 1 or 2 to choose the option"
    input = ""
    valid = false
    until valid
      input = gets.chomp
      valid = %w[1 2].include?(input)
      puts "invalid input!\nPlease choose valid input 1 or 2" unless valid
    end
    language = ""
    if input == "2"
      puts "please write the name of the language "
      language = gets.chomp.downcase
    end

    date = ""
    puts "which period would you like to choose the rending for?"
    puts "1. Today\n2. This week\n3. This month\nPlease type 1, 2 or 3 to choose the option"
    input = ""
    valid = false
    until valid
      input = gets.chomp
      valid = %w[1 2 3].include?(input)
      puts "invalid input!\nPlease choose valid input 1, 2 or 3" unless valid
    end
    case input
    when "1"
      date = "today"
    when "2"
      date = "week"
    else
      date = "month"
    end
    @address_generator.developer = @developer
    @address_generator.language = language
    @address_generator.date = date
    address = @address_generator.generate_address
    puts address
  end

end

main = Main.new
main.start

