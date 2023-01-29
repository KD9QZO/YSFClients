

project(YSFGateway)

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


add_definitions(-DHAVE_LOG_H)
#add_definitions(-pthread)

set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
set(THREADS_PREFER_PTHREAD_FLAG TRUE)

find_package(Threads REQUIRED)
if(NOT THREADS_FOUND)
	message(FATAL_ERROR "pthreads is required to build YSFGateway")
endif()


include_directories(
		${CMAKE_SOURCE_DIR}
		${THREADS_PTHREADS_INCLUDE_DIR}
)


add_executable(YSFGateway ${SOURCES})

target_link_libraries(YSFGateway Threads::Threads)
