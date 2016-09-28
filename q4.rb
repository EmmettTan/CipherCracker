STDOUT.sync = true
require 'securerandom'
require 'zlib'

studentNum = 'FF343B2EE72B89297CE2A200AD621FE9'
studentCRC = Zlib::crc32(studentNum)

attempts = 0

puts Zlib::crc32("ed3de29ed79059fd033f7e73dbba5ef3")
puts Zlib::crc32("c725e22d027c073c6bdb9318c546439b")
puts Zlib::crc32("a8204c2d3e94ce1b9a8993474226bab4")

while (1) do
    attempts += 1
    str = SecureRandom.hex
    crc = Zlib::crc32(str)
    if(crc == studentCRC)
        puts "Answer: #{str}"
        puts attempts
        break
    end
end
#================================
#Answer
#19e61d5016eaf7947a1c58b87b2d3b6d
#================================
