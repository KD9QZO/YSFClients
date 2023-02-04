# Copyright 2013 OSMOCOM Project
#
# This file is part of osmo-fl2k
#
# rtl-sdr is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# rtl-sdr is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with rtl-sdr; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.

if(DEFINED __INCLUDED_GITVERSION_CMAKE)
    return()
endif()
set(__INCLUDED_GITVERSION_CMAKE TRUE)

# VERSION_INFO_* variables must be provided by user
#set(MAJOR_VERSION ${VERSION_INFO_MAJOR_VERSION})
#set(MINOR_VERSION ${VERSION_INFO_MINOR_VERSION})
#set(PATCH_VERSION ${VERSION_INFO_PATCH_VERSION})

########################################################################
# Extract the version string from git describe.
########################################################################
find_package(Git QUIET)

if(GIT_FOUND)
    message(STATUS "Extracting version information from git describe...")
    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
        OUTPUT_VARIABLE GITVERSION OUTPUT_STRIP_TRAILING_WHITESPACE
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )
else()
    set(GITVERSION "0000000000000000000000000000000000000000")
endif()
