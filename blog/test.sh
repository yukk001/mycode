#!/bin/bash


for filename in *.md 
do      
        t=$(echo $filename | sed 's/\.md$//');
        echo $t
        sed -i "s/^tags.*/tags: awk与sed/g" $filename
done

