#!/bin/bash
#
# Copyright (c) 2016 RedCoolBeans <info@redcoolbeans.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Author: J. Lievisse Adriaanse <jasper@redcoolbeans.com>

: ${BACULA_DEBUG:="50"}
: ${LOG_FILE:="/var/log/bacula.log"}
: ${DIR_NAME:="bacula"}
: ${DIR_IP:="192.168.1.14"}
: ${FD_NAME:="bacula"}

# Only one variable is required, FD_PASSWORD. MON_FD_PASSWORD is derived from it.
if [ -z "${FD_PASSWORD}" ]; then
	echo "==> FD_PASSWORD must be set, exiting"
	exit 1
fi

: ${MON_FD_PASSWORD:="${FD_PASSWORD}"}

CONFIG_VARS=(
  FD_NAME
  FD_PASSWORD
  DIR_NAME
  MON_NAME
  MON_FD_PASSWORD
)

if [ -z "${DIR_IP}" ]; then
	echo "==> Adding DIR_IP to /etc/hosts"
	echo "${DIR_IP} ${DIR_NAME}" >> /etc/hosts
fi

cp /etc/bacula/bacula-fd.conf.orig /etc/bacula/bacula-fd.conf
for c in ${CONFIG_VARS[@]}; do
  sed -i "s,@@${c}@@,$(eval echo \$$c)," /etc/bacula/bacula-fd.conf
done

echo "==> Verifying Bacula FD configuration"
/usr/sbin/bacula-fd -c /etc/bacula/bacula-fd.conf -t

echo "==> Starting Bacula FD"
/usr/sbin/bacula-fd -c /etc/bacula/bacula-fd.conf -d ${BACULA_DEBUG} -f
