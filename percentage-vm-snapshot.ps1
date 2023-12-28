# Get all VMs
$VMs = Get-VM

# Initialize counters
$totalVMs = $VMs.Count
$VMsWithSnapshots = 0
$VMsWithOneSnapshot = 0
$VMsWithFiveSnapshot = 0
$VMsWithTenSnapshot = 0

# Loop through each VM
foreach ($VM in $VMs) {
    # Get snapshots for the VM
    $snapshots = Get-VMSnapshot -VMName $VM.Name 
    $snapshotCount = $snapshots.Count

    # Check if the VM has snapshots
    if ($snapshots) {
        Write-Output "VM Name: $($VM.Name), Has Snapshot: Yes, Number of Snapshots: $snapshotCount"
        $VMsWithSnapshots++
    } else {
        Write-Output "VM Name: $($VM.Name), Has Snapshot: No"
    }
    if ($snapshotCount -eq 1){
        $VMsWithOneSnapshot++
    }
    elseif ($snapshotCount -eq 5){
        $VMsWithFiveSnapshot++
    }
    elseif ($snapshotCount -gt 6){
        $VMsWithTenSnapshot++
    }
}

# Calculate the percentage of VMs with snapshots
$percentageWithSnapshots = ($VMsWithSnapshots / $totalVMs).ToString("P")

# Output the final line with the percentage
Write-Output "Percentage of VMs with at least one snapshot: $percentageWithSnapshots"


# Calculate the percentage of VMs with at least 1 snapshot
$percentageWithOneSnapshot = ($VMsWithOneSnapshot/ $totalVMs).ToString("P")

# Output the final line with the percentage
Write-Output "Percentage of VMs with exactly one snapshot: $percentageWithOneSnapshot"

# Calculate the percentage of VMs with more than 2 Snapshot, up to 5
$percentageWithFiveSnapshots = ($VMsWithFiveSnapshot/ $totalVMs).ToString("P")

# Output the final line with the percentage
Write-Output "Percentage of VMs with up to 5 snapshots: $percentageWithFiveSnapshots"

# Calculate the percentage of VMs with more than 6
$percentageWithSixSnapshots = ($VMsWithTenSnapshot/ $totalVMs).ToString("P")

# Output the final line with the percentage
Write-Output "Percentage of VMs with more than 6 snapshots: $percentageWithSixSnapshots"
