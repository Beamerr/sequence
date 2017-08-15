require 'gosu'
require 'gosu/all'

class LiveCell < Gosu::Grid::Cell
  def size
    tiles.first.width
  end

  private

  def tiles
    @tiles ||= Gosu::Image.load_tiles(window, 'assets/10_of_clubs.png', 18, 18, true)
  end

  def object
    tiles[Gosu::milliseconds / 50 % tiles.size];
  end
end

class DeadCell < Gosu::Grid::Cell
  def size
    object.width
  end

  private

  def object
    @object ||= Gosu::Image.new(window, 'assets/queen_of_hearts.png', true)
  end
end

class GridGameExample < Gosu::Window
  def initialize
    super(540, 325, false)

    self.caption = "Gosu Grid"

    @grid = Gosu::Grid.new(self)
    @grid.default_cell = DeadCell.new(self, 0, 0)

    @live =  LiveCell.new(self, 5, 6)
    @grid.cells << @live
  end

  def needs_cursor?; true; end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  def update
    @live.left! if button_down? Gosu::KbLeft
    @live.down! if button_down? Gosu::KbDown
    @live.up! if button_down? Gosu::KbUp
    @live.right! if button_down? Gosu::KbRight
  end

  def draw
    @grid.draw && sleep(0.05)
  end
end

if __FILE__ == $PROGRAM_NAME
  GridGameExample.new.show
end