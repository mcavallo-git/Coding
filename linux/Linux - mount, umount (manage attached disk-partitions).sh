#!/bin/bash

# check that file-system doesn't just say "data", otherwise it must be formatted
sudo file -s /dev/sda1
sudo file -s /dev/xvda1

# make a location to mount the drive
sudo mkdir /data

# mount a drive at a location
mkdir -p "/mnt/xvda1";
sudo mount "/dev/xvda1" "/mnt/xvda1";

# unmount a drive
umount -d "/dev/xvda1"
#
# ^^ did this via AWS console
#    shutdown EC2 Instance - volumes -> detach volume
#    volume->attach volume - /dev/sda1




#
# AWS | EBS (EC2) Encryption at Rest
#  |
#  |--> Overview: Create a snapshot of unencrypted volume - find the snapshot -> create volume -> select "enrcypted". While EC2 is off, find the old partition/volume's mount-path, then indiana jones the new volume onto the EC2 instance by first unmounting the old volume, then mounting the new volume @ the same mount-path. Done.
#
# 	1. Stop your EC2 instance.
# 	2. Create an EBS snapshot of the volume you want to encrypt.
# 	3. Copy the EBS snapshot, encrypting the copy in the process (checkbox somewhere along the way, "Encrypt...", can't miss it)
# 	4. Create a new EBS volume from your new encrypted EBS snapshot. The new EBS volume will be encrypted.
# 	5. Goto AWS Manager -> EC2 -> Volumes -> Click on the original (unencrypted) EBS volume & get the volume mapping from Attachment information...: "/dev/sda1" <--- Path should look similar to this
# 	6. Detach the original (unencrypted) EBS volume
# 	7. Attach your new (encrypted) EBS volume, making sure to match the device name (/dev/sda1, etc.)
#	

#
# AWS | RDS Encryption at Rest
#  |
#  |--> Overview: Create a snapshot of unencrypted volume - find the snapshot -> restore snapshot -> select "enrcypted". Apply security groups. Point services to new hostname. Done.
#
# 	1. Take a snapshot of RDS Instance (must leave it on to do this)
# 	2. Copy the snapshot, encrypting the copy in the process (checkbox somewhere along the way, "Encrypt...", can't miss it)
# 	3. Restore Database from the Encrypted Snapshot
# 	4. Redirect Traffic to new DB
#


#
#	Citation(s)
#
#		https://serverfault.com/questions/778759/how-to-convert-a-unencrypted-ebs-to-be-encrypted
#
#
