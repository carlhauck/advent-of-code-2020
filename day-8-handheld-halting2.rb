# --- Day 8: Handheld Halting ---
# Your flight to the major airline hub reaches cruising altitude without incident. While you consider checking the in-flight menu for one of those drinks that come with a little umbrella, you are interrupted by the kid sitting next to you.

# Their handheld game console won't turn on! They ask if you can take a look.

# You narrow the problem down to a strange infinite loop in the boot code (your puzzle input) of the device. You should be able to fix it, but first you need to be able to run the code in isolation.

# The boot code is represented as a text file with one instruction per line of text. Each instruction consists of an operation (acc, jmp, or nop) and an argument (a signed number like +4 or -20).

# acc increases or decreases a single global value called the accumulator by the value given in the argument. For example, acc +7 would increase the accumulator by 7. The accumulator starts at 0. After an acc instruction, the instruction immediately below it is executed next.
# jmp jumps to a new instruction relative to itself. The next instruction to execute is found using the argument as an offset from the jmp instruction; for example, jmp +2 would skip the next instruction, jmp +1 would continue to the instruction immediately below it, and jmp -20 would cause the instruction 20 lines above to be executed next.
# nop stands for No OPeration - it does nothing. The instruction immediately below it is executed next.
# For example, consider the following program:

# nop +0
# acc +1
# jmp +4
# acc +3
# jmp -3
# acc -99
# acc +1
# jmp -4
# acc +6
# These instructions are visited in this order:

# nop +0  | 1
# acc +1  | 2, 8(!)
# jmp +4  | 3
# acc +3  | 6
# jmp -3  | 7
# acc -99 |
# acc +1  | 4
# jmp -4  | 5
# acc +6  |
# First, the nop +0 does nothing. Then, the accumulator is increased from 0 to 1 (acc +1) and jmp +4 sets the next instruction to the other acc +1 near the bottom. After it increases the accumulator from 1 to 2, jmp -4 executes, setting the next instruction to the only acc +3. It sets the accumulator to 5, and jmp -3 causes the program to continue back at the first acc +1.

# This is an infinite loop: with this sequence of jumps, the program will run forever. The moment the program tries to run any instruction a second time, you know it will never terminate.

# Immediately before the program would run an instruction a second time, the value in the accumulator is 5.

# Run your copy of the boot code. Immediately before any instruction is executed a second time, what value is in the accumulator?

# Your puzzle answer was 2051.

# The first half of this puzzle is complete! It provides one gold star: *

# --- Part Two ---
# After some careful analysis, you believe that exactly one instruction is corrupted.

# Somewhere in the program, either a jmp is supposed to be a nop, or a nop is supposed to be a jmp. (No acc instructions were harmed in the corruption of this boot code.)

# The program is supposed to terminate by attempting to execute an instruction immediately after the last instruction in the file. By changing exactly one jmp or nop, you can repair the boot code and make it terminate correctly.

# For example, consider the same program from above:

# nop +0
# acc +1
# jmp +4
# acc +3
# jmp -3
# acc -99
# acc +1
# jmp -4
# acc +6
# If you change the first instruction from nop +0 to jmp +0, it would create a single-instruction infinite loop, never leaving that instruction. If you change almost any of the jmp instructions, the program will still eventually find another jmp instruction and loop forever.

# However, if you change the second-to-last instruction (from jmp -4 to nop -4), the program terminates! The instructions are visited in this order:

# nop +0  | 1
# acc +1  | 2
# jmp +4  | 3
# acc +3  |
# jmp -3  |
# acc -99 |
# acc +1  | 4
# nop -4  | 5
# acc +6  | 6
# After the last instruction (acc +6), the program terminates by attempting to run the instruction below the last instruction in the file. With this change, after the program terminates, the accumulator contains the value 8 (acc +1, acc +1, acc +6).

# Fix the program so that it terminates normally by changing exactly one jmp (to nop) or nop (to jmp). What is the value of the accumulator after the program terminates?

puzzle_input = 
"jmp +583
acc +9
jmp +525
jmp +302
jmp +287
jmp +412
acc -16
acc -19
acc -19
jmp +423
acc -4
nop +13
acc -8
jmp +37
acc +0
acc -5
acc +48
acc +0
jmp +232
acc +39
acc +5
jmp +69
acc +31
jmp +425
acc +31
jmp +93
nop +166
acc -7
jmp +192
acc +1
jmp +391
acc +11
acc +20
jmp +1
acc +24
acc +7
acc +27
jmp +162
jmp +580
acc +9
acc +39
acc -18
jmp +283
acc +28
acc -14
nop +464
acc -12
jmp +358
jmp +523
jmp +212
acc +16
acc -13
acc +10
acc +46
jmp +207
jmp +266
jmp +1
acc +36
jmp -19
jmp -3
acc -16
acc +3
jmp +229
acc +44
acc +0
acc -17
acc -14
jmp +132
acc +38
nop -30
acc -12
jmp +506
jmp +511
acc -15
acc +4
acc +29
jmp +129
jmp +419
jmp +1
jmp +45
acc +14
acc +20
acc +11
jmp +153
jmp +78
acc +32
nop +212
acc -7
acc +42
jmp -65
acc -17
jmp +458
acc +10
acc +18
acc -11
acc +8
jmp +215
acc +33
acc +25
jmp -21
nop +92
acc +0
nop +353
jmp +188
acc +43
jmp +82
jmp +399
acc +33
acc +16
acc -3
jmp +174
acc -12
acc -3
nop +171
jmp +73
nop +362
jmp -48
jmp +218
acc +5
jmp +486
acc +43
acc -1
acc +0
jmp +476
acc +21
jmp +44
acc +7
acc -6
jmp +1
acc +3
jmp +95
acc +12
acc +38
jmp +202
acc +17
acc -12
jmp +114
jmp -33
jmp +367
acc +45
acc +40
jmp -81
acc -5
acc +27
acc +6
jmp +374
acc -6
acc +10
acc +19
jmp +1
jmp +171
acc +8
acc +46
acc +12
jmp +234
acc +45
acc +28
jmp +337
acc +8
nop +10
acc +17
jmp +368
acc +2
acc -3
acc +29
jmp -160
acc -7
acc +11
jmp +174
acc +48
acc -3
acc +33
jmp +6
acc +3
acc -10
acc +9
acc -13
jmp +428
acc -13
acc +35
nop -112
jmp -147
acc +13
acc -4
acc +50
acc +46
jmp -118
acc +38
acc +36
jmp +375
nop -3
jmp +93
acc +10
acc -1
jmp +211
acc +6
acc +38
acc -12
jmp -6
jmp +1
acc +41
jmp -117
acc -17
acc -15
jmp -120
acc +17
acc +48
acc +37
acc +0
jmp +139
acc +7
acc -12
acc +0
jmp +98
acc +47
acc +3
acc -18
acc +26
jmp +141
jmp +236
acc +18
jmp +275
acc -10
acc -11
jmp +12
acc -19
acc +17
jmp +300
acc +32
nop +145
jmp +84
jmp +34
acc -17
acc +12
acc +37
jmp +182
acc -7
jmp +154
nop +375
acc -1
jmp +108
jmp +1
acc +16
acc +49
jmp +355
acc -16
acc -19
acc +47
acc +26
jmp -171
jmp +285
jmp +84
acc +28
acc -11
acc +6
jmp -252
nop +228
acc +10
acc -17
acc +42
jmp -221
acc +34
acc +8
jmp +201
jmp -225
acc +45
nop +125
acc +25
acc -7
jmp +318
nop +348
nop +40
acc +42
jmp +284
acc -1
acc +46
jmp +1
acc +41
jmp +231
acc +30
acc +45
acc +10
acc +45
jmp -227
acc +25
acc +13
jmp +219
acc -10
acc +27
acc +45
jmp -186
acc -18
acc +50
acc +31
acc +19
jmp +89
nop -240
jmp +173
nop +65
acc -8
jmp +1
nop -146
jmp -156
acc +27
jmp +106
acc +4
acc +45
jmp +35
acc +44
acc +47
jmp -254
jmp +57
acc +1
jmp -274
acc +32
acc +6
acc +1
nop +179
jmp +122
jmp +1
jmp -310
jmp -273
acc +46
acc +9
jmp -187
acc +36
acc +0
nop +47
acc +17
jmp -137
nop -116
acc -17
acc -6
acc -8
jmp +106
acc +36
acc +50
acc +3
acc +22
jmp +190
acc +48
jmp -336
jmp -164
jmp -32
acc +44
nop +242
jmp -215
jmp +7
acc +36
acc +3
acc +27
acc +24
jmp -8
jmp +156
acc -5
acc +42
nop +37
jmp +107
jmp +247
acc +12
acc +30
jmp +44
jmp -306
acc +36
jmp -354
nop +192
nop +153
jmp -106
jmp -284
jmp +1
acc +33
acc +18
acc +13
jmp +232
acc -4
nop -64
acc +38
acc +29
jmp -349
acc -7
acc +44
acc +4
acc +48
jmp -35
acc +13
jmp -144
acc -7
jmp +196
acc -8
jmp -316
jmp -138
jmp -381
jmp -156
acc +21
jmp +189
acc +30
nop -85
acc +34
acc -13
jmp -326
jmp -7
jmp +1
acc +2
acc +24
jmp -56
jmp +152
acc +42
acc +25
acc -6
jmp +174
jmp -96
jmp -86
jmp +20
acc +23
nop -93
acc +3
jmp -42
acc +0
acc +6
jmp +100
jmp +20
jmp -147
acc +19
nop -367
jmp -80
nop -318
nop -289
acc +45
jmp -321
nop -4
acc +13
jmp +74
acc +0
acc +15
jmp +153
acc -5
acc +24
acc +21
jmp +1
jmp -48
jmp -262
nop -317
jmp +93
acc +20
jmp -32
acc +44
acc +50
jmp -350
acc -19
acc +46
jmp -431
acc -11
nop -227
acc +48
jmp +103
acc +44
acc +31
acc -15
jmp -15
acc +0
acc +34
acc -3
acc +38
jmp +108
acc +28
nop -60
acc +28
acc +26
jmp -20
jmp -440
acc +48
jmp -257
acc +11
acc +8
acc +14
acc +30
jmp +8
acc +47
jmp -323
acc +15
acc +10
acc -15
acc +13
jmp -169
acc -11
acc -12
acc +24
acc +5
jmp +125
acc +34
acc -17
acc +2
acc +32
jmp -83
jmp -120
jmp -11
acc +25
nop -54
jmp +1
jmp -29
acc +13
acc +17
acc +6
acc +31
jmp -420
acc +25
acc +13
jmp +117
jmp -3
nop +68
acc +32
acc -11
acc +31
jmp -374
acc -4
acc +34
acc +38
acc +23
jmp -113
acc -19
acc +50
nop -216
jmp -134
nop -331
acc -7
acc +28
jmp -357
jmp -216
jmp -128
acc +34
acc +16
jmp -54
acc -16
acc +0
jmp -64
acc +7
nop -322
jmp -306
nop -414
acc +38
acc +15
jmp +77
acc +18
jmp +1
acc +0
acc -8
jmp -248
acc +26
jmp -6
acc +17
acc +21
acc +30
jmp -142
acc -13
acc -18
nop -330
jmp +27
acc -14
jmp +60
acc +31
acc -6
acc +49
acc +16
jmp -289
acc +11
acc +0
nop -141
acc +19
jmp -143
acc +44
jmp -286
acc +42
jmp -209
acc +34
acc +10
acc +3
jmp -461
acc +2
jmp -358
acc +42
acc +0
acc +26
jmp -191
acc +16
jmp -230
acc +31
jmp -244
nop -456
acc +16
nop -196
jmp -475
acc +24
jmp -553
acc +42
acc +24
acc +3
jmp -572
acc +31
jmp +7
jmp -144
acc +20
acc +23
acc -14
nop -506
jmp -17
acc +19
nop -428
jmp -286
acc +2
acc +6
acc +28
acc -13
jmp -291
jmp -377
acc -3
acc +32
jmp +1
jmp -205
acc +18
acc +32
nop -523
jmp -79
acc +32
jmp -30
acc +40
acc -17
jmp +1
acc +28
jmp +1"

def reveal_end_accumulator(instructions)
  list = []
  @accumulator = 0
  @steps_taken = {}
  @completed = false

  instructions = instructions.split(/\n/)
  instructions.each { |line|
    step_hash = {}
    step = line.split(" ")
    step_hash[:action] = step[0]
    step_hash[:direction] = step[1][0]
    step_hash[:num] = step[1][1..-1].to_i
    list << step_hash
  }

  indx = 0
  while @completed == false && indx <= (list.length - 1)
    if list[indx][:action] == "nop" || list[indx][:action] == "jmp"
      @accumulator = 0
      @steps_taken = {}
      list[indx][:action] = (list[indx][:action] == "nop") ? "jmp" : "nop"
      follow_instructions(list, 0)
      list[indx][:action] = (list[indx][:action] == "nop") ? "jmp" : "nop"
    end
    indx += 1
  end
  @accumulator
end

def follow_instructions(list, index)
  if index == (list.length - 1)
    if list[index][:action] == "acc"
      acc(list, index)
    end
    @completed = true
  elsif @steps_taken[index] == 1 || index > 628
    return nil
  else
    @steps_taken[index] = 1
    case list[index][:action]
      when "nop"
        nop(list, index)
      when "acc"
        acc(list, index)
      when "jmp"
        jmp(list, index)
    end
  end
end

def nop(list, index)
  follow_instructions(list, (index + 1))
end

def acc(list, index)
  if list[index][:direction] == "+"
    @accumulator += list[index][:num]
  elsif list[index][:direction] == "-"
    @accumulator -= list[index][:num]
  end
  follow_instructions(list, (index + 1))
end

def jmp(list, index)
  if list[index][:direction] == "+"
    follow_instructions(list, (index += list[index][:num]))
  elsif list[index][:direction] == "-"
    follow_instructions(list, (index -= list[index][:num]))
  end
end

p reveal_end_accumulator(puzzle_input)