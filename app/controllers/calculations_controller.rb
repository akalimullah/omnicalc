class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]
    spaceless_text =  @text.gsub(/[\s]+/,"")
    downcase_words = @text.downcase.split(/[\s]+/)

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = spaceless_text.length

    @word_count = downcase_words.length

    @occurrences = downcase_words.count(@special_word.downcase)

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    decimal_apr = @apr / 100
    @monthly_payment = (@principal * (decimal_apr / 12)) / (1 - (1 + decimal_apr / 12) ** (-12*@years))

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])
    difference = @ending - @starting
    year_in_secs = 365*24*60*60
    week_in_secs = 7*24*60*60
    day_in_secs = 24*60*60
    hour_in_secs = 60*60

    @years = (difference / year_in_secs)

    @weeks = (difference / week_in_secs)

    @days = (difference / day_in_secs)

    @hours = (difference / hour_in_secs)

    @minutes = (difference / 60).floor

    @seconds = difference

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[@count - 1]

    @range = @maximum - @minimum

    if @count.odd? == true
      @median = @sorted_numbers[(@count / 2).floor]
    else
      @mediam = (@sorted_numbers[(@count / 2)] + @sorted_numbers[(@count / 2) - 1]) / 2
    end

    @sum = 0
    @sorted_numbers.each do |num|
      @sum += num
    end

    @mean = @sum / @count

    sse = 0
    @sorted_numbers.each do |num|
      sse += (num - @mean) ** 2
    end
    @variance = sse/@count

    @standard_deviation = @variance ** 0.5

    frequencies = {}
    @sorted_numbers.each do |num|
      frequencies[num] = @sorted_numbers.count(num)
    end
    sorted_frequencies = frequencies.sort_by{|num, frequency| frequency}

    current_index = sorted_frequencies.length - 1
    next_index = current_index - 1

    @mode = sorted_frequencies[current_index][0].to_s
    while (sorted_frequencies[current_index][1] == sorted_frequencies[next_index][1]) && (next_index >= 0)
      @mode =  @mode + ", " + sorted_frequencies[next_index][0].to_s
      current_index = next_index
      next_index = current_index - 1
    end

    render("descriptive_statistics.html.erb")
  end
end
