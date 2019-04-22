#!/bin/bash

# If not root, break and require root
if [ `whoami` != root ]; then
  echo Script requires root to run
  exit
fi

# Flush old rules
iptables -F

### Firewall rules ###

#____SERVER RULES
#___Web___
iptables -A INPUT -p TCP --dport 80 -j ACCEPT
iptables -A OUTPUT -p TCP --sport 80 -j ACCEPT
iptables -A INPUT -p TCP --dport 443 -j ACCEPT
iptables -A OUTPUT -p TCP --sport 443 -j ACCEPT

#___SSH___
iptables -A INPUT -p TCP --dport 22 -j ACCEPT
iptables -A OUTPUT -p TCP --sport 22 -j ACCEPT

#___Loopback___
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT


#____Client Rules____

#__Web__
iptables -A INPUT -p TCP --sport 80 -j ACCEPT
iptables -A OUTPUT -p TCP --dport 80 -j ACCEPT
iptables -A INPUT -p TCP --sport 443 -j ACCEPT
iptables -A OUTPUT -p TCP --dport 443 -j ACCEPT

#__DNS__
iptables -A INPUT -p UDP --sport 53 -j ACCEPT
iptables -A OUTPUT -p UDP --dport 53 -j ACCEPT

#__Group Policy__
# _LDAP_
iptables -A OUTPUT -p TCP --dport 389 -j ACCEPT
iptables -A INPUT -p TCP --sport 389 -j ACCEPT
iptables -A OUTPUT -p UDP --dport 389 -j ACCEPT
iptables -A INPUT -p UDP --sport 389 -j ACCEPT
# _LDAP SSL_
iptables -A OUTPUT -p TCP --dport 636 -j ACCEPT
iptables -A INPUT -p TCP --sport 636 -j ACCEPT
# _SMB_
iptables -A OUTPUT -p TCP --dport 445 -j ACCEPT
iptables -A INPUT -p TCP --sport 445 -j ACCEPT
# _RPC_
iptables -A OUTPUT -p TCP --dport 135 -j ACCEPT
iptables -A INPUT -p TCP --sport 135 -j ACCEPT
# _Active Directory Web Services_
iptables -A OUTPUT -p TCP --dport 9389 -j ACCEPT
iptables -A INPUT -p TCP --sport 9389 -j ACCEPT
# _Global Catalog_
iptables -A OUTPUT -p TCP --dport 3268 -j ACCEPT
iptables -A INPUT -p TCP --sport 3268 -j ACCEPT
iptables -A OUTPUT -p TCP --dport 3269 -j ACCEPT
iptables -A INPUT -p TCP --sport 3269 -j ACCEPT
# _IPsec ISAKMP
iptables -A OUTPUT -p UDP --dport 500 -j ACCEPT
iptables -A INPUT -p UDP --sport 500 -j ACCEPT
# _NAT-T_
iptables -A OUTPUT -p UDP --dport 4500 -j ACCEPT
iptables -A INPUT -p UDP --sport 4500 -j ACCEPT


#___Drop everything else___
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP