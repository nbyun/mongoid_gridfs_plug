require 'stringio'

module Plug
  class IO
    attr_accessor :name, :content, :type, :size

    def initialize(attrs={})
      attrs.each { |key, value| send("#{key}=", value) }
      @type ||= 'plain/text'
    end

    def content=(value)
      @io = StringIO.new(value || nil)
      @size = value ? value.size : 0
    end

    def read(*args)
      @io.read(*args)
    end

    def rewind
      @io.rewind if @io.respond_to?(:rewind)
    end

    alias path name
  end
end