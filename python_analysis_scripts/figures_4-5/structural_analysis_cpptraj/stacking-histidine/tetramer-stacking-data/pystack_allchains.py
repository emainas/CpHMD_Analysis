#!/usr/bin/env python3

def process_file(input_file, output_file):
    count = -1
    stacked = 0
    with open(input_file) as data:
        next(data)  # Skip the header
        for line in data:
            count += 1
            frame, distance, angle = line.split()
            dis = float(distance)
            ang = float(angle)
            if (ang >= 0 and ang <= 45) and (dis <= 5):
                stacked += 1
                with open(output_file, 'a') as out_file:
                    out_file.write(f"{dis} {ang}\n")
    total_stacked_percent = (stacked * 100 / count) if count > 0 else 0
    with open(output_file, 'a') as out_file:
        out_file.write(f"Total frames: {count}\n")
        out_file.write(f"Total stacked frames: {stacked}\n")
        out_file.write(f"Total stacked %: {total_stacked_percent:.2f}\n")

# Process all four files
process_file('com-angle1.dat', 'output1.txt')
process_file('com-angle2.dat', 'output2.txt')
process_file('com-angle3.dat', 'output3.txt')
process_file('com-angle4.dat', 'output4.txt')

