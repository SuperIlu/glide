#!/bin/bash

# use DJGPP 4.7.3 for Glide3!
export DJDIR=/home/ilu/djgpp473
export PATH=${DJDIR}/bin:$PATH:${DJDIR}/i586-pc-msdosdjgpp/bin

test -d swlibs || ln -s ../swlibs swlibs

function fxClean {
	make -f Makefile.DJ FX_GLIDE_HW=$1 clean	|| exit 1
}

function fxCompile {
	fxClean $1
	make -f Makefile.DJ FX_GLIDE_HW=$1 USE_X86=0 CC=i586-pc-msdosdjgpp-gcc AR=i586-pc-msdosdjgpp-ar	|| exit 1
}

function fxTests {
	make -f Makefile.DJ clean		|| exit 1
	make -f Makefile.DJ sbench.exe	|| exit 1

	make -f Makefile.DJ test00.exe	|| exit 1
	make -f Makefile.DJ test01.exe	|| exit 1
	make -f Makefile.DJ test02.exe	|| exit 1
	make -f Makefile.DJ test03.exe	|| exit 1
	make -f Makefile.DJ test04.exe	|| exit 1
	make -f Makefile.DJ test05.exe	|| exit 1
	make -f Makefile.DJ test06.exe	|| exit 1
	make -f Makefile.DJ test07.exe	|| exit 1
	make -f Makefile.DJ test08.exe	|| exit 1
	make -f Makefile.DJ test09.exe	|| exit 1

	make -f Makefile.DJ test10.exe	|| exit 1
	make -f Makefile.DJ test11.exe	|| exit 1
	make -f Makefile.DJ test12.exe	|| exit 1
	make -f Makefile.DJ test13.exe	|| exit 1
	make -f Makefile.DJ test14.exe	|| exit 1
	make -f Makefile.DJ test15.exe	|| exit 1
	make -f Makefile.DJ test16.exe	|| exit 1
	make -f Makefile.DJ test17.exe	|| exit 1
	make -f Makefile.DJ test18.exe	|| exit 1
	make -f Makefile.DJ test19.exe	|| exit 1

	make -f Makefile.DJ test20.exe	|| exit 1
	make -f Makefile.DJ test21.exe	|| exit 1
	make -f Makefile.DJ test22.exe	|| exit 1
	make -f Makefile.DJ test23.exe	|| exit 1
	make -f Makefile.DJ test24.exe	|| exit 1
	make -f Makefile.DJ test25.exe	|| exit 1
	make -f Makefile.DJ test26.exe	|| exit 1
	make -f Makefile.DJ test27.exe	|| exit 1
	make -f Makefile.DJ test28.exe	|| exit 1
	make -f Makefile.DJ test29.exe	|| exit 1

	make -f Makefile.DJ test30.exe	|| exit 1
	make -f Makefile.DJ test31.exe	|| exit 1
	make -f Makefile.DJ test32.exe	|| exit 1
	make -f Makefile.DJ test33.exe	|| exit 1
	make -f Makefile.DJ test34.exe	|| exit 1
	make -f Makefile.DJ test35.exe	|| exit 1
	make -f Makefile.DJ test36.exe	|| exit 1
	make -f Makefile.DJ test37.exe	|| exit 1
	make -f Makefile.DJ test38.exe	|| exit 1
	make -f Makefile.DJ test39.exe	|| exit 1
}

OUTDIR=`pwd`/output

rm -rf ${OUTDIR}					|| exit 1
mkdir ${OUTDIR}						|| exit 1

# Voodoo1
fxCompile sst1						|| exit 1

mkdir ${OUTDIR}/v1					|| exit 1
mkdir ${OUTDIR}/v1/include			|| exit 1
cp \
	swlibs/fxmisc/3dfx.h \
	sst1/glide3/src/glide.h \
	sst1/glide3/src/glidesys.h \
	sst1/glide3/src/glideutl.h \
	sst1/init/sst1vid.h \
	${OUTDIR}/v1/include			|| exit 1

mkdir ${OUTDIR}/v1/lib				|| exit 1
cp sst1/lib/sst1/* ${OUTDIR}/v1/lib	|| exit 1
cd sst1/glide3/tests/
fxTests
mkdir ${OUTDIR}/v1/test
cp *.exe ${OUTDIR}/v1/test			|| exit 1
cd ../../..
fxClean sst1						|| exit 1


# Voodoo2
fxCompile cvg
mkdir ${OUTDIR}/v2					|| exit 1
mkdir ${OUTDIR}/v2/include			|| exit 1
cp \
	swlibs/fxmisc/3dfx.h \
	cvg/glide3/src/glide.h \
	cvg/glide3/src/glidesys.h \
	cvg/glide3/src/glideutl.h \
	cvg/incsrc/sst1vid.h \
	${OUTDIR}/v2/include			|| exit 1

mkdir ${OUTDIR}/v2/lib				|| exit 1
cp cvg/lib/* ${OUTDIR}/v2/lib		|| exit 1
cd cvg/glide3/tests/
fxTests
mkdir ${OUTDIR}/v2/test				|| exit 1
cp *.exe ${OUTDIR}/v2/test			|| exit 1
cd ../../..
fxClean cvg							|| exit 1


# Voodoo3/Banshee
fxCompile h3
mkdir ${OUTDIR}/v3					|| exit 1
mkdir ${OUTDIR}/v3/include			|| exit 1
cp \
	swlibs/fxmisc/3dfx.h \
	h3/glide3/src/g3ext.h \
	h3/glide3/src/glide.h \
	h3/glide3/src/glidesys.h \
	h3/glide3/src/glideutl.h \
	h3/incsrc/sst1vid.h \
	${OUTDIR}/v3/include			|| exit 1

mkdir ${OUTDIR}/v3/lib				|| exit 1
cp h3/lib/* ${OUTDIR}/v3/lib		|| exit 1
cd h3/glide3/tests/
fxTests
mkdir ${OUTDIR}/v3/test				|| exit 1
cp *.exe ${OUTDIR}/v3/test			|| exit 1
cd ../../..
fxClean h3							|| exit 1

# Voodoo4/5
fxCompile h5
mkdir ${OUTDIR}/v4					|| exit 1
mkdir ${OUTDIR}/v4/include			|| exit 1
cp \
	swlibs/fxmisc/3dfx.h \
	h5/glide3/src/g3ext.h \
	h5/glide3/src/glide.h \
	h5/glide3/src/glidesys.h \
	h5/glide3/src/glideutl.h \
	h5/incsrc/sst1vid.h \
	${OUTDIR}/v4/include			|| exit 1

mkdir ${OUTDIR}/v4/lib				|| exit 1
cp h5/lib/* ${OUTDIR}/v4/lib		|| exit 1
cd h5/glide3/tests/
fxTests
mkdir ${OUTDIR}/v4/test				|| exit 1
cp *.exe ${OUTDIR}/v4/test			|| exit 1
cd ../../..
fxClean h5							|| exit 1

exit 1

# Voodoo rush
fxCompile sst96
cd sst1/glide3/tests/
fxTests
cd ../../..

