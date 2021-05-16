# for filename in *_file_ ;do
#     cd "$filename"
#     unzip *.zip
#     cd ..
# done;
read_score(){
    filename=$1
    zipFileName=$(find -name "G*.zip")
    echo "zipFileName:"$zipFileName
    groupInfo=$(find -name "*.zip" | xargs basename | sed -r -e "s/(Group|G)?([0-9]+)_([0-9]+)_?([0-9]*)?.zip/\2 \3 \4/")
    group=$(echo $groupInfo | awk '{print $1}')
    ID1=$(echo $groupInfo | awk '{print $2}')
    ID2=$(echo $groupInfo | awk '{print $3}')
    #echo "group info:"$groupInfo

    dir="../Lab3_${group}_${ID1}_${ID2}"

    cp -r ../Lab3 $dir
    find . -name Adder.v -o -name ALU_Ctrl.v -o -name alu.v -o -name Decoder.v -o -name Simple_Single_CPU.v -o -name ALU_1bit.v \
    | xargs -I {} cp {} $dir/Lab3Code
    cd "$dir"
    score=$(bash "$dir/lab3TestScript.sh" |  grep "total score" | sed -r -e  "s/total score:([0-9]*)/\1/g")
    return "$score"

}

rm score.csv
cp template.csv score.csv
for filename in *_file_ ;do
    cd "$filename"
    echo "-----------------------------"
    echo $filename
    read_score $filename
    score=$?
    echo "score:$score"
    echo "group:"$group "ID1:"$ID1 "ID2:"$ID2
    cd "/home/hcgcarry/homework/computer_arch/lab3_student"
    sed -r -i -e "s/$ID1/$ID1,$score/" score.csv
    if [ ! -z "$ID2" ];then
    sed -r -i -e "s/$ID2/$ID2,$score/" score.csv
    fi
done;