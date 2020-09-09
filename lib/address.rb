class AddressUri
  attr_accessor :developer, :language, :date
  def initialize
    @developer = false
    @language = ""
    @date = ""
  end

  def generate_address
    address = "https://github.com/trending"
    if @developer
      address += "/developers"
    end
    if @language.size > 0
      address += "/" + @language
    end
    if @date == "week"
      address += "?since=weekly"
    elsif @date == "month"
      address += "?since=monthly"
    elsif @language.size > 0
      address += "?since=daily"
    end

    address
  end

end