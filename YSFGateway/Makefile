#
# Makefile for YSFGateway
#


CC      := gcc
CXX     := g++
CPP     := cpp
LD      := ld
AS      := as
NM      := nm
SIZE    := size
OBJCOPY := objcopy
OBJDUMP := objdump

RM      := rm
INSTALL := install
ECHO    := echo


OPTLVL := 3
DBGLVL := 0
CSTD   := gnu11
CXXSTD := gnu++14


# Use the following CFLAGS and LIBS if you don't want to use gpsd.
CFLAGS   := -g$(DBGLVL) -O$(OPTLVL) -Wall -DHAVE_LOG_H -std=$(CSTD) -pthread
CXXFLAGS := -g$(DBGLVL) -O$(OPTLVL) -Wall -DHAVE_LOG_H -std=$(CXXSTD) -pthread
LIBS     := -lm -lpthread

# Use the following CFLAGS and LIBS if you do want to use gpsd.
#CFLAGS  = -g -O3 -Wall -DHAVE_LOG_H -DUSE_GPSD -std=c++0x -pthread
#LIBS    = -lm -lpthread -lgps

LDFLAGS := -g$(DBGLVL)

OBJECTS := APRSWriter.o \
		Conf.o \
		CRC.o \
		DTMF.o \
		FCSNetwork.o \
		Golay24128.o \
		GPS.o \
		Log.o \
		StopWatch.o \
		Sync.o \
		Thread.o \
		Timer.o \
		UDPSocket.o \
		Utils.o \
		WiresX.o \
		YSFConvolution.o \
		YSFFICH.o \
		YSFGateway.o \
		YSFNetwork.o \
		YSFPayload.o \
		YSFReflectors.o

all:	YSFGateway

YSFGateway:	$(OBJECTS)
	$(CXX) $(OBJECTS) $(CXXFLAGS) $(LIBS) -o YSFGateway

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

YSFGateway.o: GitVersion.h FORCE

.PHONY: GitVersion.h

FORCE:

install:
	install -m 755 YSFGateway /usr/local/bin/
	install -m 755 -d /usr/local/share/YSFClients/YSFGateway
	install -m 755 YSFHostsUpdate.sh /usr/local/share/YSFClients/YSFGateway/YSFHostsUpdate.sh
	install -m 644 YSFHosts.txt /usr/local/share/YSFClients/YSFGateway/YSFHosts.txt
	install -m 644 YSFGateway.ini /usr/local/etc/YSFGateway.ini
	install -m 644 systemd/ysfgateway.service /etc/systemd/system/ysfgateway.service

clean:
	$(RM) YSFGateway *.o *.d *.bak *~ GitVersion.h


# Export the current git version if the index file exists, else 000...
GitVersion.h:
ifneq ("$(wildcard ../.git/index)","")
	echo "const char *gitversion = \"$(shell git rev-parse HEAD)\";" > $@
else
	echo "const char *gitversion = \"0000000000000000000000000000000000000000\";" > $@
endif
