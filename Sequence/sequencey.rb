
require "gosu"
require "rspec/autorun"

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

end

class Deck
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
    cards
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
    card.value.should eq(10)
    card.suit.should eq(:clubs)
  end

  it "should have a value of 4 for the 4-clubs" do
    card = Card.new(:clubs, 4)
    card.value.should eq(4)
  end
  
end

describe Deck do
  
  it "should have 104 cards" do
    expect(Deck.build_cards.length).to eq(104)
  end

  it "should have 1 to 10 and J, Q, K of each suit x 2"

  it "should have 4 suits" 

end