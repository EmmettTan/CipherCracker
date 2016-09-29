STDOUT.sync = true
require_relative 'playfair'
require_relative 'score'

class Cracker
    def initialize
        @counter = 0.0
        @flips = 0.0
        #@ciphertext = "test"
        @ciphertext = File.read('cipher2.txt')
        @temperature = 50
        @key = generate_key
        @playfair = Playfair.new(@key, @ciphertext.upcase)
        @scorer = Score.new
        @parent_score = -(Float::INFINITY)
        @child_score = -(Float::INFINITY)
        solve
    end

    def solve
        while 1
            plaintext = @playfair.decrypt_ciphertext
            @child_score = @scorer.score(plaintext)
            #puts plaintext
            if @child_score >= @parent_score
                puts "================================="
                puts "Current Score: #{@parent_score}"
                @parent_score = @child_score
                @best_table = @playfair.key_table.dup
                puts "Child Score: #{@child_score}"
                print_best
            else
                probability = 1.0/(Math::E**((@parent_score-@child_score)/@temperature))
                random_float = rand()
                if probability >= random_float
                    @parent_score = @child_score
                    @best_table = @playfair.key_table
                    puts "================================="
                    puts "Current Score: #{@parent_score}"
                    puts "Child Score: #{@child_score}"
                    puts "Probability: #{probability}"
                    print_best
                else
                    @playfair.reinitialize_key_table(@best_table)
                end
            end
            @playfair.change_key_table(rand(0..50))
        end
    end

    def generate_key
        key = ""
        alphabet = "ABCDEFGHIKLMNOPQRSTUVWXYZ"
        while !alphabet.empty?
            randNum = rand(0..alphabet.length-1)
            key << alphabet.slice!(randNum)
        end
        return key.upcase
    end

    def print_best
        for i in 0..4
            for j in 0..4
                print @best_table[i][j]
            end
            puts ""
        end
    end
end
cracker = Cracker.new
