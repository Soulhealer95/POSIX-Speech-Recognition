#__author__= "Shivam S"
#__email__= "saxens12@mcmaster.ca"
# * SPDX-License-Identifier: BSD-1-Clause
# *
# * Copyright (c) 2022
# *	Shivam S.  All rights reserved.
# *
# * Redistribution and use in source and binary forms, with or without
# * modification, are permitted provided that the following conditions
# * are met:
# * 1. Redistributions of source code must retain the above copyright
# *    notice, this list of conditions and the following disclaimer.
# *
# * THIS SOFTWARE IS PROVIDED BY saxens12@mcmaster.ca ``AS IS'' AND
# * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# * ARE DISCLAIMED.  IN NO EVENT SHALL saxens12@mcmaster.ca BE LIABLE
# * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# * SUCH DAMAGE.

#!/bin/bash


# Defines
RECORD_TEMP_FILE="temp_record.wav"

echo "==================Initializing Environment==================="
if [[ `which virtualenv` == "" ]]; then
	echo "virtualenv is required for this to work properly!"
	echo "please install with apt-get install virtualenv"
	exit
fi
virtualenv -p python3 $HOME/tmp/deepspeech-venv/
source $HOME/tmp/deepspeech-venv/bin/activate
if [[ `pip3 list | grep -i deep` == "" ]]; then
	pip3 install deepspeech;
fi

echo "=====Done!======="
echo "Starting Program..."

sleep 1
ARG=$1
# If argument was not provided, try recording voice
if [[ -z "$ARG" ]];then
	echo "Please say what would you like me to do? [Up to 5 seconds]"
	arecord -q -d 5 -t wav -f cd $RECORD_TEMP_FILE
	ARG=$RECORD_TEMP_FILE
fi
python3 `pwd`/start_deep.py $ARG
