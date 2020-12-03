#[#scriptContent#=#string#
$disks = Get-Disk | Where partitionstyle -eq "raw"
$i=0
#$dLetter = [array]("[driveLetter]");
#$dLabel = [array]("[driveLabel]");
$dLetter = [array]([driveLetter]);
$dLabel = [array]([driveLabel]);

Foreach ($d in $disks){
	Initialize-Disk -Number $d.Number -PartitionStyle MBR -PassThru
	New-Partition -DiskNumber $d.Number -DriveLetter $dLetter[$i] -UseMaximumSize
	Format-Volume -DriveLetter $dLetter[$i] -FileSystem NTFS -NewFileSystemLabel $dLabel[$i] -Confirm:$false -Force
	$i=$i+1

}

#+#copyResource#=#boolean#false#+#scriptWorkingDirectory#=#string##+#scriptInteractiveSession#=#boolean#false#+#scriptTimeOut#=#number#120.0#+#deleteResourceAfterRun#=#boolean#true#+#resourceSearchReplace#=#boolean#false#+#scriptType#=#string#powershell#]#