
require "gosu"
require "rspec/autorun"
require "byebug"
require "rubygems"
require "mini_magick"
require "gosu/all"

class SequenceGame < Gosu::Window
  
  attr_reader :image

  def initialize width=1280, height=800, fullscreen=true
    super
    

    @board = Gosu::Grid.new(self)
    @board.default_cell = Board.new(self, 0, 0)
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    
  end

  def draw
    @board.draw 
  end
end

class Board < Gosu::Grid::Cell
  def size
    tile.width

  end

  def tile
    @tile ||= Gosu::Image.new(window, 'PNG-cards-1.3/10_of_clubs.png', true)
  end
end




class Card
  
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value 
  end

  def to_s
    
   "#{@value}-#{suit}"
    
  end

end

class Deck
  attr_reader :cards

  def initialize
    @cards = Deck.build_cards
  end

  def self.build_cards
    cards = []
      2.times do
       [:clubs, :diamonds, :hearts, :spades].each do |suit|
      
          (1..10).each do |number|
          cards << Card.new(suit, number).to_s
        end
        ["j", "q", "k"].each do |facecard|
          cards << Card.new(suit, facecard).to_s
        end
      end
    end
    cards.shuffle
  end
end

class Game
  def initialize
    @deck = Deck.new
    @player_hand1 = Hand.new
    @player_hand2 = Hand.new
    @player_hand3 = Hand.new
    @player_hand4 = Hand.new

  end
end




describe SequenceGame do

  it "should open a window" do
    SequenceGame.new.show
  end

  it "should show a title" do
    expect(SequenceGame.new.image).to_not eq(nil)
  end
  
end

describe Card do

  it "should accept suit and value when building" do
    card = Card.new(:clubs, 10)
    expect(card.value).to eq(10)
    expect(card.suit).to eq(:clubs)
  end

  it "should have a value of 4 for the 4-clubs" do
    card = Card.new(:clubs, 4)
    expect(card.value).to eq(4)
  end
  
  it "should be formatted" do
    card = Card.new(:hearts, "k")
    expect(card.to_s).to eq("k-hearts")
  end
end

describe Deck do
  
  it "should have 104 cards" do
    expect(Deck.build_cards.length).to eq(104)
  end

  it "should have 104 cards when new" do
    expect(Deck.new.cards.length).to eq(104)
  end
end



