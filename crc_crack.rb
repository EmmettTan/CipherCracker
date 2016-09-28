require 'securerandom'
require 'zlib'

STDOUT.sync = true
def runCrc(key)
    return Zlib::crc32(key)
end


searchStr = "FF343B2EE72B89297CE2A200AD621FE9"
str_to_match = runCrc(searchStr)
puts "Searching for hash value: #{str_to_match}"
puts "========================================="

while (1)
    randomKey = SecureRandom.hex
    if runCrc(randomKey) == str_to_match && randomKey != searchStr
        puts "========================================="
        puts "Match found!! #{randomKey}"
        exit
    end
end
