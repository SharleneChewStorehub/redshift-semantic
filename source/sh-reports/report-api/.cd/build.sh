#!/bin/bash
# Compatible With Jenkins
# Script For build
[ -z ${WORKSPACE} ]&&WORKSPACE="."
cd ${WORKSPACE}
yarn
yarn build
