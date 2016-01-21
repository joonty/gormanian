class Date
  def to_gor
    Gormanian::Date.from_gregorian_date(self)
  end

  alias_method :to_gormanian, :to_gor
end

module Gormanian
  class Date
    attr_reader :year, :day_of_year, :intermission

    alias_method :intermission?, :intermission
    alias_method :yday, :day_of_year
    alias_method :===, :==

    DAYS_IN_MONTH = 28
    INTERMISSION_DAYS = [365, 366]

    MONTHS = %w(
      March
      April
      May
      June
      Quintilis
      Sextilis
      September
      October
      November
      December
      January
      February
      Gormanuary
    )

    DAYS = %w(
      Sunday
      Monday
      Tuesday
      Wednesday
      Thursday
      Friday
      Saturday
    )

    def self.today
      from_gregorian_date(::Date.today)
    end

    def self.from_gregorian_date(date)
      new(date.year, date.yday)
    end

    def self.ymd(year, month, day)
      day_of_year = (month - 1) * DAYS_IN_MONTH + day
      new(year, day_of_year)
    end

    def initialize(year, day_of_year)
      @year = year
      @day_of_year = day_of_year
      @intermission = INTERMISSION_DAYS.include?(day_of_year)
    end

    def leap?
      year % 4 == 0
    end

    def days_in_year
      leap? ? 366 : 365
    end

    def day
      intermission_or {
        rem = day_of_year % DAYS_IN_MONTH
        rem == 0 ? DAYS_IN_MONTH : rem
      }
    end

    def day_name
      intermission_or { DAYS[(day % 7) - 1] }
    end

    DAYS.each do |day|
      define_method "#{day}?".downcase.to_sym do
        day_name == day
      end
    end

    def month
      intermission_or { (day_of_year / DAYS_IN_MONTH.to_f).ceil }
    end

    def month_name
      intermission_or { MONTHS[month - 1] }
    end

    def ==(date)
      raise "Cannot make comparison of Gorman::Date to #{date.class.name}" unless date.respond_to?(:yday)
      date.yday == yday
    end

    def to_s
      if intermission?
        "Intermission, #{year}"
      else
        "#{day} #{month_name}, #{year}"
      end
    end

    def +(number_of_days)
      new_yday = number_of_days + yday
      if new_yday > days_in_year
        self.class.new(year + 1, new_yday - days_in_year)
      else
        self.class.new(year, yday + number_of_days)
      end
    end

    protected
    def intermission_or
      if intermission?
        :intermission
      else
        yield
      end
    end
  end
end
