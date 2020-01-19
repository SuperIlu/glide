#!/bin/bash
set -euo pipefail

# use DJGPP 4.7.3 for Glide3!
export DJDIR=/home/ilu/djgpp473
export PATH=${DJDIR}/bin:$PATH:${DJDIR}/i586-pc-msdosdjgpp/bin

test -d swlibs || ln -s ../swlibs swlibs

##
# clean specific hardware version
function fxClean {
	HW="$1"
	make -f Makefile.DJ "FX_GLIDE_HW=${HW}" clean
}

##
# compile specific hardware version
function fxCompile {
	HW="$1"
	fxClean "${HW}"
	make -f Makefile.DJ "FX_GLIDE_HW=${HW}" USE_X86=0 CC=i586-pc-msdosdjgpp-gcc AR=i586-pc-msdosdjgpp-ar
}

##
# compile tests for specific hardware version
function fxTests {
	HW="$1"

	if [ "${HW}" == "sst96" ]; then
		HW=sst1
	fi

	cd "${HW}/glide3/tests/"

	make -f Makefile.DJ clean	
	make -f Makefile.DJ sbench.exe

	for i in $(seq -f "%02.0f" 00 39); do
		make -f Makefile.DJ "test${i}.exe"
	done

	cd ../../..
}

##
# create output directories and copy
function fxCopy {
	HW="$1"
	TYPE="$2"
	shift 2

	INC="${OUTDIR}/${TYPE}/include"
	LIB="${OUTDIR}/${TYPE}/lib"
	TST="${OUTDIR}/${TYPE}/test"

	# make directories
	mkdir -p "${INC}" "${LIB}" "${TST}"

	# copy includes
	cp "$@" "${INC}"

	# copy libs
	if [ "${HW}" == "sst1" ]; then
		LSRC="${HW}"/lib/"${HW}"
	elif [ "${HW}" == "sst96" ]; then
		LSRC=sst1/lib/"${HW}"
	else
		LSRC="${HW}"/lib
	fi
	cp "${LSRC}"/*.a "${LSRC}"/*.dxe "${LIB}"
	sort <"${LSRC}"/symbols.txt >"${LIB}"/symbols.txt

	# copy tests
	if [ "${HW}" == "sst96" ]; then
		cp sst1/glide3/tests/*.exe sst1/glide3/tests/*.3df "${TST}"
	else
		cp "${HW}"/glide3/tests/*.exe "${HW}"/glide3/tests/*.3df "${TST}"
	fi
}



##
# define output
OUTDIR=$(pwd)/output
rm -rf "${OUTDIR}"
mkdir "${OUTDIR}"

##
# Voodoo rush (is built first because i want the sst1 to remain in the build directory for DOSBox-x tests!)
fxCompile sst96
fxTests sst96
fxCopy sst96 rush \
	swlibs/fxmisc/3dfx.h \
	sst1/glide3/src/glide.h \
	sst1/glide3/src/glidesys.h \
	sst1/glide3/src/glideutl.h \
	sst1/init/sst1vid.h
fxClean sst96

##
# Voodoo1
fxCompile sst1
fxTests sst1
fxCopy sst1 v1 \
	swlibs/fxmisc/3dfx.h \
	sst1/glide3/src/glide.h \
	sst1/glide3/src/glidesys.h \
	sst1/glide3/src/glideutl.h \
	sst1/init/sst1vid.h
fxClean sst1

##
# Voodoo2
fxCompile cvg
fxTests cvg
fxCopy cvg v2 \
 	swlibs/fxmisc/3dfx.h \
 	cvg/glide3/src/glide.h \
 	cvg/glide3/src/glidesys.h \
 	cvg/glide3/src/glideutl.h \
 	cvg/incsrc/sst1vid.h
fxClean cvg

##
# Voodoo3/Banshee
fxCompile h3
fxTests h3
fxCopy h3 v3 \
 	swlibs/fxmisc/3dfx.h \
 	h3/glide3/src/g3ext.h \
 	h3/glide3/src/glide.h \
 	h3/glide3/src/glidesys.h \
 	h3/glide3/src/glideutl.h \
 	h3/incsrc/sst1vid.h
fxClean h3

##
# Voodoo4/5
fxCompile h5
fxTests h5
fxCopy h5 v4 \
 	swlibs/fxmisc/3dfx.h \
 	h5/glide3/src/g3ext.h \
 	h5/glide3/src/glide.h \
 	h5/glide3/src/glidesys.h \
 	h5/glide3/src/glideutl.h \
 	h5/incsrc/sst1vid.h
fxClean h5
