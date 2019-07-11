#!/bin/bash

usage() { 
    echo "Usage: $0 [-c <ycsb|counter|bench>] [-l <single|multi>] [-d <yes|no>]" 1>&2; 
    echo "Where 'c' is a short for configuration, 'l' for type of loader and 'd' indicates if durable or not."
    exit 1; 
}

while getopts ":c:l:d:" o; do
    case "${o}" in
        c)
            c=${OPTARG}
            ((c == 'ycsb' || c == 'counter' || c == 'bench' )) || usage
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
cleanup() {
    rm -f docker-compose.yml
    rm -f config/system.config
    rm -f config/currentView
    echo "Configuration clean."
}


configure_ycsb() {
    cleanup;
    echo "Configuring YCSB deployment: $1, durable: $2"

    if [ ${1} == 'single' -a ${2} == 'yes'  ]; then
        echo "ycsb, single and durable."
        ln -s dockerfiles/docker-compose-ycsb-durable.yml docker-compose.yml
        cp config/system.config.durable config/system.config
    elif [ ${1} == 'single'  -a ${2} == 'no'  ]; then
        echo "ycsb, single and memory."
        ln -s dockerfiles/docker-compose-ycsb.yml docker-compose.yml
        cp config/system.config.default config/system.config
    elif [ {$1} == 'multi'  -a ${2} == 'yes'  ]; then
        echo "ycsb, multi and durable."
        echo "Not yet implemented."
    elif [ {$1} == 'multi'  -a ${2} == 'no'  ]; then
        echo "ycsb, multi and memory."
        echo "Not yet implemented."
        exit;
    fi    
    
    echo "Configuration written."
}

configure_counter() {
    cleanup;
    echo "Configuring counter deployment: $1, durable: $2"

    if [ ${1} == 'single' -a ${2} == 'yes'  ]; then
        echo "counter, single and durable."
        echo "Not yet implemented."
        exit;
    elif [ ${1} == 'single'  -a ${2} == 'no'  ]; then
        echo "counter, single and memory."
        ln -s dockerfiles/docker-compose-counter.yml docker-compose.yml
        cp config/system.config.default config/system.config
    elif [ ${1} == 'multi'  -a ${2} == 'yes'  ]; then
        echo "counter, multi and durable."
        echo "Not yet implemented."
        exit;
    elif [ ${1} == 'multi'  -a ${2} == 'no'  ]; then
        echo "counter, multi and memory."
        echo "Not yet implemented."
        exit;
    fi

    echo "Configuration written."
}

configure_benchmark() {
    cleanup;
    echo "Configuring microbenchmark deployment: $1, durable: $2"

    if [ ${1} == 'single' -a ${2} == 'yes'  ]; then
        echo "microbenchmark, single and durable."
        echo "Not yet implemented."
        exit;
    elif [ ${1} == 'single'  -a ${2} == 'no'  ]; then
        echo "microbenchmark, single and memory."
        ln -s dockerfiles/docker-compose-microbenchmark.yml docker-compose.yml
        cp config/system.config.default config/system.config
    elif [ ${1} == 'multi'  -a ${2} == 'yes'  ]; then
        echo "microbenchmark, multi and durable."
        echo "Not yet implemented."
        exit;
    elif [ ${1} == 'multi'  -a ${2} == 'no'  ]; then
        echo "microbenchmark, multi and memory."
        echo "Not yet implemented."
        exit;
    fi

    echo "Configuration written."
}






case "${c}" in
    ycsb)
        configure_ycsb ${l} ${d}
        ;;
    counter)
        configure_counter ${l} ${d}
        ;;
    bench)
        configure_benchmark ${l} ${d}
        ;;
    *)
        usage
        ;;
esac