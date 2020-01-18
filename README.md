**sezero**
This is the source code to 3Dfx Glide for Voodoo graphics accelerators.
It's forked from the original CVS repo of Glide open source project at
sourceforge:  https://sourceforge.net/projects/glide/
Source is licensed under 3DFX GLIDE Source Code General Public License:
see 'glide_license.txt' under the glide2x, glide3x or swlibs directory.

**SuperIlu**
I need working Glide3 libraries as DXE for my [DOjS](https://github.com/SuperIlu/DOjS) project. The DXEs need to be interoperable. This repository contains my struggles to get this...

I added a cross compile script ``cross.sh`` to the glide3x directory.
To get working binaries I needed to compile a DJGPP with GCC 4.7.3
using the script at https://github.com/andrewwutw/build-djgpp

Binaries generated with GCC 7.2.0 only got me a black screen on real hardware.

``cross.ch`` will create an ``output/`` directory in the glide3x directory with includes, link libraries and test cases for all types of hardware.

What has been done/tested so far:
* Compilation of libglide3i.a and libglide3x.a as well as glide3x.dxe for all flavours of hardware
* Voodoo1/SST1 test cases run on [DOSBox-x](https://github.com/joncampbell123/dosbox-x) and on a real Voodoo 1. These test cases were statically linked (no DXE yet).
* Voodoo2 test cases run on real hardware.

What needs to be done/tested:
* All other hardware flavours (I'm able to test V1/V2/V3/Rush/Banshe, I won't be able to test V4 and V5)
* DXE interoperability, e.g. compiling against V1 link library and using V2 DXE
