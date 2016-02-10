require 'test_helper'

class DatetimeFormatConverterTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DatetimeFormatConverter::VERSION
  end

  def test_format_mapping_is_enumerable
    assert DatetimeFormatConverter::FORMAT_MAPPING.is_a?(Enumerable)
  end

  def test_contains_error_class
    assert DatetimeFormatConverter::DatetimeNotSupportedError.new.is_a?(StandardError)
  end

  def test_test_format
    assert  DatetimeFormatConverter.supported('qwe')
    assert  DatetimeFormatConverter.supported('%r')
    assert  DatetimeFormatConverter.supported('%D %T %Y')
    assert !DatetimeFormatConverter.supported('%w')
    assert !DatetimeFormatConverter.supported('%w')
    assert !DatetimeFormatConverter.supported('%D %T %C')
    assert !DatetimeFormatConverter.supported('%%C')
    assert !DatetimeFormatConverter.supported('%N %E')
    assert !DatetimeFormatConverter.supported('%w %%%')
    assert !DatetimeFormatConverter.supported('%W sjkdf')
  end

  def test_supported_format
    assert_equal 'DD MM YY', DatetimeFormatConverter.datetime_format_to_js('%d %m %y')
    assert_equal 'ddd-EsomewordZ', DatetimeFormatConverter.datetime_format_to_js('%a-%usomeword%z')
  end

  def test_not_supported_format
    assert_raises(DatetimeFormatConverter::DatetimeNotSupportedError) { DatetimeFormatConverter.datetime_format_to_js('%w') }
    assert_raises(DatetimeFormatConverter::DatetimeNotSupportedError) { DatetimeFormatConverter.datetime_format_to_js('%w') }
    assert_raises(DatetimeFormatConverter::DatetimeNotSupportedError) { DatetimeFormatConverter.datetime_format_to_js('%D %T %C') }
    assert_raises(DatetimeFormatConverter::DatetimeNotSupportedError) { DatetimeFormatConverter.datetime_format_to_js('%%C') }
    assert_raises(DatetimeFormatConverter::DatetimeNotSupportedError) { DatetimeFormatConverter.datetime_format_to_js('%N %E') }
    assert_raises(DatetimeFormatConverter::DatetimeNotSupportedError) { DatetimeFormatConverter.datetime_format_to_js('%w %%%') }
    assert_raises(DatetimeFormatConverter::DatetimeNotSupportedError) { DatetimeFormatConverter.datetime_format_to_js('%W sjkdf') }
  end

  def test_supported_timezone_format
    assert_equal 'Europe/Moscow', DatetimeFormatConverter.timezone_format_to_js('Moscow')
  end

  def test_not_supported_timezone_format
    assert_raises(DatetimeFormatConverter::DatetimeNotSupportedError) { DatetimeFormatConverter.timezone_format_to_js('Donetsk') }
  end

end
