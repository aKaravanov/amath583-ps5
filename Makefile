#
# This file is part of the course materials for AMATH483/583 at the University of Washington,
# Spring 2019
#
# Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
# https://creativecommons.org/licenses/by-nc-sa/4.0/
#
# Author: Andrew Lumsdaine
#

CXX             := c++

# Maximum optimization effort: -O3 -march=native -DNDEBUG
OPTS            := -O3 -march=native -DNDEBUG 
LANG            := -std=c++17
PICKY           := -Wall
DIAG		:= # -Rpass=.*
DEFS		:= 
INCLUDES	:= -I../include 
LIBS		:= -lpython2.7 -lpthread

XINCLUDES	:= -I/usr/include/python2.7
XLIBS		:= 
VPATH		:= 

INCLUDES	+= $(XINCLUDES)
LIBS		+= $(XLIBS)

OS		:= $(shell uname -s)
ifeq ($(OS),Linux)
	LIBS	+= -lpthread
endif


CXXFLAGS	+= $(DEFS) $(OPTS) $(LANG) $(PICKY) $(INCLUDES) $(DIAG)

TARGETS		:= bonnie_and_clyde.exe bonnie_and_clyde_function_object.exe norm.exe pnorm.exe matvec.exe pagerank.exe
SOURCES		:= $(TARGETS:.exe=.cpp) amath583.cpp amath583IO.cpp amath583sparse.cpp
HEADERS		:= $(SOURCES:.cpp=.hpp)
OBJECTS		:= $(SOURCES:.cpp=.o)
PCHS		:= $(HEADERS:=.gch)

.PHONY		: defreport optreport clean depend all

all		: $(TARGETS)

%.exe        	: %.o
		  $(CXX) $(CXXFLAGS) $^ -o $@ $(LIBS)

%.o 		: %.cpp
		  $(CXX) -c $(CXXFLAGS) $< -o $@

%.s 		: %.cpp
		  $(CXX) -S $(CXXFLAGS) $<


norm.exe	: norm.o amath583.o
pnorm.exe	: pnorm.o amath583.o
matvec.exe      : matvec.o amath583.o

bonnie_and_clyde.exe : bonnie_and_clyde.o
bonnie_and_clyde_function_object.exe : bonnie_and_clyde_function_object.o

pagerank.exe    : pagerank.o amath583.o amath583IO.o  amath583sparse.o 


defreport	:
		  $(CXX) -dM -E -x c++ /dev/null

optreport	:
		  echo 'int;' | $(CXX) -xc++ $(CXXFLAGS) - -o /dev/null -\#\#\#

clean		:
		  /bin/rm -f $(TARGETS) $(OBJECTS) $(PCHS) Matrix.s a.out *~ Makefile.bak

depend		: 
	@ $(CXX) -MM $(LANG) $(INCLUDES) $(SOURCES) $(TESTS) > makedep
	@ echo '/^# DO NOT DELETE THIS LINE/+2,$$d' >eddep
	@ echo '$$r makedep' >>eddep
	@ echo 'w' >>eddep
	@ cp Makefile Makefile.bak
	@ ed - Makefile < eddep
	@ /bin/rm eddep makedep
	@ echo '# DEPENDENCIES MUST END AT END OF FILE' >> Makefile
	@ echo '# IF YOU PUT STUFF HERE IT WILL GO AWAY' >> Makefile
	@ echo '# see make depend above' >> Makefile

# The following 4 (yes 4) lines must be in all the subdirectory makefiles
#-----------------------------------------------------------------
# DO NOT DELETE THIS LINE -- make depend uses it
# DEPENDENCIES MUST END AT END OF FILE
bonnie_and_clyde.o: bonnie_and_clyde.cpp
bonnie_and_clyde_function_object.o: bonnie_and_clyde_function_object.cpp
norm.o: norm.cpp amath583.hpp Matrix.hpp Vector.hpp
pnorm.o: pnorm.cpp amath583.hpp Matrix.hpp Vector.hpp Timer.hpp \
  matplotlibcpp.h /usr/include/python2.7/Python.h \
  /usr/include/python2.7/patchlevel.h /usr/include/python2.7/pyconfig.h \
  /usr/include/python2.7/pymacconfig.h /usr/include/python2.7/pyport.h \
  /usr/include/python2.7/pymath.h /usr/include/python2.7/pymem.h \
  /usr/include/python2.7/object.h /usr/include/python2.7/objimpl.h \
  /usr/include/python2.7/pydebug.h \
  /usr/include/python2.7/unicodeobject.h \
  /usr/include/python2.7/intobject.h /usr/include/python2.7/boolobject.h \
  /usr/include/python2.7/longobject.h \
  /usr/include/python2.7/floatobject.h \
  /usr/include/python2.7/complexobject.h \
  /usr/include/python2.7/rangeobject.h \
  /usr/include/python2.7/stringobject.h \
  /usr/include/python2.7/memoryobject.h \
  /usr/include/python2.7/bufferobject.h \
  /usr/include/python2.7/bytesobject.h \
  /usr/include/python2.7/bytearrayobject.h \
  /usr/include/python2.7/tupleobject.h \
  /usr/include/python2.7/listobject.h \
  /usr/include/python2.7/dictobject.h \
  /usr/include/python2.7/enumobject.h /usr/include/python2.7/setobject.h \
  /usr/include/python2.7/methodobject.h \
  /usr/include/python2.7/moduleobject.h \
  /usr/include/python2.7/funcobject.h \
  /usr/include/python2.7/classobject.h \
  /usr/include/python2.7/fileobject.h /usr/include/python2.7/cobject.h \
  /usr/include/python2.7/pycapsule.h /usr/include/python2.7/traceback.h \
  /usr/include/python2.7/sliceobject.h \
  /usr/include/python2.7/cellobject.h \
  /usr/include/python2.7/iterobject.h /usr/include/python2.7/genobject.h \
  /usr/include/python2.7/descrobject.h /usr/include/python2.7/warnings.h \
  /usr/include/python2.7/weakrefobject.h /usr/include/python2.7/codecs.h \
  /usr/include/python2.7/pyerrors.h /usr/include/python2.7/pystate.h \
  /usr/include/python2.7/pyarena.h /usr/include/python2.7/modsupport.h \
  /usr/include/python2.7/pythonrun.h /usr/include/python2.7/ceval.h \
  /usr/include/python2.7/sysmodule.h /usr/include/python2.7/intrcheck.h \
  /usr/include/python2.7/import.h /usr/include/python2.7/abstract.h \
  /usr/include/python2.7/compile.h /usr/include/python2.7/code.h \
  /usr/include/python2.7/eval.h /usr/include/python2.7/pyctype.h \
  /usr/include/python2.7/pystrtod.h /usr/include/python2.7/pystrcmp.h \
  /usr/include/python2.7/dtoa.h /usr/include/python2.7/pyfpe.h
matvec.o: matvec.cpp Matrix.hpp Timer.hpp Vector.hpp amath583.hpp \
  matplotlibcpp.h /usr/include/python2.7/Python.h \
  /usr/include/python2.7/patchlevel.h /usr/include/python2.7/pyconfig.h \
  /usr/include/python2.7/pymacconfig.h /usr/include/python2.7/pyport.h \
  /usr/include/python2.7/pymath.h /usr/include/python2.7/pymem.h \
  /usr/include/python2.7/object.h /usr/include/python2.7/objimpl.h \
  /usr/include/python2.7/pydebug.h \
  /usr/include/python2.7/unicodeobject.h \
  /usr/include/python2.7/intobject.h /usr/include/python2.7/boolobject.h \
  /usr/include/python2.7/longobject.h \
  /usr/include/python2.7/floatobject.h \
  /usr/include/python2.7/complexobject.h \
  /usr/include/python2.7/rangeobject.h \
  /usr/include/python2.7/stringobject.h \
  /usr/include/python2.7/memoryobject.h \
  /usr/include/python2.7/bufferobject.h \
  /usr/include/python2.7/bytesobject.h \
  /usr/include/python2.7/bytearrayobject.h \
  /usr/include/python2.7/tupleobject.h \
  /usr/include/python2.7/listobject.h \
  /usr/include/python2.7/dictobject.h \
  /usr/include/python2.7/enumobject.h /usr/include/python2.7/setobject.h \
  /usr/include/python2.7/methodobject.h \
  /usr/include/python2.7/moduleobject.h \
  /usr/include/python2.7/funcobject.h \
  /usr/include/python2.7/classobject.h \
  /usr/include/python2.7/fileobject.h /usr/include/python2.7/cobject.h \
  /usr/include/python2.7/pycapsule.h /usr/include/python2.7/traceback.h \
  /usr/include/python2.7/sliceobject.h \
  /usr/include/python2.7/cellobject.h \
  /usr/include/python2.7/iterobject.h /usr/include/python2.7/genobject.h \
  /usr/include/python2.7/descrobject.h /usr/include/python2.7/warnings.h \
  /usr/include/python2.7/weakrefobject.h /usr/include/python2.7/codecs.h \
  /usr/include/python2.7/pyerrors.h /usr/include/python2.7/pystate.h \
  /usr/include/python2.7/pyarena.h /usr/include/python2.7/modsupport.h \
  /usr/include/python2.7/pythonrun.h /usr/include/python2.7/ceval.h \
  /usr/include/python2.7/sysmodule.h /usr/include/python2.7/intrcheck.h \
  /usr/include/python2.7/import.h /usr/include/python2.7/abstract.h \
  /usr/include/python2.7/compile.h /usr/include/python2.7/code.h \
  /usr/include/python2.7/eval.h /usr/include/python2.7/pyctype.h \
  /usr/include/python2.7/pystrtod.h /usr/include/python2.7/pystrcmp.h \
  /usr/include/python2.7/dtoa.h /usr/include/python2.7/pyfpe.h
pagerank.o: pagerank.cpp CSRMatrix.hpp Vector.hpp Matrix.hpp Timer.hpp \
  amath583.hpp amath583IO.hpp COOMatrix.hpp CSCMatrix.hpp AOSMatrix.hpp \
  amath583sparse.hpp
amath583.o: amath583.cpp amath583.hpp Matrix.hpp Vector.hpp
amath583IO.o: amath583IO.cpp amath583IO.hpp COOMatrix.hpp Matrix.hpp \
  Vector.hpp CSRMatrix.hpp CSCMatrix.hpp AOSMatrix.hpp
amath583sparse.o: amath583sparse.cpp Matrix.hpp Vector.hpp COOMatrix.hpp \
  CSRMatrix.hpp CSCMatrix.hpp AOSMatrix.hpp amath583sparse.hpp
# DEPENDENCIES MUST END AT END OF FILE
# IF YOU PUT STUFF HERE IT WILL GO AWAY
# see make depend above
