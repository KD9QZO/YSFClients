#
# Makefile for YSFGateway
#

PRJ := YSFGateway

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


INSTALL_BASE    := /usr/local
INSTALL_BIN     := $(INSTALL_BASE)/bin
INSTALL_ETC     := $(INSTALL_BASE)/etc
INSTALL_SHARE   := $(INSTALL_BASE)/share/YSFClients/YSFGateway
INSTALL_SYSTEMD := /etc/systemd/system


OPTLVL := 2
DBGLVL := 2
CSTD   := gnu11
CXXSTD := gnu++14


# Use the following CFLAGS and LIBS if you don't want to use gpsd.
CFLAGS   := -g$(DBGLVL) -O$(OPTLVL) -Wall -DHAVE_LOG_H -std=$(CSTD) -pthread
CXXFLAGS := -g$(DBGLVL) -O$(OPTLVL) -Wall -DHAVE_LOG_H -std=$(CXXSTD) -pthread
LIBS     := -lm -lpthread

# Use the following CFLAGS and LIBS if you do want to use gpsd.
#CFLAGS   := -g$(DBGLVL) -O$(OPTLVL) -Wall -DHAVE_LOG_H -DUSE_GPSD -std=$(CSTD) -pthread
#CXXFLAGS := -g$(DBGLVL) -o$(OPTLVL) -Wall -DHAVE_LOG_H -DUSE_GPSD -std=$(CXXSTD) -pthread
#LIBS     := -lm -lpthread -lgps

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

all:	$(PRJ)

$(PRJ):	$(OBJECTS)
	$(CXX) $(OBJECTS) $(CXXFLAGS) $(LIBS) -o $(PRJ)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

YSFGateway.o: GitVersion.h FORCE

.PHONY: GitVersion.h

FORCE:

install:
	install -m 755 $(PRJ) $(INSTALL_BIN)/
	install -m 755 -d $(INSTALL_SHARE)
	install -m 755 YSFHostsUpdate.sh $(INSTALL_SHARE)/YSFHostsUpdate.sh
	install -m 644 YSFHosts.txt $(INSTALL_SHARE)/YSFHosts.txt
	install -m 644 FCSRooms.txt $(INSTALL_SHARE)/FCSRooms.txt
	install -m 644 YSFGateway.ini $(INSTALL_ETC)/YSFGateway.ini
	install -m 644 YSFGateway.ini $(INSTALL_SHARE)/YSFGateway.ini.sample
	install -m 644 systemd/ysfgateway.service $(INSTALL_SYSTEMD)/ysfgateway.service
	systemd daemon-reload

clean:
	$(RM) -f $(PRJ)
	$(RM) -f *.o *.d
	$(RM) -f *.bak *~
	$(RM) -f GitVersion.h


# Export the current git version if the index file exists, else 000...
GitVersion.h:
ifneq ("$(wildcard ../.git/index)","")
	echo "const char *gitversion = \"$(shell git rev-parse HEAD)\";" > $@
else
	echo "const char *gitversion = \"0000000000000000000000000000000000000000\";" > $@
endif
