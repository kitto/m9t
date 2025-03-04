#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' if RUBY_VERSION < '1.9'
require 'test/unit'
require File.join(File.expand_path(File.dirname(__FILE__) + '/../lib'), 'm9t')

class TestM9tDirection < Test::Unit::TestCase
  
  def setup
    I18n.locale = :en
    M9t::Direction.reset_options!
  end

  # Basic use
  def test_degrees
    assert_equal(45, M9t::Direction.new(45).value)
  end

  # Class methods

  # Base class

  def test_measurement_name
    assert_equal('direction', M9t::Direction.measurement_name)
  end

  def test_normalize
    assert_equal(5, M9t::Direction.normalize(725))
    assert_equal(5, M9t::Direction.normalize(-355))
  end

  def test_default_options_set
    assert_not_nil(M9t::Direction.options)
  end

  def test_default_option_abbreviated
    assert(! M9t::Direction.options[:abbreviated])
  end

  def test_default_option_units
    assert_equal(:degrees, M9t::Direction.options[:units])
  end

  def test_to_degrees_identity
    assert_equal(45, M9t::Direction.degrees_to_degrees(45))
  end

  def test_degrees_to_compass
    assert_equal('N', M9t::Direction.degrees_to_compass(0))
    assert_equal('NE', M9t::Direction.degrees_to_compass(42)) # Quantizing up
    assert_equal('E', M9t::Direction.degrees_to_compass(93)) # Quantizing down
    assert_equal('ESE', M9t::Direction.degrees_to_compass(113)) # 16ths
    I18n.locale = :it
    assert_equal('O', M9t::Direction.degrees_to_compass(270))
  end

  def test_compass
    assert_equal(0, M9t::Direction.compass('N').value)
    assert_equal(247.5, M9t::Direction.compass('WSW').value)
  end

  def test_compass_to_degrees
    assert_equal(247.5, M9t::Direction.compass_to_degrees('WSW'))
  end

  # Instance methods

  def test_to_s_not_abbreviated_singular
    direction = M9t::Direction.new( 1 )

    assert_equal '1 degree', direction.to_s
    I18n.locale = :it
    assert_equal '1 grado', direction.to_s
  end

  def test_to_s_not_abbreviated_plural
    direction = M9t::Direction.new( 135 )

    assert_equal '135 degrees', direction.to_s
    I18n.locale = :it
    assert_equal '135 gradi', direction.to_s
  end

  def test_to_s_abbreviated
    direction = M9t::Direction.new( 135 )

    assert_equal '135°', direction.to_s( :abbreviated => true )
  end

  def test_compass_units
    direction = M9t::Direction.new( 225 )

    assert_equal 'SW', direction.to_s( :units => :compass )
    I18n.locale = :it
    assert_equal 'SO', direction.to_s( :units => :compass )
  end

  def test_handles_string_leading_zero
    assert_equal(10, M9t::Direction.new('010').value)
  end

end
