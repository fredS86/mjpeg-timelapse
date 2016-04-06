#/bin/sh

if [ $# -ne 2 ]
then
  echo "USAGE $0 indir destdir"
  echo "   indir correspond au outdir de timelapse.sh"
  echo "   destdir est le repertoir de destination"
  exit 1
fi

if [ -d $1/data ]
then 
  indir=$1/data
else
  if [ -d $1 ]
  then
    indir=$1
  else
    echo "indir $1 inexistant"
    exit 1
  fi
fi

mkdir -p $2
if [ ! -d $2 ]
then
  echo "destdir $2 inexistant"
  exit1
fi


for i in `ls -1 -v $indir | head -n -1`
do
  mv $indir/$i $2;
done

exit 0


