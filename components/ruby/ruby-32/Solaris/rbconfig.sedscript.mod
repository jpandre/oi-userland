#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#

#
# Copyright (c) 2013, 2014, Oracle and/or its affiliates. All rights reserved.
#
# sed script to fix the rbconfig.rb file after
# the configure and install of ruby

# use gcc/g++ instead of build-system-specific  paths to cc or CC

# Note that for the first two command lines below,
# /usr/bin/sed correctly substitutes; /usr/bin/gsed does not.
# Use /usr/bin/sed for this script.
s|\'CC=.*/cc\'|\'CC=/usr/gcc/13/bin/gcc\'|
s|\'CXX=.*/CC\'|\'CXX=/usr/gcc/13/bin/g++\'|
s|CONFIG\[\"CC\"\].*$|CONFIG\[\"CC\"\] = \"/usr/gcc/13/bin/gcc\"|
s|CONFIG\[\"CXX\"\].*$|CONFIG\[\"CXX\"\] = \"/usr/gcc/13/bin/g++\"|
s/CONFIG\[\"CFLAGS\"\].*$/CONFIG\[\"CFLAGS\"\] = \"-g -O3 -fPIC\"/
s/CONFIG\[\"CCDLFLAGS\"\].*$/CONFIG\[\"CCDLFLAGS\"\] = \"-fPIC\"/
s/"$(CC) -G"/"$(CC) -shared"/
s/"$(CXX) -G"/"$(CXX) -shared"/

# These paths to GNU commands are symlinks which are only available when
# the pkg facet.gnu-links is true, so use the non-faceted paths
s/\/usr\/bin\/ginstall/\/usr\/gnu\/bin\/install/
s/\/usr\/bin\/gmkdir/\/usr\/gnu\/bin\/mkdir/
s/\/usr\/bin\/gsed/\/usr\/gnu\/bin\/sed/

# add this line to the end of the file
$a\
ENV["GEM_HOME"] = "/usr/ruby/3.2/lib/ruby/gems/3.2"
