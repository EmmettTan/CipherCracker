STDOUT.sync = true
freqmap = Hash.new
difreqmap = Hash.new
trifreqmap = Hash.new
ciphermap = Hash.new
("a".."z").each { |letter|
    freqmap[letter] = 0
}

secretMsg = File.read("cipher1.txt")

puts "==============================="
puts secretMsg
puts "==============================="

digraphArr = secretMsg.scan(/.{2}/)
trigraphArr = secretMsg.scan(/.{3}/)
quadgraphArr = secretMsg.scan(/.{4}/)
quintgraphArr = secretMsg.scan(/.{5}/)


# Create single letter frequency chart 
msgChars = secretMsg.split('')
msgChars.each { |c|
    if freqmap.has_key?(c.downcase)
        freqmap[c.downcase] = freqmap[c.downcase] + 1
    end
}

digraphArr.each { |str|
    if difreqmap.has_key?(str.downcase)
        difreqmap[str.downcase] = difreqmap[str.downcase] + 1
    else
        difreqmap[str.downcase] = 1
    end
}

trigraphArr.each { |str|
    if trifreqmap.has_key?(str.downcase)
        trifreqmap[str.downcase] = trifreqmap[str.downcase] + 1
    else
        trifreqmap[str.downcase] = 1
    end
}

#puts difreqmap
#puts trifreqmap.sort_by {|k,v| v}.reverse

ciphermap["a"] = "*"
ciphermap["b"] = "t"
ciphermap["c"] = "d"
ciphermap["d"] = "k"
ciphermap["e"] = "*"
ciphermap["f"] = "s"
ciphermap["g"] = "l"
ciphermap["h"] = "g"
ciphermap["i"] = "p"
ciphermap["j"] = "b"
ciphermap["k"] = "f"
ciphermap["l"] = "e"
ciphermap["m"] = "w"
ciphermap["n"] = "r"
ciphermap["o"] = "v"
ciphermap["p"] = "a"
ciphermap["q"] = "m"
ciphermap["r"] = "o"
ciphermap["s"] = "i"
ciphermap["t"] = "y"
ciphermap["u"] = "u"
ciphermap["v"] = "*"
ciphermap["w"] = "h"
ciphermap["x"] = "c"
ciphermap["y"] = "n"
ciphermap["z"] = "*"

msgChars.each { |c|
    print ciphermap[c.downcase]
}
