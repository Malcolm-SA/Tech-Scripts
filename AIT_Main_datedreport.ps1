# Change the execution Environment automatically for the user, to override Operating System policies in place
# Set execution policy to RemoteSigned

Set-ExecutionPolicy RemoteSigned -Scope Process -Force

# Get the directory of the currently executing script
$ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Get all script files in the folder excluding the main script
$mainScriptFileName = Split-Path -Leaf $MyInvocation.MyCommand.Path
$scriptFiles = Get-ChildItem -Path $ScriptDirectory -Filter "*.ps1" | Where-Object { $_.Name -ne $mainScriptFileName } | Select-Object -ExpandProperty Name

if (-not $ScriptDirectory) {
    Write-Host "Error: Script directory could not be determined."
    exit
}

# First launch Animation
Clear

$lines = @(
    "        AAAAAA       IIIIIIIIIIIIIIIIIIIIIIII TTTTTTTTTTTTTTTTTTTTTTTTTT ",
    "      AAAAAAAAAA     IIIII::::::::::::::IIIII TT::::::::::::::::::::::TT ",
    "     AAAAA  AAAAA    IIIIIIIIII::::IIIIIIIIII TT::::::::::::::::::::::TT ",
    "    AAAAA    AAAAA          III::::III        TT:::::TT:::::::TT::::::TT ",
    "   AAAAA      AAAAA         III::::III         TTTTTT  T:::::T  TTTTTT   ",
    "  AAAAA        AAAAA        III::::III                 T:::::T           ",
    "  AAAAA        AAAAA        III::::III                 T:::::T           ",
    "  AAAAA  AAAA  AAAAA        III::::III                 T:::::T           ",
    "  AAAAA AAAAAA AAAAA        III::::III                 T:::::T           ",
    "  AAAAA  AAAA  AAAAA        III::::III                 T:::::T           ",
    "  AAAAA        AAAAA        III::::III                 T:::::T           ",
    "  AAAAA        AAAAA        III::::III                 T:::::T           ",
    "  AAAAAA      AAAAAA        III::::III                 T:::::T           ",
    "  AAAAAA      AAAAAA   IIIIIIII::::IIIIIIIII         T:::::::::T         ",
    "AAAAAAAAAA  AAAAAAAAAAIIII::::::::::::::IIIII       TT:::::::::TT        ",
    "AAAAAAAAAA  AAAAAAAAAAIIIIIIIIIIIIIIIIIIIIIII       TTTTTTTTTTTTT        ",
    "",
    "",
    "====================== Malcolm Marcus - Tech =====================",
    "===================                            ===================",
    "================= Windows Tweak & Squeak Toolbox =================",
    "===============                                   ================",
    "============= Powered by Advanced IT, Scottburgh KZN =============",

    "",
    "April 2024 Edition"
)

# Pause menu animation
Start-Sleep 3

$OutputReportFile = Join-Path -Path $ScriptDirectory -ChildPath "OutputReport_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

foreach ($line in $lines) {
    Write-Output $line
    Start-Sleep -Milliseconds 75
}

# Get the current date and time
$date = Get-Date

# Convert the date and time to a string
$dateString = $date.ToString()

# Get the OS version
$osVersion = (Get-WmiObject -Class Win32_OperatingSystem).Caption

# Get the computer name
$computerName = $env:COMPUTERNAME

# Specify the file path for output
if ($ScriptDirectory) {
    $OutputPath = Join-Path -Path $ScriptDirectory -ChildPath "Output.txt"
} else {
    Write-Host "Error: Output path could not be determined."
    exit
}

# Write the date, time, OS version, and computer name to the output file
if ($OutputPath) {
    # Write date, time, OS version, and computer name to the file
    $dateString | Out-File -FilePath $OutputPath
    $osVersion | Out-File $OutputPath -Append
    "Computer Name: $computerName" | Out-File $OutputPath -Append
    Write-Host "This computer ($computerName) is running $osVersion." 
    Write-host "Setting current date and time ($dateString)"
    Write-host "Writing Log-File and Report to $OutputPath" -ForegroundColor Green
    Write-Host "___________________________________________" -ForegroundColor Green
    Write-Host ""     
} else {
    Write-Host "Error: Output path is null." -ForegroundColor Red
    exit
}

# Pause menu animation
Start-Sleep 3

$lines = @("-", "\", "|", "-", "/", "-")
foreach ($line in $lines) {
    Write-Output $line
    Start-Sleep -Milliseconds 250
}

Write-host "Loading Complete, please wait while we load the script menu..." -ForegroundColor Green
Write-Host "**************************************************************" -ForegroundColor Green

# Start the menu loop
$scriptResults = @{}
do {
    # Clear the console
    Clear-Host

    # Display the menu header
    Write-Host "======================================================="
    Write-Host "  Advanced IT - Performance Profile Tweaking Platform  "
    Write-Host "======================================================="
    Write-Host "" # Add a blank line after the header

    # Display the menu options
    Write-Host "Please select an option:" 
    Write-Host "" # Add a blank line after the prompt

    for ($i = 0; $i -lt $scriptFiles.Count; $i++) {
        Write-Host "$($i + 1). $($scriptFiles[$i])"
    }
    $lastOption = $scriptFiles.Count + 1 
    Write-Host "$lastOption. Run all scripts" -ForegroundColor Cyan
    Write-Host "$($lastOption + 1). Exit from main menu & Read Report" -ForegroundColor Yellow
    Write-Host "$($lastOption + 2). Exit completely (Report can be found in script directory)" -ForegroundColor Red

    # Get the user's choice
    $choice = Read-Host "Enter your choice"

    # Convert the user's choice to an integer
    $choice = [int]$choice.Trim()

    if ($choice -eq ($lastOption + 2)) {
        # Exit completely
        exit
    }

    if ($choice -eq ($lastOption + 1)) {
        # Exit from the main menu
        # Display the exit report
        Write-Host "Exit report:" -ForegroundColor Green
        Get-Content $OutputReportFile | Write-Host -ForegroundColor Green
        Write-Host "Exit report generated and saved to: $OutputReportFile" -ForegroundColor Green
        
        # Pause for 5 seconds before closing
        Write-Host "Pausing for 5 seconds before closing..."
        Start-Sleep -Seconds 5
        break
    }

    # Check if the user entered a valid choice
    if ($choice -ge 1 -and $choice -le $lastOption) {
        # Run the chosen script
        $scriptName = Join-Path -Path $ScriptDirectory -ChildPath $scriptFiles[$choice - 1]
        if (Test-Path $scriptName) {
            Write-Host "Running $($scriptFiles[$choice - 1])..." -ForegroundColor Green
            $scriptResult = & "$scriptName"
            $scriptResults[$scriptFiles[$choice - 1]] = $scriptResult
            $scriptResult | Out-File "$ScriptDirectory\Output_$($scriptFiles[$choice - 1]).txt"
            Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", "Exit"
        } else {
            Write-Host "Script not found: $($scriptFiles[$choice - 1])" -ForegroundColor Red
        }
    } else {
        Write-Output "Invalid choice, please try again."
    }

    # Wait for the user to press Enter before continuing
    Write-Output "Press Enter to continue..."
    $null = Read-Host

} while ($true)

# Generate and display the exit report
Write-host "Generating exit report..." -ForegroundColor Green
Write-host "**********************************************************************************************************************" -ForegroundColor Green

$exitReport = @()
foreach ($scriptFile in $scriptResults.Keys) {
    $exitReport += "Script: $scriptFile"
    $exitReport += "Output:"
    $exitReport += $scriptResults[$scriptFile]
    $exitReport += "---------------------------------------------"
}

$exitReport | Out-File $OutputReportFile

Get-Content $OutputReportFile | Write-Host -ForegroundColor Green

Write-host "Exit report generated and saved to: $OutputReportFile" -ForegroundColor Green

# Delete all output files except the exit report
foreach ($scriptFile in $scriptFiles) {
    if ($scriptFile -ne "OutputReport_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt") {
        Remove-Item "$ScriptDirectory\Output_$scriptFile.txt" -ErrorAction SilentlyContinue
    }
}

Start-Process -FilePath "$ScriptDirectory\AIT.JPG"
