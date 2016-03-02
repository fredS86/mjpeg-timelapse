#/bin/sh                                                                        
                                                                                
if [ $# -ne 3 ]; then                                                           
  echo "USAGE $0 videoname cameraName1,cameraName2,... url1,url2,..."           
  exit 1;                                                                       
fi                                                                              
                                                                                
VIDEONAME=$1                                                                    
OLDIFS=$IFS                                                                     
IFS=,                                                                           
CAMERAS=($2)                                                                    
URLS=($3)                                                                       
IFS=$OLDIFS                                                                     
                                                                                
cameraNumber=${#CAMERAS[@]}                                                     
urlNumber=${#URLS[@]}                                                           
if [ $cameraNumber -ne $urlNumber ]; then                                       
  echo "Le nombre de camera($cameraNumber) doit correspondre au nombre d'URL($urlNumber)."
  exit 1;
fi                                                                              
                                                                                
OUTPUTDIR=./$VIDEONAME/data                                                     
LOGDIR=./$VIDEONAME/log                                                         
mkdir -p $LOGDIR                                                                
                                                                                
for i in ${CAMERAS[@]}; do                                                      
  mkdir -p $OUTPUTDIR/$i                                                        
done

while [ 1 -eq 1 ]; do                                                           
  TIMESTAMP=`date +%Y%m%d-%H%M%S.%N`                                              
  for i in ${!CAMERAS[@]}; do                                                     
    wget --background --append-output $LOGDIR/${CAMERAS[$i]}.log --output-documen$
  done                                                                            
                                                                                
  # faire un sleep en fonction de la frequence demandee                           
  sleep 3s                                                                        
done                                                                            
                      