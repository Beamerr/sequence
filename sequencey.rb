
require "gosu"
require "rspec/autorun"
require "byebug"

class SequenceGame < Gosu::Window
  
  attr_reader :image

  def initialize width=1280, height=800, fullscreen=true
    super
    self.caption = "Sequence!"

    @image = Gosu::Image.from_text self,
                    "Sequence!",
                    Gosu.default_font_name,
                    200
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    
  end

  def draw
    @image.draw self.width/2 - @image.width/2, 
                self.height/2 - @image.height/2,
                0
  end

end 

class Card
  
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value 
  end

  def to_s
    
    puts "#{@value}-#{suit}"

  end

end

class Deck
  attr_reader :cards

  def initialize
    @cards = Deck.build_cards
  end

  def self.build_cards
    cards = []
      [:clubs, :diamonds, :hearts, :spades].each do |suit|
      2.times do
          (1..10).each do |number|
          cards << Card.new(suit, number)
        end
        [:jack, :queen, :king].each do |facecard|
          cards << Card.new(suit, facecard)
        end
      end
    end
    cards.shuffle
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
    card = Card.new(:hearts, "king")
    expect(card.to_s).to eq("king-hearts")
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