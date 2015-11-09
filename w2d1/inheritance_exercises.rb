class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss = name, title, salary, boss
  end

  def bonus(multiplier)
    bonus = salary * multiplier
  end
end

class Manager < Employee
  attr_reader :employees

  def initialize(name, salary, boss, employees)
    super(name, "Manager", salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    employee_salary = 0
    employees.each { |e| employee_salary += e.salary }
    employee_salary * multiplier
  end
end

david = Employee.new("David", "TA", 10000, "darren")
shawna = Employee.new("Shawna", "TA", 12000, "darren" )
darren = Manager.new("Darren", 78000, "ned", [david, shawna])
ned = Manager.new("Ned", 1_000_000, nil, [david, darren, shawna])

p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)
