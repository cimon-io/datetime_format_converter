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
    assert true, DatetimeFormatConverter.supported('qwe')
    assert true, DatetimeFormatConverter.supported('%r')
    assert true, DatetimeFormatConverter.supported('%D %T %Y')
    assert !DatetimeFormatConverter.supported('%w')
    assert !DatetimeFormatConverter.supported('%D %T %C')
    assert !DatetimeFormatConverter.supported('%%C')
    assert !DatetimeFormatConverter.supported('%N %E')
    assert !DatetimeFormatConverter.supported('%w %%%')
    assert !DatetimeFormatConverter.supported('%W sjkdf')
  end

end
