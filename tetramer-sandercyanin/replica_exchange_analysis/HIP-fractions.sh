#!/bin/bash

pH_min=3.5 #The lowest pH
pH_max=10.0 #The highest pH
pH_step=0.5

# HIP indexes: 15,19,42,46,71,75,98
residues=(15 19 42 46 71 75 98) # For BLA
for res in "${residues[@]}"; do
    m=$pH_min
    while (( $(bc <<< "$m <= $pH_max") )); do
        echo "Processing residue $res at pH $m" 
        hip=0
        hid=0
        hie=0
        sum=0
        for i in {0..2}; do 
            echo "STATE $i";
            if [ "$i" -eq 0 ]; then
            	grep "Residue   $res State:  $i" reordered.cpout.pH_${m} | wc -l; 
            	count_dd=$(grep "Residue   $res State:  $i" reordered.cpout.pH_${m} | wc -l) 
            	hip=$((count_dd + hip))
            elif [ "$i" -eq 1 ]; then 
            	grep "Residue   $res State:  $i" reordered.cpout.pH_${m} | wc -l; 
            	count_left=$(grep "Residue   $res State:  $i" reordered.cpout.pH_${m} | wc -l)
            	hid=$((count_left + hid))
            elif [ "$i" -eq 2 ]; then
            	grep "Residue   $res State:  $i" reordered.cpout.pH_${m} | wc -l; 
            	count_right=$(grep "Residue   $res State:  $i" reordered.cpout.pH_${m} | wc -l)
            	hie=$((count_right + hie))
            fi 
        done
        sum=$((hip+hid+hie))
  

  	pHIP=$(echo "scale=8; $hip / $sum" | bc)
  	pHID=$(echo "scale=8; $hid / $sum" | bc)
  	pHIE=$(echo "scale=8; $hie / $sum" | bc)
  
  	printf "%.8f\n" "$pHIP" >> HIS_microstate/pHIP_res${res}.dat
  	printf "%.8f\n" "$pHID" >> HIS_microstate/pHID_res${res}.dat
  	printf "%.8f\n" "$pHIE" >> HIS_microstate/pHIE_res${res}.dat
  
  	echo "HIP array is $hip"
  	echo "HID array is $hid"
  	echo "HIE array is $hie"
  	echo "The sum is $sum"  
        echo "The fractions are $pHIP $pHID $pHIE"  
  	
	m=$(bc <<< "$m + $pH_step")
    done
done


residues=(102)
for res in "${residues[@]}"; do
    m=$pH_min
    while (( $(bc <<< "$m <= $pH_max") )); do
        echo "Processing residue $res at pH $m" 
        hip=0
        hid=0
        hie=0
        sum=0
        for i in {0..2}; do
            echo "STATE $i";
            if [ "$i" -eq 0 ]; then
                grep "Residue  $res State:  $i" reordered.cpout.pH_${m} | wc -l;
                count_dd=$(grep "Residue  $res State:  $i" reordered.cpout.pH_${m} | wc -l)                     
                hip=$((count_dd + hip))
            elif [ "$i" -eq 1 ]; then
                grep "Residue  $res State:  $i" reordered.cpout.pH_${m} | wc -l;                     
                count_left=$(grep "Residue  $res State:  $i" reordered.cpout.pH_${m} | wc -l)
                hid=$((count_left + hid))
            elif [ "$i" -eq 2 ]; then
                grep "Residue  $res State:  $i" reordered.cpout.pH_${m} | wc -l;                     
                count_right=$(grep "Residue  $res State:  $i" reordered.cpout.pH_${m} | wc -l)
                hie=$((count_right + hie))
            fi
        done
        sum=$((hip+hid+hie))


        pHIP=$(echo "scale=8; $hip / $sum" | bc)
        pHID=$(echo "scale=8; $hid / $sum" | bc)
        pHIE=$(echo "scale=8; $hie / $sum" | bc)

        printf "%.8f\n" "$pHIP" >> HIS_microstate/pHIP_res${res}.dat
        printf "%.8f\n" "$pHID" >> HIS_microstate/pHID_res${res}.dat
        printf "%.8f\n" "$pHIE" >> HIS_microstate/pHIE_res${res}.dat

        echo "HIP array is $hip"
        echo "HID array is $hid"
        echo "HIE array is $hie"
        echo "The sum is $sum"  
        echo "The fractions are $pHIP $pHID $pHIE"  

        m=$(bc <<< "$m + $pH_step")
    done
done

