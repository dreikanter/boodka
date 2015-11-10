module PresentersHelper
  def present(model, presenter_class = nil)
    yield(presenter(model, presenter_class)) if block_given?
  end

  def presenter(model, presenter_class = nil)
    klass = presenter_class || "#{model.class}Presenter".constantize
    klass.new(model, self)
  end
end
