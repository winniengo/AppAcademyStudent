class Dog
  attr_reader :name, :owner

  def self.all
    @dogs ||= []
  end

  def initialize(params = {})
    params ||= {}
    @name, @owner = params["name"], params["owner"]
  end

  def errors
    @errors ||= []
  end

  def valid?
    unless @owner.present?
      errors << "Owner can't be blank"
      return false
    end

    unless @name.present?
      errors << "Name can't be blank"
      return false
    end
    true
  end

  def save
    return false unless valid?

    Dog.all << self
    true
  end

  def inspect
    { name: name, owner: owner }.inspect
  end
end

class DogsController < ControllerBase
  def create
    @dog = Dog.new(params["dog"])
    if @dog.save
      flash[:notice] = "Saved dog successfully"
      redirect_to "/dogs"
    else
      flash.now[:errors] = @dog.errors
      render :new
    end
  end

  def index
    raise 'Testing ExceptionMiddleware'
    @dogs = Dog.all
    render :index
  end

  def new
    @dog = Dog.new
    render :new
  end
end
