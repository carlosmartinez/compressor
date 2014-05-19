# Implement two methods to perform basic string compression/decompression
# e.g. aaabbccc will compress to a3b2c3 and vice-versa. 
# You can assume the input is only letters. 
# If the compressed string did not become smaller then return the original string.  
# Provide some tests to cover these methods. Another example; a11b1 would become aaaaaaaaaaab.

require 'rspec'

class Compressor
  def compress(input)
    matcher = /(([a-z])\2*)/i 
    output = input.scan(matcher).map do |match| 
      {count: match[0].length, char: match[1]}
    end.inject('') do |seed, kvp|
      seed << "#{kvp[:char]}#{kvp[:count]}"
    end
    output.length < input.length ? output : input
  end

  def decompress(input)
    matcher = /(([a-z])(\d{0,5}))/
    input.scan(matcher).map do |match| 
      {count: greater_than_zero(match[2]), char: match[1]}
    end.inject('') do |seed, kvp|
      seed << kvp[:char] * kvp[:count]; seed
    end
  end

  private

  def greater_than_zero(num)
    num.to_i > 0 ? num.to_i : 1
  end
end

describe Compressor do 

  subject do
    Compressor.new
  end

  it "should compress aaa to a3" do 
    subject.compress('aaa').should == 'a3'
  end
  
  it "should compress aaabb to a3b2" do 
    subject.compress('aaabb').should == 'a3b2'
  end

  it "should compress aaabbccc to a3b2c3" do 
    subject.compress('aaabbccc').should == 'a3b2c3'
  end

  it "should compress a to a" do
    subject.compress('a').should == 'a'
  end

  it "should return the original string if the compressed string is not shorter" do
    subject.compress('aa').should == 'aa'
  end

  it "should decompress a3 to aaa" do
    subject.decompress('a3').should == 'aaa'
  end

  it "should decompress a3b2c3 to aaabbccc" do
    subject.decompress('a3b2c3').should == 'aaabbccc'
  end

  it "should decompress a11b1 to aaaaaaaaaaab" do
    subject.decompress('a11b1').should == 'aaaaaaaaaaab'
  end

  it "should decompress a to a" do
    subject.decompress('a').should == 'a'
  end

end
