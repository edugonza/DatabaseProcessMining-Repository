#!/bin/bash

function levenshtein {
	if [ "$#" -ne "2" ]; then
		echo "Usage: $0 word1 word2" >&2
	elif [ "${#1}" -lt "${#2}" ]; then
		levenshtein "$2" "$1"
	else
		local str1len=$((${#1}))
		local str2len=$((${#2}))
		local d i j
		for i in $(seq 0 $(((str1len+1)*(str2len+1)))); do
			d[i]=0
		done
		for i in $(seq 0 $((str1len)));	do
			d[$((i+0*str1len))]=$i
		done
		for j in $(seq 0 $((str2len)));	do
			d[$((0+j*(str1len+1)))]=$j
		done

		for j in $(seq 1 $((str2len))); do
			for i in $(seq 1 $((str1len))); do
				[ "${1:i-1:1}" = "${2:j-1:1}" ] && local cost=0 || local cost=1
				local del=$((d[(i-1)+str1len*j]+1))
				local ins=$((d[i+str1len*(j-1)]+1))
				local alt=$((d[(i-1)+str1len*(j-1)]+cost))
				d[i+str1len*j]=$(echo -e "$del\n$ins\n$alt" | sort -n | head -1)
			done
		done
		echo ${d[str1len+str1len*(str2len)]}
	fi
}

CLASSESFILE=classesForKeys.txt
KEYSFILE=keys.csv
HEADER="datamodel;relationship_name;class_source;class_target;attribute_source;attribute_target"

echo ${HEADER} > keys.csv

for i in `cat ${CLASSESFILE}`; do
    CLASSNAME_LOWER=`echo ${i} | tr '[:upper:]' '[:lower:]' `
    URL="http://www.se80.co.uk/saptables/${CLASSNAME_LOWER:0:1}/${CLASSNAME_LOWER:0:4}/${CLASSNAME_LOWER}.htm"

    FIELDS=`curl -s ${URL} | tidy -q -asxhtml 2> /dev/null | tidy -q -i 2> /dev/null | xmlstarlet -q fo -R | sed -e 's/ xmlns.*=".*"//g' | xmlstarlet sel -T -t -m '//tr[@class="keyField"]' -n -v "td[1]/*/text()" 2> /dev/null`

    if [ "${FIELDS}" != "" ]; then
        for j in ${FIELDS}; do
            echo "SAP;PK_${i};${i};;${j};" >> ${KEYSFILE}
        done

        FKFIELDS=`curl -s ${URL} | tidy -q -asxhtml 2> /dev/null | tidy -q -i 2> /dev/null | xmlstarlet -q fo -R | sed -e 's/ xmlns.*=".*"//g' | xmlstarlet sel -T -t -m '//tr[@class="otherField"]/td[5]/a/text()' -n -v "concat(.,';',../../../td[1]/*/text())" 2> /dev/null`
        if [ "${FKFIELDS}" != "" ]; then
            index=1
            for j in ${FKFIELDS}; do
                set -f
                split=(${j//;/ })
                dest_class=${split[0]}
                source_field=${split[1]}

                res=`grep ^${dest_class}$ ${CLASSESFILE}`
                if [ "${res}" != "" ]; then

                    dest_class_lower=`echo ${dest_class} | tr '[:upper:]' '[:lower:]'`
                    URL_2="http://www.se80.co.uk/saptables/${dest_class_lower:0:1}/${dest_class_lower:0:4}/${dest_class_lower}.htm"
                    TARGET_KEYS=`curl -s ${URL_2} | tidy -q -asxhtml 2> /dev/null | tidy -q -i 2> /dev/null | xmlstarlet -q fo -R | sed -e 's/ xmlns.*=".*"//g' | xmlstarlet sel -T -t -m '//tr[@class="keyField"]' -n -v "td[1]/*/text()" 2> /dev/null`

                    PREFERRED_FIELD=""
                    MIN_DISTANCE="-1"
                    for k in ${TARGET_KEYS}; do
                        if [ "${k}" != "MANDT" ]; then
                            NEW_DISTANCE=$(levenshtein "${source_field}" "${k}" )
                            if [ "${MIN_DISTANCE}" -lt "0" ]; then
                                MIN_DISTANCE=${NEW_DISTANCE}
                                PREFERRED_FIELD=${k}
                            else
                                if [ "${NEW_DISTANCE}" -lt "${MIN_DISTANCE}" ]; then
                                    PREFERRED_FIELD=${k}
                                    MIN_DISTANCE=${NEW_DISTANCE}
                                fi
                            fi
                        fi
                    done

                    echo "SAP;FK_${i}_${dest_class}_${index};${i};${dest_class};${source_field};${PREFERRED_FIELD}" >> ${KEYSFILE}
                    let index="$index+1"
                fi
            done
        fi
    else
        echo ${i}
    fi
done


