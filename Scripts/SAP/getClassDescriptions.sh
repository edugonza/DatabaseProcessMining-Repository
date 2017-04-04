#!/bin/bash

CLASSESFILE=classesForKeys.txt
HEADER="id;class_name;property;value"
TABLE_DESCRIPTION_FILE=classesDesc.csv

echo ${HEADER} > ${TABLE_DESCRIPTION_FILE}
count=1

for i in `cat ${CLASSESFILE}`; do
    CLASSNAME_LOWER=`echo ${i} | tr '[:upper:]' '[:lower:]' `
    URL="http://www.se80.co.uk/saptables/${CLASSNAME_LOWER:0:1}/${CLASSNAME_LOWER:0:4}/${CLASSNAME_LOWER}.htm"

    FIELDS=`curl -s ${URL} | tidy -q -asxhtml 2> /dev/null | tidy -q -i 2> /dev/null | xmlstarlet -q fo -R | sed -e 's/ xmlns.*=".*"//g' | xmlstarlet sel -T -t -m '//h1' -n -v "text()" 2> /dev/null`

    if [ "${FIELDS}" != "" ]; then
        split=$(echo ${FIELDS#*-} | tr -d "\n")
        echo "${count};${i};description;${split}" >> ${TABLE_DESCRIPTION_FILE}
	let "count=${count}+1"
    else
        echo ${i}
    fi
done


