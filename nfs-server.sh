#!/bin/bash
set -x
lsmod

modprobe nfs
modprobe nfsd

echo "/storage   ${NFS_ACL-*}(fsid=0,rw,sync,insecure,no_subtree_check,anonuid=1000,anongid=1000,crossmnt)" > /etc/exports
exportfs -rav
service rpcbind restart
service nfs-kernel-server restart
