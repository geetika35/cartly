# Make sure to first use SSH and set the RSA host, otherwise it wont work!!
sshpass -p "Samismycat123" sftp gandrews@best-linux.cs.wisc.edu << !
	cd public
	cd html
	put testJSON2.json
!
