# Source JSON structure:
#
# {
#   "id": "USDEUR",
#   "Name": "USD/EUR",
#   "Rate": "0.8796",
#   "Date": "10/16/2015",
#   "Time": "3:38pm",
#   "Ask": "0.8796",
#   "Bid": "0.8796"
# }

class YahooRateMapper
  attr_reader :rate

  def initialize(data)
    @data = data
    @rate = Rate.new(
      rate: data['Rate'],
      ask: data['Ask'],
      bid: data['Bid'],
      from: currency_codes[0],
      to: currency_codes[1]
    )
  end

  private

  SEPARATOR = '/'

  def currency_codes
    @currency_codes ||= @data['Name'].split(SEPARATOR)
  end
end
