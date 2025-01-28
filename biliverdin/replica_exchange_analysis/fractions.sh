#!/bin/bash

pp="x11.dat"
left="x10.dat"
right="x01.dat"
dd="x00.dat"
pH_min=1.0
pH_max=9.5
pH_step=0.5

m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
   file="pH${m}_populations.dat"

   awk 'NR>2 { printf "%f\n", $4 }' "$file" >> "$dd"

   awk 'NR>2 { sum=$22+$24+$26+$28+$30+$32+$34+$36+$38+$40+$42+$44+$46+$48+$50; printf "%f\n", sum }' "$file" >> "$pp"

   awk 'NR>2 { sum=$6+$8+$10+$12; printf "%f\n", sum }' "$file" >> "$left"

   awk 'NR>2 { sum=$14+$16+$18+$20; printf "%f\n", sum }' "$file" >> "$right"

   m=$(bc <<< "$m + $pH_step")
done

