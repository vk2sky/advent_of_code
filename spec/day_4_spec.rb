# see http://adventofcode.com/day/4
#
# --- Day 4: The Ideal Stocking Stuffer ---
#
# Santa needs help mining some AdventCoins (very similar to bitcoins) to use
# as gifts for all the economically forward-thinking little girls and boys.
#
# To do this, he needs to find MD5 hashes which, in hexadecimal, start with
# at least five zeroes. The input to the MD5 hash is some secret key (your
# puzzle input, given below) followed by a number in decimal. To mine
# AdventCoins, you must find Santa the lowest positive number (no leading
# zeroes: 1, 2, 3, ...) that produces such a hash.
#
# For example:
#
# - If your secret key is abcdef, the answer is 609043, because the MD5
#   hash of abcdef609043 starts with five zeroes (000001dbbfa...), and it
#   is the lowest such number to do so.
#
# - If your secret key is pqrstuv, the lowest number it combines with to
#   make an MD5 hash starting with five zeroes is 1048970; that is, the
#   MD5 hash of pqrstuv1048970 looks like 000006136ef....
#
# Your puzzle answer was 117946.
#
# --- Part Two ---
#
# Now find one that starts with six zeroes.
#
#     Your puzzle answer was 3938038.

def md5_hash(key)
  require 'digest/md5'
  Digest::MD5.hexdigest(key)
end


def find_zero_hash(key, number_of_zeros)
  regexp = Regexp.new("^#{'0' * number_of_zeros}")

  10_000_000.times do |number|
    # $stderr.puts number if (number % 1000).zero?

    key_number = "#{key}#{number}"
    hash       = md5_hash(key_number)

    if hash =~ regexp
      p "#{key_number} -> #{hash}"
      return number
    end
  end
end


describe 'Stocking Stuffer' do

  @puzzle_input = 'ckczppom'

  context 'part 1' do
    it 'converts key "abcdef" to MD5 hash "000001dbbfa..." using number 609043' do
      expect(md5_hash('abcdef609043') =~ /^000001dbbfa/).to be_truthy
      expect(find_zero_hash('abcdef', 5)).to eq 609043
    end

    it 'converts key "pqrstuv" to MD5 hash "000006136ef..." using number 1048970' do
      expect(md5_hash('pqrstuv1048970') =~ /^000006136ef/).to be_truthy
      expect(find_zero_hash('pqrstuv', 5)).to eq 1048970
    end

    it "converts key '#{@puzzle_input}#{117946}' to MD5 hash starting with five zeros" do
      count = find_zero_hash(@puzzle_input, 5)
      expect(count).to eq 117_946
    end
  end

  context 'part 2' do
    it "converts key '#{@puzzle_input}#{3938038}' to MD5 hash starting with six zeros" do
      count = find_zero_hash('ckczppom', 6)
      expect(count).to eq 3_938_038
    end
  end

end
