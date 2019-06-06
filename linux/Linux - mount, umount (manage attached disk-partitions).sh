#!/bin/bash

# check that file-system doesn't just say "data", otherwise it must be formatted
sudo file -s /dev/xvdf
sudo file -s /dev/sda1

# make a location to mount the drive
sudo mkdir /data

# mount a drive at a location
sudo mount /dev/xvdf1 /data

# unmount a drive
umount -d /dev/xvdf1
#  (^^ did this via AWS console
# 			shutdown EC2 Instance - volumes -> detach volume
# 			volume->attach volume - /dev/sd... <--- THIS NAME WAS KEY, MUST BE EXACTLY THIS - 2017-09-25, MCavallo)


#
# AWS | EBS (EC2) Encryption at Rest (EBS-Volume Encryption)
# 	It's possible to copy an unencrypted EBS snapshot to an encrypted EBS snapshot. So the following process can be used:
# 	1. Stop your EC2 instance.
# 	2. Create an EBS snapshot of the volume you want to encrypt.
# 	3. Copy the EBS snapshot, encrypting the copy in the process (checkbox somewhere along the way, "Encrypt...", can't miss it)
# 	4. Create a new EBS volume from your new encrypted EBS snapshot. The new EBS volume will be encrypted.
# 	5. Goto AWS Manager -> EC2 -> Volumes -> Click on the original (unencrypted) EBS volume & get the volume mapping from Attachment information...: "/dev/sda1" <--- Path should look similar to this
# 	6. Detach the original (unencrypted) EBS volume
# 	7. Attach your new (encrypted) EBS volume, making sure to match the device name (/dev/sda1, etc.)
#	
# AWS | RDS Encryption at Rest (Must make a new DB from a copied, encrypted Snapshot)
# 	1. Take a snapshot of RDS Instance (must leave it on to do this)
# 	2. Copy the snapshot, encrypting the copy in the process (checkbox somewhere along the way, "Encrypt...", can't miss it)
# 	3. Restore Database from the Encrypted Snapshot
# 	4. Redirect Traffic to new DB



#
#	Citation(s)
#
#		https://serverfault.com/questions/778759/how-to-convert-a-unencrypted-ebs-to-be-encrypted
#
#
