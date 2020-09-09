class AddressUri
  attr_accessor :developer, :language, :date
  def initialize
    @developer = false
    @language = ''
    @date = ''
  end

  def generate_address
    address = 'https://github.com/trending'
    address += '/developers' if @developer
    address += '/' + @language unless @language.empty?
    if @date == 'week'
      address += '?since=weekly'
    elsif @date == 'month'
      address += '?since=monthly'
    elsif !@language.empty?
      address += '?since=daily'
    end

    address
  end
end
