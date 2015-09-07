#!/usr/bin/env bash

CRITERIA=0
function fail {
    echo -e "\e[0;31mFAIL\e[0m"
    CRITERIA=1
}

function ok {
    echo -e "\e[0;32mPASS\e[0m"
}

function run_test {
    local _NAME=$1
    local _TEST=$2
    local _BEFORE=$3
    local _AFTER=$4
    if [ "${_BEFORE}" != "" ]; then
        echo -e "Running before \e[1;33m'${_NAME}'\e[0m"
        eval ${_BEFORE} &> /dev/null
    fi
    echo -ne "Running test case \e[1;33m'${_NAME}'\e[0m ... "
    local _RESULT=$(eval ${_TEST} &> /dev/null ; echo $?)
    test ${_RESULT} -eq 0 && ok || fail
    if [ "${_AFTER}" != "" ]; then
        echo -e "Running after \e[1;33m'$_NAME'\e[0m"
        eval ${_AFTER} &> /dev/null
    fi
    return ${_RESULT}
}

function main() {
    if [ "$CRITERIA" == "0" ]; then
        exit 0
    else
        exit -1
    fi
}

main
