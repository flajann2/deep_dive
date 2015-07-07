require 'deep_dive'

class FooBase
  include DeepDive
  exclude :c
end

class Foo < FooBase
  attr_accessor :a, :b, :c, :changeme, :h
end

class Bar < FooBase
  attr_accessor :a, :b, :c, :changeme, :h
end

class FooBar < FooBase
  attr_accessor :a, :b, :c, :changeme, :dontcopy, :arr, :hsh, :nonddob
  exclude :dontcopy
end

class FooBarFoo < FooBar
  attr_accessor :freject, :fa, :fb, :fc, :frecur, :fexcludeme
  exclude { |sym, obj|
    sym == :@fexcludeme if obj.instance_variable_defined?(:@freject) and obj.send(:freject)
  }
end

describe DeepDive do
  before(:each) do
    @foo = Foo.new
    @bar = Bar.new
    @foobar = FooBar.new
    @fbf = FooBarFoo.new

    @foobar.arr = [@foo, @bar, @foobar, "Just a string"]
    @foobar.hsh = {foo: @foo, bar: @bar, foobar: @foobar, nonddob: "just a string"}

    @foo.a = 'foo just around'
    @bar.a = 'bar hanging around'
    @foo.b = @bar
    @bar.b = @foo
    @foo.c = @bar.c = @foobar.c = @foobar
    @foo.h = @bar.h = {1 => "one", 2 => "two", 3 => "three"}
    @foo.changeme = @bar.changeme = @foobar.changeme = "initial"

    @fbf.fa = @foo
    @fbf.fb = @bar
    @fbf.fc = @foobar
    @fbf.frecur = @fbf
    @fbf.fexcludeme = Foo.new
    # DeepDive.verbose = true
  end

  context 'debugging' do
    it 'handles verbosity switching' do
      DeepDive.verbose = true
      DeepDive.verbose?.should be_true
      DeepDive.verbose = false
      DeepDive.verbose?.should be_false
    end
  end

  context 'clone' do
    it 'simple' do
      cfoo = @foo.dclone
      cfoo.should_not == nil
      cfoo.should_not == @foo
      @foo.b.changeme = 'changed'
      @foobar.changeme = 'also changed'
      cfoo.c.changeme.should == @foobar.changeme
      cfoo.b.changeme.should_not == @foo.b.changeme
    end

    it 'exclusion' do
      @foobar.dontcopy = @bar
      cfoobar = @foobar.dclone
      cfoobar.dontcopy.should == @foobar.dontcopy

      @foo.a = @bar
      cfoo = @foo.dclone
      cfoo.a.should_not == @foo.a
    end

    it 'handles hash cloning properly' do
      cfoo = @foo.dclone
      cfoo.h[1].should == "one"
    end
  end

  context 'dup' do
    it 'simple' do
      cfoo = @foo.ddup
      cfoo.should_not == nil
    end
  end

  context Hash do
    it 'has the API' do
      a = {a: 1, b: 2, foo: @foo}
      a.respond_to?(:dclone).should == true
      a.respond_to?(:ddup).should == true
      b = a.dclone
      b[:a].should == a[:a]
      b[:foo].should_not == a[:foo]
    end
  end

  context Array do
    it 'has the API' do
      a = [1, 2, @bar]
      b = a.dclone
      a[0].should == b[0]
      a[2].should_not == b[2]
    end
  end

  context 'enumerables' do
    it 'makes copies of the arrayed objects' do
      cfb = @foobar.dclone
      cfb.arr.size.should > 0
      (0 ... cfb.arr.size).each do |i|
        cfb.arr[i].should_not be_nil
        if @foobar.arr[i].respond_to? :_replicate
          cfb.arr[i].should_not == @foobar.arr[i]
        end
      end
    end

    it 'makes copies of the hashed objects' do
      cfb = @foo.dclone
      cfb.h.size.should == 3
      cfb.h.each do |k, o|
        cfb.h[k].should == @foo.h[k]
      end
    end
  end

  context 'block exclusions' do
    it 'copies with freject true' do
      @fbf.freject = true
      a = @fbf.dclone
      a.fexcludeme.should == @fbf.fexcludeme
    end

    it 'copies with freject false' do
      @fbf.freject = false
      b = @fbf.dclone
      b.fexcludeme.should_not == @fbf.fexcludeme
    end
  end
end
