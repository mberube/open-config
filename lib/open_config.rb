require 'ostruct'

class OpenConfig < BasicObject
  def initialize
    @reserved_methods = [:set, :configure, :define_custom_method, :!, :!=, :==, :__id__, :__send__, :equals?, :instance_eval, :instance_exec]
  end
  def configure(&block)
    ::Kernel.raise 'No block given in configure method' unless block
    yield self
  end

  def set(key, value = nil, &block)
    unless block
      block = ::Proc.new {value}
    end

    if key.instance_of? ::Symbol
      define_custom_method(key, &block)
    elsif key.instance_of? ::String
      parts = key.split('.')
      c = self
      parts.slice(0, parts.count-1).each do |part|
        new_config = ::OpenConfig.new
        c.__send__(:define_custom_method, part) {new_config}
        c = c.__send__(part)
      end

      c.__send__(:define_custom_method, parts.last, &block)
    end
  end

private
  def define_custom_method(method_name, &block)
    ::Kernel.raise "Method #{method_name} is reserved" if @reserved_methods.include? method_name
    singleton_class = class << self
      self
    end

    singleton_class.send(:define_method, method_name) do
      block.call
    end
  end
end
