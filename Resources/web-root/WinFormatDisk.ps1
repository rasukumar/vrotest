
Param(
	[string]$driveLetter,
	[string]$driveLabel
)	

trap { 

    Write-Error $_  | out-file C:\temp\outfile.txt -Append 
    exit 1 

} 

write "hello world" | out-file C:\temp\outfile.txt
 
$disks = Get-Disk | Where partitionstyle -eq "raw"
write $disks | out-file C:\temp\outfile.txt -Append

$i=0
write "letters: $driveLetter" | out-file C:\temp\outfile.txt -Append
write "labels: $driveLabel" | out-file C:\temp\outfile.txt -Append
$dLetter = $driveLetter.Split(" ");
$dLabel = $driveLabel.Split(" ");

Foreach ($d in $disks){
	$diskNum = $d.Number
	write "---disk number: $diskNum" | out-file C:\temp\outfile.txt -Append
	write $dLetter[$i] | out-file C:\temp\outfile.txt -Append
	write $dLabel[$i] | out-file C:\temp\outfile.txt -Append
	write "inside for each ..." | out-file C:\temp\outfile.txt -Append
	Initialize-Disk -Number $d.Number -PartitionStyle MBR -PassThru | out-file C:\temp\outfile.txt -Append
	New-Partition -DiskNumber $d.Number -DriveLetter $dLetter[$i] -UseMaximumSize | out-file C:\temp\outfile.txt -Append
	Format-Volume -DriveLetter $dLetter[$i] -FileSystem NTFS -NewFileSystemLabel $dLabel[$i] -Confirm:$false -Force | out-file C:\temp\outfile.txt -Append
	$i=$i+1

}
