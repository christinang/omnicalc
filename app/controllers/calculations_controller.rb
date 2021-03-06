class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @text_no_space = @text.gsub(" ","")

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text_no_space.length

    @word_count = @text.count(" ") + 1

    @occurrences = @text.scan(@special_word).length

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @mpr = @apr / 12 / 100
    @months = @years * 12

    @monthly_payment = (@mpr * @principal * ((1 + @mpr) ** @months)) / (((1 + @mpr) ** @months) - 1)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @weeks / 52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    @median = @sorted_numbers[@count / 2]

    @sum = @numbers.sum

    @mean = @numbers.sum / @numbers.count

    def variance(list_of_numbers)
      total = 0
      @numbers.each do |number|
        total = total + ((number - @mean) ** 2)
      end
      return total / @numbers.count
    end

    @variance = variance(@numbers)

    @standard_deviation = @variance ** 0.5

    @most_frequent_num_count = 0


    @sorted_numbers.each do |num|
      if @sorted_numbers.count(num) > @most_frequent_num_count
        @most_frequent_num_count = @sorted_numbers.count(num)
        @most_frequent_num = num
      end
    end

    @mode = @most_frequent_num

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
