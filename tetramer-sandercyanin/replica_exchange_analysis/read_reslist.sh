#!/bin/bash

# Initialize arrays
residues1=() # For LYS or TYR
residues2=() # For AS4 or GL4
residues3=() # For HIP
residues4=() # For BLA

# Read the file line by line
while read -r line; do
    # Extract the residue name and index
    res_name=$(echo "$line" | awk '{print $2}')   # Extract residue name (e.g., LYS, AS4)
    res_index=$(echo "$line" | awk '{print $6}')  # Extract index (e.g., 0, 1, 2, ...)

    # Check residue type and append to the corresponding array
    if [[ "$res_name" == "LYS" || "$res_name" == "TYR" ]]; then
        residues1+=("$res_index")
    elif [[ "$res_name" == "AS4" || "$res_name" == "GL4" ]]; then
        residues2+=("$res_index")
    elif [[ "$res_name" == "HIP" ]]; then
        residues3+=("$res_index")
    elif [[ "$res_name" == "BLA" ]]; then
        residues4+=("$res_index")
    fi
done < residues_list.txt # Replace with your file name

# Print the arrays
echo "residues1 = (${residues1[@]})"
echo "residues2 = (${residues2[@]})"
echo "residues3 = (${residues3[@]})"
echo "residues4 = (${residues4[@]})"

