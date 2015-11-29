class Selector
  def self.for(object, field = nil)
    return unless object.respond_to?(:selector)
    parts = [object.try(:selector), field].select(&:present?)
    parts.join('-').gsub('_', '-').downcase
  end

  def self.for_model(model)
    "#{model.class.name.downcase}-#{model.id}"
  end
end
