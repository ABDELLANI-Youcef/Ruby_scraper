# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/BlockNesting
# rubocop:disable Metrics/PerceivedComplexity
require_relative '../lib/scraper'
require_relative '../lib/address'

class Main
  def initialize
    @developer = false
    @address_generator = nil
    @scraper = nil
  end

  def start
    puts 'Welcome to this Github trending page scraper.'
    puts 'In this application, you can scrap the trending of Github By repository and by developer.'
    puts 'You can also specify whether you would like to use according to a specific programming language'
    puts "You can also choose if you want the trending for today, this week, or this month\n\n"
    @address_generator = AddressUri.new
    @scraper = Scraper.new
    app_loop
    puts "\n\nThanks for using our application!!!\nGoodBye"
  end

  def valid_input(valid_group, ask_reinsert)
    input = ''
    valid = false
    until valid
      input = gets.chomp
      valid = valid_group.include?(input)
      puts ask_reinsert unless valid
    end
    input
  end

  def app_loop
    terminate = false
    until terminate
      address = make_address
      if address != 'stop'
        puts "\n\nThe requested address is #{address}\n\n"
        @scraper.developer = @developer
        @scraper.request_uri = address
        @scraper.scrap_page
        display_results
      end
      puts "\n\n\nWould you like to try again"
      puts "Please type:\n'y' in order to scrap a new page \nor 'n' to leave the application"
      input = valid_input(%w[y n], "invalid input!\nPlease choose a valid input: y or n")
      terminate = input == 'n'
    end
  end

  def display_results
    puts "\n\nThe scrap has finished, you have got #{@scraper.informations.size} trend\n\n"
    puts "Would you like to display them all or only one them or quit the application ?\n1. all\n2. only one\
                                        \n3. quit the operation\
                                        \nPlease type 1,2 or 3 to select your option"

    option = valid_input(%w[1 2 3], "invalid input!\nPlease choose a valid input 1,2 or 3")
    return if option == '3'

    if option == '1'
      @scraper.informations.each_with_index do |info, index|
        puts "\nThe trend number #{index + 1}"
        info.each do |value|
          puts "#{value[0]}: #{value[1]}"
        end
      end
    else
      no_more = false
      until no_more
        total = @scraper.informations.size
        puts "\n\nPlease choose a number between 1 and #{total} to specify the order of the trend\n\n"
        input = ''
        valid = false
        until valid
          input = gets.chomp
          valid = input.to_i >= 1 && input.to_i <= total
          puts "invalid input!\nPlease choose a valid number between: 1 and #{total}" unless valid
        end
        order = input.to_i
        @scraper.informations[order - 1].each do |value|
          puts "#{value[0]} : #{value[1]}"
        end
        puts "\n\n\nWould you like to display other result\nPlease type 'y' "\
                      'in order to display another trend or n otherwise'
        input = valid_input(%w[y n], "invalid input!\nPlease choose a valid input: y or n")
        no_more = input == 'n'
      end
    end
  end

  def make_address
    puts 'Would you like to scrape the page the page of trending of repositories or of developers?'
    puts "1. Repositories\n2. Developers\n3. Stop the operation\nPlease type 1 or 2 to"\
          "choose the page to scrape choose the page to scrape or 3 to stop the scraping operation\n"
    input = valid_input(%w[1 2 3], "invalid input!\nPlease choose valid input 1, 2 or 3")

    return 'stop' if input == '3'

    @developer = input == '2'
    puts 'Would you like to choose the rending for specific language or for all languages in general'
    puts "1. All languages in general\n2. Specific language\n3. Stop the operation\n"\
                                        'Please type 1 or 2 to choose the option or '\
                                        '3 to stop the scraping operation'
    input = valid_input(%w[1 2 3], "invalid input!\nPlease choose valid input 1, 2 or 3")
    return 'stop' if input == '3'

    language = ''
    if input == '2'
      puts 'Please write the name of the language'
      language = gets.chomp.downcase
    end

    puts 'which period would you like to choose the rending for?'
    puts "1. Today\n2. This week\n3. This month\n4. Stop the operation\nPlease type 1, 2 or 3 to choose the option"
    puts ' or 4 to stop the scraping'
    input = valid_input(%w[1 2 3 4], "invalid input!\nPlease choose valid input 1, 2, 3 or 4")
    return 'stop' if input == '4'

    date = case input
           when '1'
             'today'
           when '2'
             'week'
           else
             'month'
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

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/BlockNesting
# rubocop:enable Metrics/PerceivedComplexity
