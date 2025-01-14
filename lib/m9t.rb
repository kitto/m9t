#--
# Copyright (c) 2010 Joe Yates
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'

locales_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'locales'))
I18n.load_path += Dir.glob("#{ locales_path }/*.yml")
I18n.reload!

libs = %w( base direction distance i18n pressure speed temperature version )
libs.each do | library |
  require "m9t/#{ library }"
end

module M9t

  # Base class for all M9t exceptions
  class M9tError < StandardError
  end

  # Raised when a M9t class receives an unrecogized ':units' value
  class UnitError < M9tError
  end

end
