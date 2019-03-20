require 'set'
require 'mime-types'

module Plug
  extend ActiveSupport::Concern
  
  included do
    class_attribute :attachment_names
    self.attachment_names = Set.new
    include attachment_accessor_module
  end

  def self.name(file)
    file.respond_to?(:original_filename) ? file.original_filename : File.basename(file.path)
  end

  def self.size(file)
    file.respond_to?(:size) ? file.size : File.size(file)
  end
  
  def self.type(file)
    file.is_a?(Plug::IO) ? file.type : Wand.wave(file.path)
  end
  
  private
  
    def self.blank?(str)
      str.nil? || str !~ /\S/
    end
end

require 'class_methods'
require 'instance_methods'
require 'attachment_proxy'
require 'io'
