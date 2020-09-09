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
    puts "You can also choose if you want the trending for today, this week or this month\n\n"
    @address_generator = AddressUri.new
    @scraper = Scraper.new
    app_loop
    puts "\n\nThanks for using our application!!!\nGood Bye"
  end

  def app_loop
    terminate = false
    until terminate
      address = make_address
      puts "\n\nThe requested address is #{address}\n\n"
      @scraper.developer = @developer
      @scraper.request_uri = address
      @scraper.scrap_page
  
      puts "\n\nThe scrap has finished, you have got #{@scraper.informations.size} trend\n\n"
      puts "Would you like to display them all or only one them?\n1. all\n2. only one\nPlease type 1 or 2 to select your option"
      input = ""
      valid = false
      until valid
        input = gets.chomp
        valid = %w[1 2].include?(input)
        puts "invalid input!\nPlease choose a valid input: 1 or 2" unless valid
      end
      option = input
      if option == "1"
        @scraper.informations.each_with_index do |info , index|
          puts "\nThe trend number #{index}"
          info.each do |value|
            puts "#{value[0]}y: #{value[1]}"
          end
          
        end
      else
        no_more = false
        until no_more
          total = @scraper.informations.size
          puts "\n\nPlease choose a number between 1 and #{total} to specify the order of the trend\n\n"
          input = ""
          valid = false
          until valid
            input = gets.chomp
            valid = 1 <= input.to_i && input.to_i <= total
            puts "invalid input!\nPlease choose a valid number between: 1 and #{total}" unless valid
          end
          order = input.to_i
          @scraper.informations[order -1].each do |value|
            puts "#{value[0]} : #{value[1]}"
          end
          puts "\n\n\nWould you like to display other result\nPlease type 'y' in order scrap a new page or n otherwise"
          input = ""
          valid = false
          until valid
            input = gets.chomp
            valid = %w[y n].include?(input)
            puts "invalid input!\nPlease choose a valid input: y or n" unless valid
          end
          no_more = input == "n"
        end
      end

      puts "\n\n\nWould you like to try again\nPlease type 'y' in order scrap a new page or n to leave the application"
      input = ""
      valid = false
      until valid
        input = gets.chomp
        valid = %w[y n].include?(input)
        puts "invalid input!\nPlease choose a valid input: y or n" unless valid
      end
      terminate = input == "n"
    end
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
    address
  end

end

main = Main.new
main.start
