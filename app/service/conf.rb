class Conf
  def self.base_currency
    ENV['base_currency']
  end

  def self.timezone
    ENV['timezone']
  end
end
