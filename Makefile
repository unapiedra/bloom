#
# Open Bloom Filter MakeFile
# By Arash Partow - 2000
#
# URL: http://www.partow.net/programming/hashfunctions/index.html
#
# Copyright Notice:
# Free use of this library is permitted under the guidelines
# and in accordance with the most current version of the
# Common Public License.
# http://www.opensource.org/licenses/cpl1.0.php
#

COMPILER         = -c++
#COMPILER        = -clang
OPTIMIZATION_OPT = -O3
OPTIONS          = -pedantic-errors -ansi -Wall -Wextra -Werror -Wno-long-long $(OPTIMIZATION_OPT)
LINKER_OPT       = -L/usr/lib -lstdc++ -lm

BUILD_LIST+=bloom_filter_example01
BUILD_LIST+=bloom_filter_example02
BUILD_LIST+=bloom_filter_example03

all: $(BUILD_LIST)

$(BUILD_LIST) : %: %.cpp bloom_filter.hpp
	$(COMPILER) $(OPTIONS) -o $@ $@.cpp $(LINKER_OPT)

strip_bin :
	@for f in $(BUILD_LIST); do if [ -f $$f ]; then strip -s $$f; echo $$f; fi done; 

valgrind :
	@for f in $(BUILD_LIST); do \
		if [ -f $$f ]; then \
			cmd="valgrind --leak-check=full --show-reachable=yes --track-origins=yes --log-file=$$f.log -v ./$$f"; \
			echo $$cmd; \
			$$cmd; \
		fi done;

bloom_filter_example00: bloom_filter.hpp bloom_filter_example00.cpp
	$(COMPILER) $(OPTIONS) bloom_filter_example00 bloom_filter_example00.cpp $(LINKER_OPT)

clean:
	rm -f core *.o *.bak *stackdump *#

#
# The End !
#
