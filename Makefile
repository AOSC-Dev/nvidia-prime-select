DESTDIR = /
PREFIX = $(DESTDIR)/usr/local
SYSCONFDIR = $(DESTDIR)/etc
PRIMECONFDIR = $(SYSCONFDIR)/nvidia-prime
BINDIR = $(PREFIX)/bin
SBINDIR = $(PREFIX)/sbin
DATADIR = $(PREFIX)/share
UNITDIR = $(PREFIX)/lib/systemd/system

.PHONY: all install uninstall

all: install

install:
	install -Dm644 data/xorg.nvidia.conf $(PRIMECONFDIR)/xorg.nvidia.conf
	install -Dm644 data/xorg.intel.conf $(PRIMECONFDIR)/xorg.intel.conf
	install -Dm755 rc.local $(PRIMECONFDIR)/rc.local
	install -Dm755 rc.nvidia $(PRIMECONFDIR)/rc.nvidia
	install -Dm755 nvidia-prime-select $(SBINDIR)/nvidia-prime-select
	install -Dm755 nvidia-prime-ui $(BINDIR)/nvidia-prime-ui
	install -Dm644 data/nvidia-prime.png $(DATADIR)/pixmaps/nvidia-prime.png
	install -Dm644 data/nvidia-prime-ui.desktop $(DATADIR)/applications/nvidia-prime-ui.desktop
	install -Dm644 data/nvidia-prime.service $(UNITDIR)/nvidia-prime.service
	install -Dm644 data/com.github.pkexec.nvidia-prime-ui.policy $(DATADIR)/polkit-1/actions/com.github.pkexec.nvidia-prime-ui.policy

uninstall:
	systemctl disable nvidia-prime.service
	rm -rf $(PRIMECONFDIR)
	rm -f /usr/sbin/nvidia-prime-select
	rm -f /usr/bin/nvidia-prime-ui
	rm -f /usr/share/pixmaps/nvidia-prime.png
	rm -f /usr/share/applications/nvidia-prime-ui.desktop
	rm -f /usr/lib/systemd/system/nvidia-prime.service
	rm -f /etc/X11/xinit/xinitrc.d/nvidia
