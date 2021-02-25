module Codebreaker
  class Game
    attr_reader :hints_total, :attempts_total, :hints, :have_hints, :attempts_left, :secret_code, :hints_used

    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hard: { attempts: 5, hints: 1 }
    }.freeze
    RANGE_OF_DIGITS = (1..6).freeze
    AMOUNT_DIGITS = 4
    GUESSED_SYMBOL = '+'.freeze
    NOT_GUESSED_SYMBOL = '-'.freeze

    def initialize(difficulty = :easy)
      @secret_code = generate_code
      assign_difficulty(difficulty)
      @hints = secret_code.uniq.shuffle.take(@hints_total)
      @hints_used = 0
    end

    def guess(user_value)
      @user_code = user_value.each_char.map(&:to_i)
      handle_numbers
      @attempts_left -= 1
      @round_result.empty? ? 'No matches' : @round_result
    end

    def exact_match?(guess)
      @secret_code.join == guess
    end

    def valid_answer?(user_answer)
      user_answer =~ /^[1-6]{4}$/
    end

    def handle_numbers
      uncatched_numbers = check_numbers_for_correct_position
      @round_result = GUESSED_SYMBOL * uncatched_numbers.select(&:nil?).size
      @user_code.compact.map do |number|
        next unless uncatched_numbers.compact.include?(number)

        @round_result += NOT_GUESSED_SYMBOL
        uncatched_numbers[uncatched_numbers.index(number)] = nil
      end
    end

    def take_a_hint
      @hints_used += 1
      @hints.pop
    end

    private

    def generate_code
      (1..AMOUNT_DIGITS).map { rand(RANGE_OF_DIGITS) }
    end

    def assign_difficulty(difficulty)
      @attempts_total = DIFFICULTIES.dig(difficulty, :attempts)
      @hints_total = DIFFICULTIES.dig(difficulty, :hints)
      @attempts_left = @attempts_total
    end

    def check_numbers_for_correct_position
      secret_code.map.with_index do |element, index|
        next element unless element == @user_code[index]

        @user_code[index] = nil
      end
    end
  end
end
