#!/bin/bash

# organizes files into directories based on file creation date:
# 2025/
#   ├── 01/
#        ├── foo1.jpg
#        ├── foo2.jpg
#   ├── 02/
# 2024/
#   ├── 01/
#   ├── 02/


for y in {2011..2025}; do
    # replace with output dir
    dir="/Volumes/Seagate Bac/takeout_out/out/$y"
    
    # Ensure the directory exists before proceeding
    [[ -d "$dir" ]] || continue

    echo "Processing $y..."

    # Change into the year directory
    pushd "$dir" > /dev/null || continue  

    # Move files based on creation date
    for file in *; do 
        [[ -f "$file" ]] || continue  # Skip if not a file
        year=$(date -r "$file" +%Y)
        month=$(date -r "$file" +%m)
        mkdir -p "$year/$month"
        mv "$file" "$year/$month/"
    done

    # Return to the original directory
    popd > /dev/null
    
    echo "Done!"
done