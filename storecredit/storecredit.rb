#!/usr/bin/env ruby

fh_input = File.open(ARGV[0])
fh_output = File.open("#{ARGV[0]}.out", "w+")
n_cases = 0
arr_cases = []

fh_input.each{|line|
    line.chomp!
    i = fh_input.lineno
    #get number of cases
    if i == 1
        n_cases = line.to_i 
    #get item prices
    elsif i % 3 == 1
        arr_cases.push line.split(" ").map(&:to_i)
    #get credit or number of items
    else
        arr_cases.push line.to_i
    end
}

#find the pair of items that add up to the entire value of the credit
def solve(credit, items, prices)
    prices.each_with_index{|p, i|
        (i+1).upto(prices.size - 1){|j|
            #save the positions of the indexes and stop searching
            if prices[i] + prices[j] == credit
                return [i + 1, j + 1]
                break
            end
        }
    }
end

n_case = 0
arr_cases.each_slice(3) {|c, i, p|
    n_case += 1
    fh_output.write "Case ##{n_case}: #{solve(c, i, p).join(" ")}\n"
}
