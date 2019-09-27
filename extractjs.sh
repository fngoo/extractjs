#!/bin/bash

cd /root/script/3_httprobe
#创建目录
x=8 ; input=httprobe.txt ; export x=8 ; export input=httprobe.txt
length=`wc -l $input|grep -o -P ".*?(?=\ )"`
#dir_num=$((x*x))
if [ $length -lt $x ]
then
i=1
#mkdir dir_$i
#cp $input /root/script/3_httprobe/dir_${i}/${input}
#echo '#!/bin/bash' >> /root/script/3_httprobe/dir_${i}/${i}.sh
#echo 'x=$x ; input=httprobe.txt' >> /root/script/3_httprobe/dir_${i}/${i}.sh
x=$x ; input=httprobe.txt
getJS -input $input -complete -output getjs${i}.txt; cat getjs${i}.txt >> getjs.txt; rm getjs${i}.txt
#bash /root/script/3_httprobe/dir_${i}/${i}.sh
#rm /root/script/3_httprobe/dir_${i} -r


else

for i in `seq 1 $x`
do
mkdir dir_$i
done

#切割文本
a=`wc -l $input|grep -o -P ".*?(?=\ )"`
#y=$((x-1))
each=$(($a/$x))
split -l $each  $input -d -a 3 split_

#可能多出一份文件
maybe=`ls|grep split|wc -l|grep -o -P ".*?(?=\ )"`
if [ '$maybe' != '$x' ]
then
cat split_000 >> split_00$x ; rm split_000
fi

#移动文件至对应数字目录
for i in `seq 1 $x`
do
#创建bash
mv split_00$i dir_$i/$input
echo '#!/bin/bash' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo 'x=$x ; input=httprobe.txt' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cd /root/script/3_httprobe/dir_${i}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "getJS -input $input -complete -output getjs${i}.txt; cat getjs${i}.txt >> /root/script/3_httprobe/getjs.txt; rm getjs${i}.txt" >> /root/script/3_httprobe/dir_${i}/${i}.sh

done


#执行并删除
echo '#!/bin/bash' >> exe.sh
for i in `seq 1 $x`
do
echo "bash /root/script/3_httprobe/dir_${i}/${i}.sh" >> exe.sh
done

cat exe.sh | parallel --jobs 0 --progress --delay 1

rm exe.sh

cd /root/script/3_httprobe
for i in `seq 1 $x`
do
rm -r dir_$i
done
fi
rm dir_* -r

sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt
sort -u /root/script/3_httprobe/getjs.txt -o /root/script/3_httprobe/getjs.txt









#JSFinder
mv JSFinder/JSFinder.py JSFinder.py 
#创建目录
x=8 ; input=getjs.txt ; export x=8 ; export input=getjs.txt
length=`wc -l $input|grep -o -P ".*?(?=\ )"`
#dir_num=$((x*x))
if [ $length -lt $x ]
then
i=1
x=$x ; input=httprobe.txt
python3 JSFinder.py -f $input -j >> $output/3_endpoint_JS.txt
rm -r /root/script/3_httprobe/dir_$i




else

for i in `seq 1 $x`
do
mkdir dir_$i
done

#切割文本
a=`wc -l $input|grep -o -P ".*?(?=\ )"`
#y=$((x-1))
each=$(($a/$x))
split -l $each  $input -d -a 3 split_

#可能多出一份文件
maybe=`ls|grep split|wc -l|grep -o -P ".*?(?=\ )"`
if [ '$maybe' != '$x' ]
then
cat split_000 >> split_00$x ; rm split_000
fi

#移动文件至对应数字目录
for i in `seq 1 $x`
do
#创建bash
mv split_00$i dir_$i/$input
echo '#!/bin/bash' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo 'x=$x ; input=httprobe.txt' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cp JSFinder.py /root/script/3_httprobe/dir_${i}/JSFinder.py" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cd /root/script/3_httprobe/dir_${i}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "python3 JSFinder.py -f $input -j >> $output/3_endpoint_JS.txt" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cd /root/script/3_httprobe; rm -r /root/script/3_httprobe/dir_$i" >> /root/script/3_httprobe/dir_$i/${i}.sh

done


#执行并删除
echo '#!/bin/bash' >> exe.sh
for i in `seq 1 $x`
do
echo "bash /root/script/3_httprobe/dir_${i}/${i}.sh" >> exe.sh
done

cat exe.sh | parallel --jobs 0 --progress --delay 1

rm exe.sh

cd /root/script/3_httprobe
for i in `seq 1 $x`
do
rm -r dir_$i
done
fi
rm dir_* -r

sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt
