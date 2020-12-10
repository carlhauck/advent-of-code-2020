# --- Part Two ---
# To completely determine whether you have enough adapters, you'll need to figure out how many different ways they can be arranged. Every arrangement needs to connect the charging outlet to your device. The previous rules about when adapters can successfully connect still apply.

# The first example above (the one that starts with 16, 10, 15) supports the following arrangements:

# (0), 1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 5, 6, 7, 10, 12, 15, 16, 19, (22)
# (0), 1, 4, 5, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 5, 7, 10, 12, 15, 16, 19, (22)
# (0), 1, 4, 6, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 6, 7, 10, 12, 15, 16, 19, (22)
# (0), 1, 4, 7, 10, 11, 12, 15, 16, 19, (22)
# (0), 1, 4, 7, 10, 12, 15, 16, 19, (22)
# (The charging outlet and your device's built-in adapter are shown in parentheses.) Given the adapters from the first example, the total number of arrangements that connect the charging outlet to your device is 8.

# The second example above (the one that starts with 28, 33, 18) has many arrangements. Here are a few:

# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
# 32, 33, 34, 35, 38, 39, 42, 45, 46, 47, 48, 49, (52)

# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
# 32, 33, 34, 35, 38, 39, 42, 45, 46, 47, 49, (52)

# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
# 32, 33, 34, 35, 38, 39, 42, 45, 46, 48, 49, (52)

# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
# 32, 33, 34, 35, 38, 39, 42, 45, 46, 49, (52)

# (0), 1, 2, 3, 4, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 23, 24, 25, 28, 31,
# 32, 33, 34, 35, 38, 39, 42, 45, 47, 48, 49, (52)

# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
# 46, 48, 49, (52)

# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
# 46, 49, (52)

# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
# 47, 48, 49, (52)

# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
# 47, 49, (52)

# (0), 3, 4, 7, 10, 11, 14, 17, 20, 23, 25, 28, 31, 34, 35, 38, 39, 42, 45,
# 48, 49, (52)
# In total, this set of adapters can connect the charging outlet to your device in 19208 distinct arrangements.

# You glance back down at your bag and try to remember why you brought so many adapters; there must be more than a trillion valid ways to arrange them! Surely, there must be an efficient way to count the arrangements.

# What is the total number of distinct ways you can arrange the adapters to connect the charging outlet to your device?

puzzle_input = "77
58
25
92
14
154
105
112
147
63
84
109
24
129
49
102
130
128
134
88
95
70
80
4
153
17
145
122
39
117
93
65
3
2
139
101
148
37
27
1
87
64
23
59
42
146
43
151
116
46
115
118
131
94
19
33
12
107
10
7
73
78
53
11
135
79
60
32
141
31
140
98
136
72
38
152
30
74
106
50
13
26
155
67
20
66
91
56
34
125
52
51
18
108
57
81
119
71
144"

@adapters = puzzle_input.split(/\n/).map(&:to_i).push(0).sort.reverse # adds 0 node for charging outlet; inclusion of built-in joltage adapter (max + 3) unnecessary

def to_directed_graph(adapters)
  node_paths = {}
  adapters.each do |node|
    node_paths[node] = adapters.select{|other_node| other_node.between?(node+1, node+3)}
  end
  node_paths
end

def paths_from_adapter(node_paths, i, cache)
  return cache[i] if cache[i]
  return 1 if node_paths[i].count == 0

  sum = 0

  count = node_paths[i].each do |path|
    val = 0
    val = (cache[path]) ? cache[path] : paths_from_adapter(node_paths, path, cache)
    cache[path] ||= val # memoization
    sum += val
  end

  return sum
end

puts paths_from_adapter(to_directed_graph(@adapters), 0, {})


# ^^ modified version of Reddit solution: https://github.com/m7rk/adventofcode2020/blob/master/10.rb ^^



# def find_optionals
#   @optional_hash = {}
#   @optional_ary = []

#   index = 1

#   while index < (@adapters.length - 1)
#     diff = @adapters[index + 1] - @adapters[index - 1]
#     if diff <= 3
#       @optional_hash[@adapters[index]] = true
#       @optional_ary << @adapters[index]
#     end
#     index += 1
#   end
# end

# def run_optional_combinations
#   combo_digits_count = 1

#   # @all_valid_combos = {}

#   while combo_digits_count <= (@optional_ary.length)
#     combinations = @optional_ary.combination(combo_digits_count).to_a
#     combinations.each do |combo|
#       replace_ary = []
#       combo.each do |num|
#         replace_ary << [@adapters.index(num), num]
#       end
#       combo.each do |num|
#         @adapters.delete(num)
#       end
      
#       index = 1
#       while index < (@adapters.length)
#         diff = @adapters[index] - @adapters[index - 1]
#         if diff > 3
#           break
#         end
#         if index = (@adapters.length - 1)
#           @arrangement_count += 1
#           # if !@all_valid_combos[@adapters]
#           #   @all_valid_combos[@adapters] = true
#           # end
#         end
#         index += 1
#       end

#       replace_ary.each do |index_num|
#         @adapters.insert(index_num[0], index_num[1])
#       end

#     end
#     combo_digits_count += 1
#   end
# end