require 'rspec'
require 'open-config'

describe "OpenConfig" do
  let(:config) {Open::Config::OpenConfig.new}

  it "raises if no block given to configure" do
    lambda {config.configure}.should raise_error 'No block given in configure method'
  end
  it "assigns variables" do
    config.configure { |c| c.set :abc, 1 }
    config.abc.should == 1
  end
  it "assigns variables with strings" do
    config.configure { |c| c.set 'abc', 1 }
    config.abc.should == 1
  end
  it "overrides variables" do
    config.configure { |c| c.set :abc, 1 }
    config.configure { |c| c.set :abc, 2 }
    config.abc.should == 2
  end
  it "sets variables recursively" do
    config.configure { |c| c.set 'abc.def', 1 }
    config.abc.def.should == 1
  end
  it "sets with blocks" do
    config.configure { |c| c.set(:abc) {'hello'} }
    config.abc.should == 'hello'
  end
  it "sets with blocks can reference another config" do
    config.configure do |c|
      c.set(:abc) {'hello'}
      c.set(:def) {"#{config.abc} world!"}
    end
    config.def.should == 'hello world!'
  end
  it "overrides blocks" do
    config.configure { |c| c.set(:abc) {'hello'} }
    config.configure { |c| c.set(:abc) {'world'} }
    config.abc.should == 'world'
  end
  it "overrides variables with blocks" do
    config.configure { |c| c.set(:abc, 'var') }
    config.configure { |c| c.set(:abc) {'block!'} }
    config.abc.should == 'block!'
  end
  it "overrides blocks with variables" do
    config.configure { |c| c.set(:abc) {'block!'} }
    config.configure { |c| c.set(:abc, 'var') }
    config.abc.should == 'var'
  end

  [:set, :configure, :define_custom_method, :!, :!=, :==, :__id__, :__send__, :equals?, :instance_eval, :instance_exec].each do |method| 
    it "cannot define method '#{method}'" do
      lambda { config.configure { |c| c.set(method, 1) } }.should raise_error "Method #{method} is reserved"
    end
  end
end

