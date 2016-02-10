require 'test_helper'

class DatetimeFormatConverterTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DatetimeFormatConverter::VERSION
  end

  def test_format_mapping_is_enumerable
    assert DatetimeFormatConverter::FORMAT_MAPPING.is_a?(Enumerable)
  end

  def test_contains_error_class
    assert DatetimeFormatConverter::DatetimeNotSupported.new.is_a?(StandardError)
  end

  def test_test_format
    assert true, DatetimeFormatConverter.test_format('qwe')
    assert true, DatetimeFormatConverter.test_format('%r')
    assert true, DatetimeFormatConverter.test_format('%D %T %Y')
    assert false, DatetimeFormatConverter.test_format('%D %T %C')
    assert false, DatetimeFormatConverter.test_format('%D %T %C')
    assert false, DatetimeFormatConverter.test_format('%%C')
    assert false, DatetimeFormatConverter.test_format('%N %E')
    assert false, DatetimeFormatConverter.test_format('%w %%%')
    assert false, DatetimeFormatConverter.test_format('%W sjkdf')
  end

end
