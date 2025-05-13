# Get the free space and total size of the C: drive
$drive = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'"


# Calculate free space in GB
$freeSpaceGB = [math]:: Round($drive. FreeSpace / 1GB, 2)
$totalSizeGB = [math]:: Round($drive.Size / 1GB, 2)

# Print the results
Write-Output "C: Drive Total Size: $totalSizeGB GB"
Write-Output "C: Drive Free Space: $freeSpaceGB GB"
Write-Output "C: Drive Free Space Percentage: $([math]:: Round(($drive. FreeSpace / $drive.Size) * 100, 2))%"