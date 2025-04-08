<#
.SYNOPSIS
    Creates a directory at a specified path with a given name.

.DESCRIPTION
    This script takes two arguments: the target path and the name of the directory
    to create. It checks if the target path exists and is a directory before
    attempting to create the new directory. It also checks if the directory
    already exists at the specified path.

.PARAMETER Path
    The full path where you want to create the new directory.

.PARAMETER DirectoryName
    The name of the directory you want to create.

.EXAMPLE
    .\Create-Directory.ps1 -Path "C:\Temp" -DirectoryName "NewFolder"

    Creates a directory named "NewFolder" inside the "C:\Temp" directory.

.EXAMPLE
    .\Create-Directory.ps1 -Path "\\ServerName\Share\Data" -DirectoryName "ProjectX"

    Creates a directory named "ProjectX" inside the network share "\\ServerName\Share\Data".
#>
param(
    [Parameter(Mandatory=$true)]
    [string]$Path,

    [Parameter(Mandatory=$true)]
    [string]$DirectoryName
)

# Construct the full path
$FullPath = Join-Path -Path $Path -ChildPath $DirectoryName

# Check if the target path exists and is a directory
if (-not (Test-Path -Path $Path -PathType Container)) {
    Write-Error "Error: Path '$Path' does not exist or is not a directory."
    exit 1
}

# Check if the directory already exists at the specified path
if (Test-Path -Path $FullPath -PathType Container) {
    Write-Host "Directory '$FullPath' already exists."
} else {
    try {
        # Create the directory
        New-Item -Path $FullPath -ItemType Directory | Out-Null
        if ($?) {
            Write-Host "Directory '$DirectoryName' created successfully at '$Path'."
        } else {
            Write-Error "Error creating directory '$DirectoryName' at '$Path'."
            exit 1
        }
    } catch {
        Write-Error "An unexpected error occurred while creating the directory: $($_.Exception.Message)"
        exit 1
    }
}

exit 0
