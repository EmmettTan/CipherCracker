class Score
    #Initialize frequency map of common english four letter sequences
    def initialize
        @freqhash = Hash.new
        @score_sum = 0
        File.open("english_quadgrams.txt", "r").each_line do |line|
            data = line.split(" ")
            @freqhash[data[0]] = Integer(data[1])
            @score_sum += Integer(data[1])
        end
        @shitty_quad = Math::log10(0.02/@score_sum.to_f)
    end
    attr_reader :freqhash
    attr_reader :str_to_score

    def score(input)
        final_score = 0
        quadgraphArr = input.scan(/.{4}/)
        input.slice!(0)
        quadgraphArr2 = input.scan(/.{4}/)
        input.slice!(0)
        quadgraphArr3 = input.scan(/.{4}/)
        input.slice!(0)
        quadgraphArr4 = input.scan(/.{4}/)

        #puts "=================="
        #puts quadgraphArr.length
        #puts quadgraphArr2.length
        #puts quadgraphArr3.length
        #puts quadgraphArr4.length
        #puts "=================="
        
        #puts "==========================="
        #puts "Scoring input: #{input}"
        #puts "==========================="
        quadgraphArr.each { |str|
            if (@freqhash.has_key?(str.upcase))
                str_score = Math::log10(@freqhash[str.upcase]/@score_sum.to_f)
            else
                str_score = @shitty_quad
            end
            final_score += str_score
        }
        quadgraphArr2.each { |str|
            if (@freqhash.has_key?(str.upcase))
                str_score = Math::log10(@freqhash[str.upcase]/@score_sum.to_f)
            else
                str_score = @shitty_quad
            end
            final_score += str_score
        }
        quadgraphArr3.each { |str|
            if (@freqhash.has_key?(str.upcase))
                str_score = Math::log10(@freqhash[str.upcase]/@score_sum.to_f)
            else
                str_score = @shitty_quad
            end
            final_score += str_score
        }
        quadgraphArr4.each { |str|
            if (@freqhash.has_key?(str.upcase))
                str_score = Math::log10(@freqhash[str.upcase]/@score_sum.to_f)
            else
                str_score = @shitty_quad
            end
            final_score += str_score
        }
        return final_score
    end
end
