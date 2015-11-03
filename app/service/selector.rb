class Selector
  def self.for(object, field)
    return unless object.respond_to?(:selector)
    parts = [object.try(:selector), field].select(&:present?)
    parts.join('-').gsub('_', '-').downcase
  end
end
