#
# CMakeLists.txt for YSFGateway
#



###############################################################################
# PROJECT SETUP                                                               #
###############################################################################

project(YSFGateway)

cmake_minimum_required(VERSION 3.18)

if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Release")
	message(STATUS "Build type not specified; defaulting to Release.")
endif(NOT CMAKE_BUILD_TYPE)
set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING "")


include(GNUInstallDirs)

set(prefix ${CMAKE_INSTALL_PREFIX})
set(YSFGATEWAY_SHARE_DIR ${CMAKE_INSTALL_PREFIX}/share/YSFClients/YSFGateway)
set(YSFGATEWAY_ETC_DIR ${CMAKE_INSTALL_PREFIX}/etc)
set(SYSTEMD_DIR /etc/systemd/system)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)

set(SOURCES
	APRSWriter.cpp
	Conf.cpp
	CRC.cpp
	DTMF.cpp
	FCSNetwork.cpp
	Golay24128.cpp
	GPS.cpp
	Log.cpp
	StopWatch.cpp
	Sync.cpp
	Thread.cpp
	Timer.cpp
	UDPSocket.cpp
	Utils.cpp
	WiresX.cpp
	YSFConvolution.cpp
	YSFFICH.cpp
	YSFGateway.cpp
	YSFNetwork.cpp
	YSFPayload.cpp
	YSFReflectors.cpp
)



###############################################################################
# COMPILER SPECIFIC SETUP                                                     #
###############################################################################

if(CMAKE_COMPILER_IS_GNUCC AND NOT WIN32)
	add_definitions(-Wall)
endif()

#set_property(TARGET YSFGateway PROPERTY C_STANDARD 11)
#set_property(TARGET YSFGateway PROPERTY CXX_STANDARD 14)

add_definitions(-DHAVE_LOG_H)
#add_definitions(-pthread)



find_package(PkgConfig REQUIRED)

set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
set(THREADS_PREFER_PTHREAD_FLAG TRUE)

find_package(Threads REQUIRED)
if(NOT THREADS_FOUND)
	message(FATAL_ERROR "pthreads is required to build YSFGateway")
endif()

find_package(LibGPS)
option(ENABLE_GPSD "Enable support for gpsd integration" ON)
if(LIBGPS_FOUND)
	add_definitions(-DUSE_GPSD)
	set(ENABLE_GPSD ON)
	message(STATUS "libgps include directory: ${LIBGPS_INCLUDE_DIR}")
else(LIBGPS_FOUND)
	set(ENABLE_GPSD OFF)
	message(STATUS "libgps was not found")
endif(LIBGPS_FOUND)


include_directories(
	${CMAKE_SOURCE_DIR}
	${CMAKE_CURRENT_BINARY_DIR}
	${THREADS_PTHREADS_INCLUDE_DIR}
)


add_executable(YSFGateway ${SOURCES})

set_property(TARGET YSFGateway PROPERTY C_STANDARD 11)
set_property(TARGET YSFGateway PROPERTY CXX_STANDARD 14)

#target_include_directories(YSFGateway ${LIBGPS_INCLUDE_DIR})

if(UNIX)
	target_link_libraries(YSFGateway m)
endif()

target_link_libraries(YSFGateway Threads::Threads)

if(LIBGPS_FOUND)
	include_directories(${LIBGPS_INCLUDE_DIR})
	target_link_libraries(YSFGateway ${LIBGPS_LIBRARIES})
endif()


########################################################################################################################
# INSTALLATION                                                                                                         #
########################################################################################################################

install(
	FILES ${CMAKE_SOURCE_DIR}/YSFGateway.ini
	DESTINATION "${YSFGATEWAY_ETC_DIR}"
)

install(
	FILES ${CMAKE_SOURCE_DIR}/systemd/ysfgateway.service
	DESTINATION "${SYSTEMD_DIR}"
)
