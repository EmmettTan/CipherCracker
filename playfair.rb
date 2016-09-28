STDOUT.sync = true
require_relative 'score'
    
class Playfair
    def initialize(key, ciphertext)
        @ciphertext = ciphertext
        @parent_score = -(Float::INFINITY)
        @child_score = -(Float::INFINITY)
        @cipherPairs = ciphertext.scan(/.{2}/)
        init_key_table(key)
    end

    def decrypt_ciphertext
        res = ""
        @cipherPairs.each { |pair|
            res << translate_pair(pair)
        }
        return res
    end

    def translate_pair(str)
        c1 = str[0]
        c2 = str[1]

        pos1 = [@key_lookup[c1][0], @key_lookup[c1][1]]
        pos2 = [@key_lookup[c2][0], @key_lookup[c2][1]]

        if (pos1[0] == pos2[0])
            #Row and column are same, we have a problem
            if (pos1[1] == pos2[1])
                puts "ERROR, LETTER PAIR #{str} HAS DUPLICATE LETTERS"
                exit
            end
            #Row is same, perform row shift
            return pair_row_shift(str)
        elsif (pos1[1] == pos2[1])
            return pair_column_shift(str)
        else
            return pair_rectangle_shift(str)
        end            
    end

    def pair_row_shift(str) 
        res = ""
        c1 = str[0]
        c2 = str[1]

        pos1 = [@key_lookup[c1][0], @key_lookup[c1][1]]
        pos2 = [@key_lookup[c2][0], @key_lookup[c2][1]]


        res << @key_table[pos1[0]][(pos1[1] - 1) % 5]
        res << @key_table[pos2[0]][(pos2[1] - 1) % 5]

        return res
    end

    def pair_column_shift(str)
        res = ""
        c1 = str[0]
        c2 = str[1]

        pos1 = [@key_lookup[c1][0], @key_lookup[c1][1]]
        pos2 = [@key_lookup[c2][0], @key_lookup[c2][1]]


        res << @key_table[pos1[0]-1][(pos1[1]) % 5]
        res << @key_table[pos2[0]-1][(pos2[1]) % 5]

        return res
    end

    def pair_rectangle_shift(str)
        res = ""
        c1 = str[0]
        c2 = str[1]

        pos1 = [@key_lookup[c1][0], @key_lookup[c1][1]]
        pos2 = [@key_lookup[c2][0], @key_lookup[c2][1]]

        res << @key_table[pos1[0]][(pos2[1])]
        res << @key_table[pos2[0]][(pos1[1])]

        return res
    end

    def change_key_table(number)
        random_number = rand(0..50)
        case random_number
        when 0
            perform_diagonal_flip
        when 1
            perform_vertical_flip
        when 2
            perform_horizontal_flip
        when 3
            perform_row_swap
        when 4
            perform_column_swap
        else
            perform_letter_swap
        end
    end

    def perform_diagonal_flip

    end

    def perform_vertical_flip

    end

    def perform_horizontal_flip

    end

    def perform_row_swap
        random_row1 = rand(0..4)
        random_row2 = rand(0..4)
        while(random_row2 == random_row1)
            random_row2 = rand(0..4)
        end
        row1_buffer = key_table[random_row1].dup
        row2_buffer = key_table[random_row2].dup
        
        for i in 0..4
            key_table[random_row2][i] = row1_buffer[i]
            key_lookup[key_table[random_row2][i]] = [random_row2, i]
            key_table[random_row1][i] = row2_buffer[i]
            key_lookup[key_table[random_row1][i]] = [random_row1, i]
        end
    end

    def perform_col_swap
        random_col1 = rand(0..4)
        random_col2 = rand(0..4)
        while(random_col2 == random_col1)
            random_col2 = rand(0..4)
        end
        col1_buffer = key_table.transpose[random_col1].dup
        col2_buffer = key_table.transpose[random_col2].dup
        
        for i in 0..4
            key_table[i][random_col2] = col1_buffer[i]
            key_lookup[key_table[i][random_col2]] = [i, random_col2]
            key_table[i][random_col1] = col2_buffer[i]
            key_lookup[key_table[i][random_col1]] = [i, random_col1]
        end
    end

    def perform_letter_swap

    end

    def init_key_table(key)
        key = key.dup
        alphabet = "ABCDEFGHIKLMNOPQRSTUVWXYZ"
        used = Hash.new
        used["J"] = true
        puts "Initializing Key Table..."
        puts "========================="
        @key_table = Array.new(5){Array.new(5)}
        @key_lookup = Hash.new
        for i in 0..4
            for j in 0..4
                val = ""
                while(val.empty?) 
                    while(!key.empty?)
                        
                        letter = key.slice!(0)
                        if !used.has_key?(letter.upcase)
                            val = letter
                            used[letter.upcase] = true 
                            break
                        end
                    end

                    if (!val.empty?)
                        break
                    end
                       
                    while(!alphabet.empty?)
                        letter = alphabet.slice!(0)
                        if !used.has_key?(letter.upcase)
                            val = letter
                            used[letter.upcase] = true
                            break
                        end
                    end
                end
                print val.upcase
                @key_table[i][j] = val.upcase
                @key_lookup[val.upcase] = [i,j]
                val = ""
            end
            puts ""
        end
    end
    attr_reader :key_table
    attr_reader :parent_score
    attr_reader :child_score
    attr_reader :key_lookup

    def print_key_table
        for i in 0..4
            for j in 0..4
                print @key_table[i][j]
            end
            puts ""
        end
    end

end

playfair = Playfair.new(ARGV[0], ARGV[1])
playfair.perform_col_swap
puts ""
playfair.print_key_table
puts playfair.key_lookup
