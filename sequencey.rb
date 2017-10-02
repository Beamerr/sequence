
require "gosu"
require "rspec/autorun"
require "byebug"
require "rubygems"
require "mini_magick"
require "gosu/all"



class SequenceGame < Gosu::Window
  
  attr_reader :x, :y

  def initialize width=1280, height=800, fullscreen=true
    super
   
  
    @board = []

    Dir.glob("boarddeck/*.png").each do |file|
      next if File.directory? file
      @board << Gosu::Image.new(file)
    end
    @board
    
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    
  end

  def draw
    @board.each_slice(10).to_a
      @board.each do |tile|
      tile.draw(0,0,0, scale_x = 0.3, scale_y = 0.3)
    end
    
  end

  def needs_cursor?
    true
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
  
end

describe Deck do
  
  it "should have 104 cards" do
    expect(Deck.build_cards.length).to eq(104)
  end

  it "should have 104 cards when new" do
    expect(Deck.new.cards.length).to eq(104)
  end


end


