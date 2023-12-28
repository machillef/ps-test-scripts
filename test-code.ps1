# Start timing
$start = Get-Date

#$VMsWithSnapshots = Get-VM | Where-Object { (Get-VMSnapshot -VMName $_.Name -ErrorAction SilentlyContinue).Count -gt 0 }
#Write-Output $VMsWithSnapshots

Write-Output "---------------------------------------------------------"

$VMs = Get-VM

foreach ($VM in $VMs){

    $Snapshots = Get-VMSnapshot -VMName $VM.Name
    if ($Snapshots){
        Write-Output $VM

        }



}


# End timing
$end = Get-Date
$duration = $end - $start
Write-Output "Total script execution time: $($duration) seconds"

