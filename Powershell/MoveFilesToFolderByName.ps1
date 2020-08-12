## Moves files to subdirectory based beginning of name ##
# This is the parent directory for the files and sorted folders
$basePath = "E:\Brentwood\Finance\LiaisonEDD\TestInvoices"

# This sets that folder as your CWD (Current working directory)
Set-Location $basePath

# This grabs the *files* underneath the parent directory, ignoring sub directories
$files = Get-ChildItem $basePath | Where-Object {$_.PSIsContainer -eq $false}

# Starts iterating through each file
foreach ($file in $files) {
    # Split the base file name by underscore (creates an array with each part of the name seperated)
    $split = $file.BaseName -split "_"
    # Store the first item [0] in the array $split as the sub folder name
    $sub = "$basePath\$($split[0])"

    # Check if the sub folder exists, create it if not
    if (!(Test-Path $sub -ErrorAction SilentlyContinue)) {
        New-Item $sub -ItemType Directory | Out-Null
    }

    # Move the file to the sub folder
    Move-Item $file.FullName -Destination $sub -Verbose
}

<## Original ##
# This is the parent directory for the files and sorted folders
$basePath = "C:\test\Docs"

# This sets that folder as your CWD (Current working directory)
Set-Location $basePath

# This grabs the *files* underneath the parent directory, ignoring sub directories
$files = Get-ChildItem $basePath | Where-Object {$_.PSIsContainer -eq $false}

# Starts iterating through each file
foreach ($file in $files) {
    # Split the base file name by underscore (creates an array with each part of the name seperated)
    $split = $file.BaseName -split "_"
    # Store the second item [1] in the array $split as the root folder name
    $root = "$basePath\$($split[1])"
    # Store the first item [0] in the array $split as the sub folder name
    $sub = "$root\$($split[0])"

    # Check if the root folder exists, create it if not
    if (!(Test-Path $root -ErrorAction SilentlyContinue)) {
        New-Item $root -ItemType Directory | Out-Null
    }

    # Check if the sub folder exists, create it if not
    if (!(Test-Path $sub -ErrorAction SilentlyContinue)) {
        New-Item $sub -ItemType Directory | Out-Null
    }

    # Move the file to the sub folder
    Move-Item $file.FullName -Destination $sub -Verbose
}
#>
