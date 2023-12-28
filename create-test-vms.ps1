# Ensure the Hyper-V module is imported
Import-Module Hyper-V

# Loop 10 times to create or modify VMs
for ($i = 1; $i -le 10; $i++) {
    # Generate a VM name
    $vmName = "randomVM-$i"

    # Check if a VM with this name already exists
    $vmExists = Get-VM -Name $vmName -ErrorAction SilentlyContinue

    # If the VM exists, skip to the next iteration
    if ($vmExists) {
        Write-Output "VM $vmName already exists. Skipping creation."
        continue
    }

    # Create the VM (minimal configuration for demonstration)
    # Note: Adjust the parameters as needed for your environment
    New-VM -Name $vmName -MemoryStartupBytes 512MB

    # Randomly enable or disable Dynamic Memory
    $dynamicMemoryEnabled = (Get-Random -Minimum 0 -Maximum 2) -eq 1
    Set-VMMemory -VMName $vmName -DynamicMemoryEnabled $dynamicMemoryEnabled
}

# Display the created or modified VMs and their Dynamic Memory status
$createdOrModifiedVMs = Get-VM -Name randomVM-*
$createdOrModifiedVMs | Select-Object Name, DynamicMemoryEnabled | Format-Table -AutoSize
