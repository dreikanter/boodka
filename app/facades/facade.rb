class Facade
  def self.method_missing(name, options = {})
    build(name, options)
  end

  def self.build(name, options = {})
    facade(name).new.tap { |f| populate(f, options) }
  end

  def self.populate(object, options = {})
    options.each { |k, v| object.send("#{k}=", v) }
  end

  def self.facade(name)
    "#{name}_facade".classify.constantize
  end
end
