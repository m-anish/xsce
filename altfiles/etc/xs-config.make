##
## XS config make file
##
## See /usr/share/doc/xs-config-<version>/README for
## how this works...
##
all: syslog.conf motd yum.conf sysctl.conf ssh/sshd_config \
     sysconfig/dhcpd sysconfig/named sysconfig/init \
     sysconfig/iptables-config sysconfig/squid \
     sudoers rssh.conf

# Any file that has a ".in"
# 'template' can be made with this catch-all
# that is just a straight cp -p right now.
##
##  - Do not use with resolv.conf, idmgr.conf.in
##       or named-xs.conf.in
##  - If you add a more specific rule it will
##    override this rule for your target.
% :: %.in
	# It may be dirty
	xs-commitchanged -m 'Dirty state' $@
	# Overwrite
	cp -p $@.in $@
	xs-commitchanged -m "Made from $@.in" $@

sudoers: sudoers.d/*
	touch sudoers.tmp
	chmod 640 sudoers.tmp
	cat-parts sudoers.d > sudoers.tmp
	chmod 440 sudoers.tmp
	xs-commitchanged -m 'Dirty state' $@
	mv -f sudoers.tmp sudoers
	xs-commitchanged -m "Made from sudoers.d" $@

