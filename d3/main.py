import re

# p1
#pattern = r"mul\((\d{1,3})\,(\d{1,3})\)"
#compiled = re.compile(pattern)
#total = 0
#with open('input.txt', 'r') as file:
#    while line := file.readline():
#        matches = compiled.findall(line)
#        for m in matches:
#            total += int(m[0]) * int(m[1])
#p2
pattern = r"mul\((\d{1,3})\,(\d{1,3})\)|(don\'t)\(\)|(do)\(\)"
compiled = re.compile(pattern)
total = 0
skip_next = False
with open('input.txt', 'r') as file:
    while line := file.readline():
        matches = compiled.findall(line)
        for m in matches:
            if len(m[2]) != 0:
                skip_next = True
            elif len(m[3]) != 0:
                skip_next = False
            elif not skip_next:
                total += int(m[0]) * int(m[1])
print(total)
