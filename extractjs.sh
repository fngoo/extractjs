#!/bin/bash

cd /root/script/3_httprobe
#创建目录
vl -s 50 httprobe.txt | grep -v "\[50" | grep -oP "http.*" >> /root/script/3_httprobe/httprobe1.txt ; sort -u httprobe1.txt -o httprobe1.txt

input=httprobe1.txt ; export input=httprobe1.txt
i=1
echo '#!/bin/bash' >> /root/script/3_httprobe/exe.sh

for line in `cat $input`
do

mkdir /root/script/3_httprobe/dir_$i


echo '#!/bin/bash' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cd /root/script/3_httprobe/dir_${i}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "echo \"$line\" >> /root/script/3_httprobe/dir_${i}/${input}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "getJS -input $input -complete -output getjs${i}.txt; cat getjs${i}.txt >> /root/script/3_httprobe/getjs.txt; rm getjs${i}.txt" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cd /root/script/3_httprobe ; rm -r /root/script/3_httprobe/dir_${i}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "timeout 60 bash /root/script/3_httprobe/dir_$i/${i}.sh" >> /root/script/3_httprobe/exe.sh
i=$((i+1))

done
cat /root/script/3_httprobe/exe.sh | parallel --jobs 0 --delay 0.5
rm /root/script/3_httprobe/exe.sh
rm dir_* -r
rm httprobe1.txt

grep -oP "http.*" /root/script/3_httprobe/getjs.txt > /root/script/3_httprobe/getjs123.txt ; mv /root/script/3_httprobe/getjs123.txt /root/script/3_httprobe/getjs.txt
sort -u /root/script/3_httprobe/getjs.txt -o /root/script/3_httprobe/getjs.txt
ls ; wc -l /root/script/3_httprobe/getjs.txt








#LinkFinder

#创建目录
input=getjs.txt ; export input=getjs.txt
i=1
echo '#!/bin/bash' >> /root/script/3_httprobe/exe.sh

for line in `cat $input`
do

mkdir /root/script/3_httprobe/dir_$i

echo '#!/bin/bash' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo 'input=getjs.txt' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cp -rf /root/script/3_httprobe/LinkFinder/* /root/script/3_httprobe/dir_${i}/" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cd /root/script/3_httprobe/dir_${i}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "python3 linkfinder.py -i '$line' -o cli >> cli.txt ; head=`echo "${line}" | grep -o -P ".*(?=/)"` ; if [ -s cli.txt ]; then for cli in \`cat cli.txt\`; do sed=\${cli:0:4} ; if [ \"\$sed\" != \"http\" ]; then c=\$head\$cli ; sed \"s,\${cli},\${c},g\" cli.txt | sed \"s,.*http,http,g\" >> asd.txt; mv asd.txt cli.txt; fi; done ; cat cli.txt >> $output/3_endpoint_JS.txt ; rm cli.txt; fi" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cd /root/script/3_httprobe; rm -r /root/script/3_httprobe/dir_${i}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "timeout 60 bash /root/script/3_httprobe/dir_$i/${i}.sh" >> /root/script/3_httprobe/exe.sh
i=$((i+1))

done
cat /root/script/3_httprobe/exe.sh | parallel --jobs 0 --delay 0.5
rm /root/script/3_httprobe/exe.sh


rm dir_* -r

grep -oP "http.*" $output/3_endpoint_JS.txt > $output/3_endpoint_JS123.txt ; vl -s 50 $output/3_endpoint_JS123.txt | grep -v "\[50" | grep -oP "http.*" > $output/3_endpoint_JS.txt ; rm $output/3_endpoint_JS123.txt ; sort -u $output/3_endpoint_JS.txt -o $output/3_endpoint_JS.txt
sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt
for line in `cat $var`
do
grep $line $output/3_endpoint_JS.txt >> endpoint.txt
done
mv endpoint.txt $output/3_endpoint_JS.txt
ls
echo endpoint



cd /root/script/3_httprobe
