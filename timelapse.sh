#/bin/bash

if [ $# -ne 4 ]; then
echo "USAGE $0 outdir url sleeptime nbframes"
echo "    sleeptime est au format de la commande sleep 1s, 3m, ..."
echo "    pour un nombre illimite de frames, mettre un nombre negatif"
exit 1;
fi

prefix=image-
suffix=
extension=jpg

# Recuperation des parametres
BASEDIR=$1
SLEEPTIME=$3
NBFRAMES=$4
URL=$2

# Gestion des dossier de sortie et de log
OUTPUTDIR=$BASEDIR/data
mkdir -p $OUTPUTDIR
LOGDIR=$BASEDIR/log
mkdir -p $LOGDIR

# init de l'index de depart
touch $OUTPUTDIR/${prefix}0$suffix.$extension
index=$((`ls -1 -v $OUTPUTDIR | grep "${prefix}[0-9][0-9]*$suffix\.$extension" | tail -n 1 | sed -e "s/${prefix}\([0-9][0-9]*\)$suffix\.$extension/\1/"`+1))
rm -f $OUTPUTDIR/${prefix}0$suffix.$extension

# acquisition des frames
while [ $NBFRAMES -ne 0 ]; do
  wget --background --append-output $LOGDIR/http.log --output-document $OUTPUTDIR/$prefix`printf "%06.f" "$index"`$suffix.$extension $URL
  index=$(($index+1))

  #  on decompte le nombre de frames et on s'endort suivant le rythme demande
  NBFRAMES=$(($NBFRAMES-1))
  sleep $SLEEPTIME
done

