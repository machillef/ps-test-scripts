# Get all VMs
$VMs = Get-VM

# Current date
$currentDate = Get-Date


$OneDay = '1.00:00:00'
$FiveDays = '2.00:00:00'
$TenDays = '6.00:00:00'

# Initialize arrays to hold VMs based on snapshot age
$VMsWithSnapshotOlderThan1Day = @()
$VMsWithSnapshotOlderThan5Days = @()
$VMsWithSnapshotOlderThan10Days = @()

# Loop through each VM
foreach ($VM in $VMs) {
    # Get snapshots for the VM, sorted by CreationTime
    $snapshots = Get-VMSnapshot -VMName $VM.Name | Sort-Object CreationTime -Descending

    # Skip VMs with no snapshots
    if ($snapshots.Count -eq 0) {
        continue
    }

    # Get the most recent snapshot
    $latestSnapshot = $snapshots[0]
    $snapshotAge = $currentDate - $latestSnapshot.CreationTime

    # Categorize VMs based on the age of the latest snapshot
    if ($snapshotAge -gt $OneDay -and $snapshotAge -le $FiveDays) {
        $VMsWithSnapshotOlderThan1Day += $VM
    } elseif ($snapshotAge -gt $FiveDays -and $snapshotAge -le $TenDays) {
        $VMsWithSnapshotOlderThan5Days += $VM
    } elseif ($snapshotAge -gt $TenDays) {
        $VMsWithSnapshotOlderThan10Days += $VM
    }
}

# Output the VMs in each category
Write-Output "VMs with latest snapshot older than 1 day, but not older than 5 days:"
$VMsWithSnapshotOlderThan1Day | Format-Table Name, State, CreationTime

Write-Output "VMs with latest snapshot older than 5 days, but not older than 10 days:"
$VMsWithSnapshotOlderThan5Days | Format-Table Name, State, CreationTime -AutoSize

Write-Output "VMs with latest snapshot older than 10 days:"
$VMsWithSnapshotOlderThan10Days | Format-Table Name, State, CreationTime -AutoSize
