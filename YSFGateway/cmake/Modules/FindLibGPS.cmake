if(NOT LIBGPS_FOUND)
	pkg_check_modules(LIBGPS_PKG libgps)
	find_path(LIBGPS_INCLUDE_DIR NAMES gps.h
			PATHS
			${LIBGPS_PKG_INCLUDE_DIRS}
			/usr/include/libgps
			/usr/include
			/usr/local/include
	)

	# standard library name for libgps
	set(libgps_library_names gps)

	find_library(LIBGPS_LIBRARIES
			NAMES ${libgps_library_names}
			PATHS
			${LIBGPS_PKG_LIBRARY_DIRS}
			/usr/lib
			/usr/lib/x86_64-linux-gnu
			/usr/local/lib
	)

	include(CheckFunctionExists)
	if(LIBGPS_INCLUDE_DIRS)
		set(CMAKE_REQUIRED_INCLUDES ${LIBGPS_INCLUDE_DIRS})
	endif()
	if(LIBGPS_LIBRARIES)
		set(CMAKE_REQUIRED_LIBRARIES ${LIBGPS_LIBRARIES})
	endif()

	if(LIBGPS_INCLUDE_DIR AND LIBGPS_LIBRARIES)
		set(LIBGPS_FOUND TRUE CACHE INTERNAL "libgps found")
		message(STATUS "Found libgps: ${LIBGPS_INCLUDE_DIR}, ${LIBGPS_LIBRARIES}")
	else(LIBGPS_INCLUDE_DIR AND LIBGPS_LIBRARIES)
		set(LIBGPS_FOUND FALSE CACHE INTERNAL "libgps found")
		message(STATUS "libgps not found.")
	endif(LIBGPS_INCLUDE_DIR AND LIBGPS_LIBRARIES)

	mark_as_advanced(LIBGPS_INCLUDE_DIR LIBGPS_LIBRARIES)

endif(NOT LIBGPS_FOUND)
