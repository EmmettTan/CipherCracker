STDOUT.sync = true
freqmap = Hash.new
difreqmap = Hash.new
trifreqmap = Hash.new
quadfreqmap = Hash.new
ciphermap = Hash.new
("a".."z").each { |letter|
    freqmap[letter] = 0
}

secretMsg = File.read("cipher2.txt")

puts "==============================="
puts secretMsg
puts "==============================="
digraphArr = secretMsg.scan(/.{2}/)
trigraphArr = secretMsg.scan(/.{3}/)
quadgraphArr = secretMsg.scan(/.{4}/)


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


quadgraphArr.each { |str|
    if quadfreqmap.has_key?(str.downcase)
        quadfreqmap[str.downcase] = quadfreqmap[str.downcase] + 1
    else
        quadfreqmap[str.downcase] = 1
    end
}



#puts freqmap
#puts difreqmap.sort_by {|k,v| v}.reverse
#puts trifreqmap.sort_by {|k,v| v}.reverse
#puts quadfreqmap.sort_by {|k,v| v}.reverse

ciphermap["rn"] = "co"
ciphermap["sa"] = "mx"
ciphermap["te"] = "ma"
ciphermap["ne"] = "th"
ciphermap["vg"] = "er"
ciphermap["eg"] = "at"
ciphermap["zh"] = "he"
ciphermap["vn"] = "ho"
ciphermap["ed"] = "ha"
ciphermap["my"] = "sg"
ciphermap["qf"] = "iv"
ciphermap["ht"] = "en"
ciphermap["tq"] = "of"
ciphermap["th"] = "ne"
ciphermap["o"] = "*"
ciphermap["p"] = "*"
ciphermap["q"] = "*"
ciphermap["r"] = "*"
ciphermap["s"] = "*"
ciphermap["t"] = "*"
ciphermap["u"] = "*"
ciphermap["v"] = "*"
ciphermap["w"] = "*"
ciphermap["x"] = "*"
ciphermap["y"] = "*"
ciphermap["z"] = "*"


digraphArr.each { |str|
    if ciphermap[str.downcase] != nil
        print ciphermap[str.downcase]
    else
        print "**"
    end
}
