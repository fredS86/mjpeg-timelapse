#/bin/sh

if [ $# -ne 5 ]
then
  echo "USAGE $0 indir prefix suffix"
  echo "   indir correspond au dossier ayant des fichiers images a convertir"
  echo "   prefix est le prefix des fichiers à convertir"
  echo "   suffix est le suffix des fichiers à convertir"
  echo "   framerate est nombre d'images par secondes pour la video"
  echo "   destFile est le fichier video cible"
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
framerate=$4
destfile=$5

currentdir=`pwd`

cd $indir;
avconv -i "$prefix%06d$suffix" -r $framerate $destfile

cd $currentdir

exit 0


