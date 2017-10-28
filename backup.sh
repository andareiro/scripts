#!/bin/bash
ext_hdd_path="/media/bern/Seagate_1TB"
ext_hdd_bucket="s3://andarquivo_ext"
bern_path="/home/bern"
bern_bucket="s3://andarquivo"

# Check if the external HDD is connected, then run sync
if mount | grep -q $ext_hdd_path; then
	echo "External HDD mounted, syncing now"
	aws s3 sync $ext_hdd_path $ext_hdd_bucket --sse --storage-class STANDARD_IA
else
	echo "External HDD not mounted"
fi

# Check if home directory is known, then run sync
if [ -d $bern_path ]; then
	echo "Home directory found, syncing now"
	aws s3 sync $bern_path $bern_bucket --sse --storage-class STANDARD_IA
else
	echo "Home directory not found"
fi
