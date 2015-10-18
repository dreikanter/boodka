class Log
  def self.debug(message = '')
    Rails.logger.debug prefix(message)
  end

  def self.info(message = '')
    Rails.logger.info prefix(message)
  end

  def self.warn(message = '')
    Rails.logger.warn prefix(message)
  end

  def self.error(message = '')
    Rails.logger.error prefix(message)
  end

  def self.fatal(message = '')
    Rails.logger.fatal prefix(message)
  end

  def self.exception(exception)
    error [exception.message, backtrace(exception)].join("\n")
  end

  def self.prefix(message)
    "-----> #{message}"
  end

  def self.backtrace(exception)
    # TODO: Consider better way to distinguish meaningful part of the backtrace
    exception.backtrace.reject { |line| line.include? 'ruby/gems' }.join("\n")
  end

  private_class_method :prefix
  private_class_method :backtrace
end
