class AddressUri
  attr_accessor :developer, :language, :date
  def initialize
    @developer = false
    @language = ""
    @date = ""
  end

  def geenrate_address
    address = "https://github.com/trending"
    if @developer
      address = address + "/developers"
    end
    address
  end

end