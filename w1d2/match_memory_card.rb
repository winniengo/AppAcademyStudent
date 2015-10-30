class Card
  attr_reader :value
  attr_accessor :face_down

  def initialize(value)
    @value = value
    @face_down = true
  end

  def hide
    self.face_down = true
  end

  def reveal
    self.face_down = false
  end

  def to_s
    face_down ? "[X] " : "[#{value}] "
  end

  def ==(card2)
    self.value == card2.value
  end
end
