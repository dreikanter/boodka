module PresentersHelper
  def present(object, presenter_class = nil)
    yield(presenter(object, presenter_class)) if block_given?
  end

  def presenter(object, presenter_class = nil)
    klass = presenter_class || "#{object.class}Presenter".constantize
    klass.new(object, self)
  end
end
