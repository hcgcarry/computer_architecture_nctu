#!/bin/bash

cd test
mkdir file ; for i in ./* ; do cd "$i"; cp *.zip ../file; cd ..;  done
cd file/
echo $(pwd)
for i in $(ls); do  mkdir "${i%.*}"; mv $i "${i%.*}"; cd "${i%.*}"; unzip $i;mv $i .. ; cd ..; done
find . -iname "__MACOSX" -exec rm -rf {} \; #3
:<<!
for i in $( ls ); do if [ $( ls -al $i | wc -l ) -eq 4 ]; then echo "Folder" $i; for j in $( ls $i ); do mv $i/$j/* $i; rm -rf $i/$j ; done ; fi ; done
rm *.zip

for i in $(ls);
do echo $i >> result.txt;
cd $i;
cp ../../../ref/Instr_Memory.v . && cp ../../../ref/golden_result_* . && cp ../../../ref/testbench.v . && cp ../../../ref/testbench.v . && cp ../../../ref/CO_test_data* .;
cp ../../../ref/Data_Memory.v  . && cp ../../../ref/Reg_File.v  . && cp ../../../ref/ProgramCounter.v  .;
echo "test1" >> ../result.txt;
iverilog -o demo1 *.v >> ../result.txt 2>&1&& diff <(vvp demo1) <(cat golden_result_1.txt) >> ../result.txt 2>&1;
echo "test2" >> ../result.txt;
sed -i -e 's/CO_test_data1.txt/'CO_test_data2.txt'/' Instr_Memory.v;
iverilog -o demo2 *.v >> ../result.txt 2>&1&& diff <(vvp demo2) <(cat golden_result_2.txt) >> ../result.txt 2>&1;
echo "" >> ../result.txt;
echo "" >> ../result.txt;
sed -i -e 's/CO_test_data2.txt/'CO_test_data1.txt'/' Instr_Memory.v ;
cd ..;
done

!