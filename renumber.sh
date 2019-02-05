#/bin/sh

if [ $# -ne 3 ]
then
  echo "USAGE $0 indir prefix suffix"
  echo "   indir correspond au dossier ayant des fichiers a renumeroter"
  echo "   prefix est le prefix des fichiers à numeroter"
  echo "   suffix est le suffix des fichiers à numeroter"
  exit 1
fi

if [ -d $1 ]
then
indir=$1
else
echo "indir $1 inexistant"
exit 1
fi

prefix=$2
suffix=$3

rm renumber.log
index=1;
for i in `ls -1 -v $prefix*$suffix`
do 
  echo $i `printf "$prefix%06.f$suffix" "$index"` >> renumber.log;
  mv $i `printf "$prefix%06.f$suffix" "$index"`;
  index=$(($index+1));
done


exit 0


