module DateBasedSelector
  include ActiveSupport::Concern

  def selector
    [self.class.name.underscore, year, month].join('-').gsub('_', '-')
  end
end
