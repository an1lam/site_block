SITES_FILE=$2
ARG=$1
echo "Ran program" >> ./job.log
ROOT_UID="0"
#Check if run as root
if [ "$UID" -ne "$ROOT_UID" ] ; then
  echo "You must be root to do that!"
  exit 1
fi

function block_sites {
  while read line;
  do
    echo "0.0.0.0 $line" >> /etc/hosts
    echo "0.0.0.0 www.$line" >> /etc/hosts
  done < $1
}

function unblock_sites {
  sed -i -e '/0.0.0.0/d' /etc/hosts 
}


function usage {
  echo "Usage: ./toggle_block_sites [ -b|u ]"
}

if [ "$ARG" == "-b" ]
then
  block_sites $SITES_FILE
elif [ "$ARG" == "-u" ]
then
  unblock_sites 
else
  usage;
  exit 1;
fi
