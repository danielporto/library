#!/bin/bash

usage() { 
    echo "Usage: $0 [-c <ycsb|counter>] [-l <single|multi>] [-d <yes|no>]" 1>&2; 
    echo "Where 'c' is a short for configuration, 'l' for type of loader and 'd' indicates if durable or not."
    exit 1; 
}

while getopts ":c:l:d:" o; do
    case "${o}" in
        c)
            c=${OPTARG}
            ((c == 'ycsb' || c == 'counter')) || usage
            ;;
        l)
            l=${OPTARG}
            ((l == 'single' || l == 'multi')) || usage
            ;;
        d)
            d=${OPTARG}
            ((d == 'yes' || d == 'no')) || usage
            ;;

        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${c}" ] || [ -z "${l}" ] || [ -z "${d}" ]; then
    usage
    exit
fi

# echo "s = ${c}"
# echo "p = ${l}"
# echo "d = ${d}"

if [ ${c} == 'ycsb' -a ${l} == 'single' -a ${d} == 'yes'  ]; then
    echo "ycsb, single and durable."
    rm docker-compose.yml
    ln -s dockerfiles/docker-compose-ycsb-durable.yml docker-compose.yml
    echo "Configuration written."
elif [ ${c} == 'ycsb' -a ${l} == 'single'  -a ${d} == 'no'  ]; then
    echo "ycsb, single and memory."
    # cp dockerfiles/docker-compose-ycsb-durable.yml docker-compose.yml
    echo "Not yet implemented."

elif [ ${c} == 'ycsb' -a ${l} == 'multi'  -a ${d} == 'yes'  ]; then
    echo "ycsb, multi and durable."
    # cp dockerfiles/docker-compose-ycsb-durable.yml docker-compose.yml
    echo "Not yet implemented."

elif [ ${c} == 'ycsb' -a ${l} == 'multi'  -a ${d} == 'no'  ]; then
    echo "ycsb, multi and memory."
    # cp dockerfiles/docker-compose-ycsb-durable.yml docker-compose.yml
    echo "Not yet implemented."

elif [ ${c} == 'counter' -a ${l} == 'single' -a ${d} == 'yes'  ]; then
    echo "counter, single and durable."
    # cp dockerfiles/docker-compose-ycsb-durable.yml docker-compose.yml
    echo "Not yet implemented."

elif [ ${c} == 'counter' -a ${l} == 'single'  -a ${d} == 'no'  ]; then
    echo "counter, single and memory."
    # cp dockerfiles/docker-compose-ycsb-durable.yml docker-compose.yml
    echo "Not yet implemented."
elif [ ${c} == 'counter' -a ${l} == 'multi'  -a ${d} == 'yes'  ]; then
    echo "counter, multi and durable."
    # cp dockerfiles/docker-compose-ycsb-durable.yml docker-compose.yml
    echo "Not yet implemented."
elif [ ${c} == 'counter' -a ${l} == 'multi'  -a ${d} == 'no'  ]; then
    echo "counter, multi and memory."
    # cp dockerfiles/docker-compose-ycsb-durable.yml docker-compose.yml
    echo "Not yet implemented."
fi;