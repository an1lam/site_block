SITES_FILE=$2
ARG=$1

block_sites () {
  while read line;
  do
    echo "0.0.0.0 $line" >> /etc/hosts
    echo "0.0.0.0 www.$line" >> /etc/hosts
    echo "0.0.0.0 https://$line" >> /etc/hosts
  done < $1
}

unblock_sites () {
  sed -i -e '/0.0.0.0/d' /etc/hosts 
}


usage () {
  echo "Usage: ./toggle_block_sites [ -b|u ]"
}

if [ "$ARG" = "-b" ]
then
  block_sites $SITES_FILE
elif [ "$ARG" = "-u" ]
then
  unblock_sites
else
  usage;
  exit 1;
fi
