STDOUT.sync = true
require 'securerandom'
require 'zlib'

studentNumMD5 = 'FF343B2EE72B89297CE2A200AD621FE9'
mapping = Hash.new


studentCRC = Zlib::crc32(studentNumMD5)

attempts = 0

while (true) do
    attempts += 1
    randomStr = SecureRandom.hex
    crc = Zlib::crc32(randomStr)
    if(mapping[crc] != nil)
        break
    end
    mapping[crc] = randomStr
end

puts "First string: #{mapping[crc]}"
puts "Second string: #{randomStr}"
puts attempts
#First string: f4658ef03c85e56f4c1944bfcf1b7c37
#Second string: 9b66d06081d2bfcd6d81dfd511c33d9d

