#!/bin/bash
echo "---Checking if Zandronum Server is installed---"
if [ ! -f ${DATA_DIR}/zandronum-server ]; then
	echo "---Zandronum Server not found, downloading!---"
	cd ${DATA_DIR}
	if wget -q -nc --show-progress --progress=bar:force:noscroll -O ${DATA_DIR}/zandronum.tar.bz2 https://zandronum.com/downloads/zandronum3.0-linux-x86_64.tar.bz2 ; then
		echo "---Successfully downloaded Zandronum Server---"
	else
		echo "---Download of Zandronum Server failed, putting container into sleep mode!---"
	sleep infinity
	fi
	tar -xvf ${DATA_DIR}/zandronum.tar.bz2
	rm ${DATA_DIR}/zandronum.tar.bz2
	chmod +x ${DATA_DIR}/zandronum-server
else
	echo "---Zandronum found, continuing!---"
fi

echo "---Preparing Server---"
if [ ! -f ${DATA_DIR}/server.cfg ]; then
	echo "---No 'server.cfg' found, downloading...---"
	cd ${DATA_DIR}
	if wget -q -nc --show-progress --progress=bar:force:noscroll https://github.com/ich777/docker-zandronum/raw/master/cfg/server.cfg ; then
		echo "---Successfully downloaded 'server.cfg'---"
	else
		echo "---Can't download 'server.cfg', putting container into sleep mode!---"
	fi
else
	echo "---'server.cfg' found, continuing!---"
fi
if [ ! -f ${DATA_DIR}/GeoIP.dat ]; then
	echo "---No 'GeoIP.dat' found, downloading...---"
	cd ${DATA_DIR}
	if wget -q -nc --show-progress --progress=bar:force:noscroll https://github.com/ich777/docker-zandronum/raw/master/geo/GeoLite2.tar.gz ; then
		echo "---Successfully downloaded 'GeoIP.dat'---"
	else
		echo "---Can't download 'GeoIP.dat', continuing!---"
	fi
	if [ -d ${DATA_DIR}/GeoLite2License ]; then
		mkdir -p ${DATA_DIR}/GeoLite2License
	fi
	tar -C ${DATA_DIR}/GeoLite2License --strip-components=1 -xf ${DATA_DIR}/GeoLite2.tar.gz
	rm ${DATA_DIR}/GeoLite2.tar.gz
	mv ${DATA_DIR}/GeoLite2License/GeoLite2-Country.mmdb ${DATA_DIR}/GeoIP.dat
else
	echo "---'GeoIP.dat' found, continuing!---"
fi
if [ ! -d ${DATA_DIR}/wads ]; then
	mkdir -p ${DATA_DIR}/wads
fi
export DOOMWADDIR=/zandronum/wads
if [ -z "$(find ${DATA_DIR}/wads -iname *.wad)" ]; then
	echo "---------------------------------------------------------------------------"
	echo "---No 'wads' found, please be sure to put your wad files in the '/wads'----"
	echo "---folder located in the main directory, putting server into sleep mode!---"
	echo "---------------------------------------------------------------------------"
	echo "----If you put more files in this folder you have to specify which file----"
	echo "-----the server should load and you have to append the GAME_PARAMS eg:-----"
	echo "-----'-iwad DOOM2.WAD' please not that the wad file is case sensitive!-----"
	echo "---------------------------------------------------------------------------"
	sleep infinity
fi
chmod -R ${DATA_PERM} ${DATA_DIR}


echo "---Starting Server---"
cd ${DATA_DIR}
LD_LIBRARY_PATH=${DATA_DIR} ${DATA_DIR}/zandronum-server ${GAME_PARAMS}