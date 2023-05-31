require_relative '../nameable'
class Person < Nameable
  attr_accessor :name, :age, :rentals, :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = rand(1..100)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def of_age?
    @age >= 18
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def to_json(*args)
    {
      'type' => self.class.name,
      'id' => @id,
      'age' => @age,
      'name' => @name,
      'parent_permission' => @parent_permission
    }.to_json(*args)
  end

  private :of_age?
end
