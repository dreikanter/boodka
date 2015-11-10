class BasicPresenter < SimpleDelegator
  attr_reader :model
  attr_reader :view

  def initialize(model, view)
    @model, @view = model, view
    super(@model)
  end

  def h
    @view
  end

  def not_implemented!
    throw NotImplementedError
  end
end
