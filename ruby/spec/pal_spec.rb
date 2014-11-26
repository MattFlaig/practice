require "spec_helper"

RSpec.describe "" do
	describe '#palindrome' do
		context "preparing loop" do
	    it "duplicates the original string" do
        string = "abba"
        check_string = string.dup
        expect(check_string).to eql(string)
	    end
	    it "sets the left index to 0" do
	      left_index = 0
	      expect(left_index).to eql(0)
	    end
	    it "sets the right index to length of string-1" do
	    	string = "abba"
	    	right_index = (string.length)-1
	    	expect(right_index).to eql(3)
	    end
	  end

	  context "loop" do
	  	it "recognizes a given palindrome with even length" do
		  	string = "abba"
		  	expect(palindrome(string)).to eql("abba is a palindrome!")
		  end
		  it "recognizes a given palindrome with odd length" do
        string = "abcba"
		  	expect(palindrome(string)).to eql("abcba is a palindrome!")
		  end
      it "recognizes if the given string is no palindrome" do
        string = "abab"
		  	expect(palindrome(string)).to eql("I am sorry, but abab is no palindrome!")
      end
	  end
	end
end