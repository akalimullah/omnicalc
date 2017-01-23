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

    @years = (difference / year_in_secs).floor
    remainder = difference % year_in_secs

    @weeks = (remainder / week_in_secs).floor
    remainder = remainder % week_in_secs

    @days = (remainder / day_in_secs).floor
    remainder = remainder % day_in_secs

    @hours = (remainder / hour_in_secs).floor
    remainder = remainder % hour_in_secs

    @minutes = (remainder / 60).floor
    remainder = remainder % 60

    @seconds = remainder

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = "Replace this string with your answer."

    @count = "Replace this string with your answer."

    @minimum = "Replace this string with your answer."

    @maximum = "Replace this string with your answer."

    @range = "Replace this string with your answer."

    @median = "Replace this string with your answer."

    @sum = "Replace this string with your answer."

    @mean = "Replace this string with your answer."

    @variance = "Replace this string with your answer."

    @standard_deviation = "Replace this string with your answer."

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
