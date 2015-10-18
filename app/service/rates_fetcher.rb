class RatesFetcher
  def self.rate(from, to)
    new(from, to).fetch
  end

  attr_reader :from
  attr_reader :to

  def initialize(from, to)
    @from = from
    @to = to
  end

  def fetch
    need_to_request? ? request_current_rate : last_rate
  end

  private

  def need_to_request?
    last_rate.nil? || last_rate.expired?
  end

  def last_rate
    @last_rate ||= Rate.where(from: from, to: to).last
  end

  def request_current_rate
    Rate.cleanup
    rate = YahooRateMapper.new(load_rate_data).rate
    rate.save!
    rate
  end

  def load_rate_data
    Log.debug "loading rate #{currency_pair} from Yahoo"
    Log.debug "request url: #{request_url}"
    HTTParty.get(request_url)['query']['results']['rate']
  end

  YQL_ENDPOINT = 'http://query.yahooapis.com/v1/public/yql'

  def request_url
    [YQL_ENDPOINT, http_request_params].join('?')
  end

  def http_request_params
    request_params.map { |key, value| "#{key}=#{value}" }.join('&')
  end

  def request_params
    {
      q: yql_query,
      env: 'store://datatables.org/alltableswithkeys',
      format: 'json'
    }
  end

  def currency_pair
    [from, to].join.upcase
  end

  def yql_query
    "select * from yahoo.finance.xchange where pair in (\"#{currency_pair}\")"
  end
end
