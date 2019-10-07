#!/bin/bash

cd /root/script/3_httprobe
#创建目录
input=httprobe.txt ; export input=httprobe.txt
i=1
echo '#!/bin/bash' >> /root/script/3_httprobe/exe.sh

for line in `cat $input`
do

mkdir /root/script/3_httprobe/dir_$i


echo '#!/bin/bash' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo 'x=$x ; input=httprobe.txt' >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cd /root/script/3_httprobe/dir_${i}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "echo \"$line\" >> /root/script/3_httprobe/dir_${i}/${input}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "getJS -input $input -complete -output getjs${i}.txt; cat getjs${i}.txt >> /root/script/3_httprobe/getjs.txt; rm getjs${i}.txt" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cd /root/script/3_httprobe ; rm -r /root/script/3_httprobe/dir_${i}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "bash /root/script/3_httprobe/dir_$i/${i}.sh" >> /root/script/3_httprobe/exe.sh
i=$((i+1))

done
cat /root/script/3_httprobe/exe.sh | parallel --jobs 0 --delay 0.5
rm /root/script/3_httprobe/exe.sh
rm dir_* -r

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
echo "python3 linkfinder.py -i '$line' -o cli >> cli.txt ; head=`echo "${line}" | grep -o -P ".*(?=/)"` ; for cli in \`cat cli.txt\`; do sed=\`\${cli:0:4}\` ; if [ \"\$sed\" != \"http\" ]; then c=\$head\$cli ; sed \"s,\${cli},\${c},g\" cli.txt >> asd.txt ; mv asd.txt cli.txt ; cat cli.txt >> $output/3_endpoint_JS.txt ; rm cli.txt; fi; done" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cd /root/script/3_httprobe; rm -r /root/script/3_httprobe/dir_${i}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "bash /root/script/3_httprobe/dir_$i/${i}.sh" >> /root/script/3_httprobe/exe.sh
i=$((i+1))

done
cat /root/script/3_httprobe/exe.sh | parallel --jobs 0 --delay 0.5
rm /root/script/3_httprobe/exe.sh


rm dir_* -r

sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt
ls ; wc -l $output/3_endpoint_JS.txt


#Eyeiwtness
cd /root/script/4_getjs/EyeWitness
python EyeWitness.py -f $output/3_endpoint_JS.txt --all-protocols --no-prompt -d $output/3_endpoint_JS
cd /root/script/3_httprobe
