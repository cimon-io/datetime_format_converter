require "datetime_format_converter/version"

module DatetimeFormatConverter

  class DatetimeNotSupported < ::StandardError
  end

  FORMAT_MAPPING = [
    ["%C",       nil,      "year / 100 (round down.  20 in 2009)"],
    ["%N",       nil,      "Fractional seconds digits, default is 9 digits (nanosecond)"],
    ["%w",       nil,      "Day of the week (Sunday is 0, 0..6)"],
    ["%W",       nil,      "Week number of the year.  The week starts with Monday.  (00..53)"],
    ["%Y",       "YYYY",   "Year with century (can be negative, 4 digits at least)"],
    ["%y",       "YY",     "year % 100 (00..99)"],
    ["%m",       "MM",     "Month of the year, zero-padded (01..12)"],
    ["%_m",      "MM",     "blank-padded ( 1..12)"],
    ["%-m",      "M",      "no-padded (1..12)"],
    ["%B",       "MMMM",   "The full month name (``January'')"],
    ["%^B",      "MMMM",   "uppercased (``JANUARY'')"],
    ["%b",       "MMM",    "The abbreviated month name (``Jan'')"],
    ["%h",       "MMM",    "Equivalent to %b"],
    ["%^b",      "MMM",    "uppercased (``JAN'')"],
    ["%d",       "DD",     "Day of the month, zero-padded (01..31)"],
    ["%-d",      "D",      "no-padded (1..31)"],
    ["%e",       "DD",     "Day of the month, blank-padded ( 1..31)"],
    ["%j",       "DDDD",   "Day of the year (001..366)"],
    ["%H",       "HH",     "Hour of the day, 24-hour clock, zero-padded (00..23)"],
    ["%k",       "H",      "Hour of the day, 24-hour clock, blank-padded ( 0..23)"],
    ["%I",       "hh",     "Hour of the day, 12-hour clock, zero-padded (01..12)"],
    ["%l",       "h",      "Hour of the day, 12-hour clock, blank-padded ( 1..12)"],
    ["%P",       "a",      "Meridian indicator, lowercase (``am'' or ``pm'')"],
    ["%p",       "A",      "Meridian indicator, uppercase (``AM'' or ``PM'')"],
    ["%M",       "mm",     "Minute of the hour (00..59)"],
    ["%S",       "ss",     "Second of the minute (00..59)"],
    ["%L",       "SSS",    "Millisecond of the second (000..999)"],
    ["%z",       "Z",      "Time zone as hour and minute offset from UTC (e.g. +0900)"],
    ["%:z",      "ZZ",     "hour and minute offset from UTC with a colon (e.g. +09:00)"],
    ["%::z",     "ZZ:00",  "hour, minute and second offset from UTC (e.g. +09:00:00)"],
    ["%:::z",    "ZZ:00",  "hour, minute and second offset from UTC (e.g. +09, +09:30, +09:30:30)"],
    ["%Z",       "ZZ",     "Time zone abbreviation name"],
    ["%A",       "dddd",   "The full weekday name (``Sunday'')"],
    ["%^A",      "dddd",   "uppercased (``SUNDAY'')"],
    ["%a",       "ddd",    "The abbreviated name (``Sun'')"],
    ["%^a",      "ddd",    "uppercased (``SUN'')"],
    ["%u",       "E",      "Day of the week (Monday is 1, 1..7)"],
    ["%G",       "W",      "The week-based year"],
    ["%g",       "WW",     "The last 2 digits of the week-based year (00..99)"],
    ["%V",       "W",      "Week number of the week-based year (01..53)"],
    ["%U",       "WW",     "Week number of the year.  The week starts with Sunday.  (00..53)"],
    ["%s",       "x",      "Number of seconds since 1970-01-01 00:00:00 UTC."],
    ["%Q",       "x",      "Number of microseconds since 1970-01-01 00:00:00 UTC."],
    ["%n",       "\n",     "Newline character (\n)"],
    ["%t",       "\t",     "Tab character (\t)"],
    ["%%",       "%",      "Literal ``%'' character"],
    ["%3N",      "SSS",                             "millisecond (3 digits)"],
    ["%6N",      "SSS000",                          "microsecond (6 digits)"],
    ["%9N",      "SSS000000",                       "nanosecond (9 digits)"],
    ["%12N",     "SSS000000000",                    "picosecond (12 digits)"],
    ["%c",       "ddd MMM DD HH:mm:ss YYYY",        "date and time (%a %b %e %T %Y)"],
    ["%D",       "mm/DD/YY",                        "Date (%m/%d/%y)"],
    ["%x",       "mm/DD/YY",                        "Same as %D"],
    ["%F",       "YYYY-mm-DD",                      "The ISO 8601 date format (%Y-%m-%d)"],
    ["%v",       "DD-MMM-YYYY",                     "VMS date (%e-%b-%Y)"],
    ["%T",       "HH:mm:ss",                        "24-hour time (%H:%M:%S)"],
    ["%X",       "HH:mm:ss",                        "Same as %T"],
    ["%r",       "HH:mm:ss A",                      "12-hour time (%I:%M:%S %p)"],
    ["%R",       "HH:mm",                           "24-hour time (%H:%M)"],
    ["%+",       "ddd MMM DD HH:mm:ss ZZ YYYY",     "date(1) (%a %b %e %H:%M:%S %Z %Y)"]
  ]

  def datetime_format_to_js(source_format)
    raise DatetimeNotSupported if not_supported(source_format)
    FORMAT_MAPPING.inject(source_format) do |acc, h|
      acc.gsub(h[0], h[1])
    end
  end
  module_function :datetime_format_to_js

  def supported(source_format)
    source_format.scan(not_supported_regexp).none?
  end
  module_function :supported

  def not_supported_regexp
    Regexp.new(FORMAT_MAPPING.reject{|i|i[1]}.map(&:first).map{|i|"(#{i})"}.join("|"))
  end
  module_function :not_supported_regexp

end
