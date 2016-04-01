#/bin/bash

if [ $# -ne 5 ]; then
echo "USAGE $0 videoname sleeptime nbframes cameraName1,cameraName2,... url1,url2,..."
echo "    sleeptime est au format de la commande sleep 1s, 3m, ..."
echo "    pour un nombre illimite de frames, mettre un nombre negatif"
exit 1;
fi

prefix=image-
suffix=
extension=jpg

# Recuperation des parametres
VIDEONAME=$1
SLEEPTIME=$2
NBFRAMES=$3
OLDIFS=$IFS
IFS=,
CAMERAS=($4)
URLS=($5)
IFS=$OLDIFS

# Verification des parametres
cameraNumber=${#CAMERAS[@]}
urlNumber=${#URLS[@]}
if [ $cameraNumber -ne $urlNumber ]; then

echo "Le nombre de camera($cameraNumber) doit correspondre au nombre d'URL($urlNumber)."
exit 1;
fi

# Gestion des dossier de sortie et de log
OUTPUTDIR=./$VIDEONAME/data
LOGDIR=./$VIDEONAME/log

mkdir -p $LOGDIR
for i in ${CAMERAS[@]}; do
  mkdir -p $OUTPUTDIR/$i
done

# init des index de depart pour chaque camera
for i in ${!CAMERAS[@]}; do
  touch $OUTPUTDIR/${CAMERAS[$i]}/${prefix}0$suffix.$extension
  index[$i]=$((`ls -1 -v $OUTPUTDIR/${CAMERAS[$i]} | grep "${prefix}[0-9][0-9]*$suffix\.$extension" | tail -n 1 | sed -e "s/${prefix}\([0-9][0-9]*\)$suffix\.$extension/\1/"`+1))
  rm -f $OUTPUTDIR/${CAMERAS[$i]}/${prefix}0$suffix.$extension
done

# acquisition des frames pour chaque camera
while [ $NBFRAMES -ne 0 ]; do
  for i in ${!CAMERAS[@]}; do
    wget --background --append-output $LOGDIR/${CAMERAS[$i]}.log --output-document $OUTPUTDIR/${CAMERAS[$i]}/$prefix`printf "%06.f" "${index[$i]}"`$suffix.$extension ${URLS[$i]}
    index[$i]=$((${index[$i]}+1))
  done

  #  on decompte le nombre de frames et on s'endort suivant le rythme demande
  NBFRAMES=$(($NBFRAMES-1))
  sleep $SLEEPTIME
done

