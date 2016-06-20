class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  #
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letters)
    raise ArgumentError if letters == nil
    letters.downcase!
    raise ArgumentError if letters.empty? || !(letters =~ /[a-z]/)
    
    if @guesses.include?(letters) || @wrong_guesses.include?(letters)
      return false
    else
      @guesses << letters if @word.include?(letters)
      @wrong_guesses << letters if !@word.include?(letters)
    end
  end
  
  def word_with_guesses ()
    disp_word = ''
    @word.each_char do |w|
      if @guesses.include?(w)
        disp_word << w
      else
        disp_word << '-'
      end
    end
    return disp_word
  end
  
  def check_win_or_lose()
    check = true
    @word.each_char do |w|
      if !@guesses.include?(w)
        check = false
      end
    end
    if check == true
      return :win
    elsif (@guesses.length+@wrong_guesses.length) < 7 && check == false
      return :play
    else
      return :lose
    end
  end
  
end

