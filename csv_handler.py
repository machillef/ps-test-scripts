import csv

# Function to search for VMs by a list of partial owner names
def search_vms_by_owner(partial_owners, filename='vms.csv'):
    matching_rows = []  # Initialize empty list to hold matching rows
    with open(filename, newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            vm_owner = row['VMOwner'].lower()
            suspected_owner = row['SuspectedOwner'].lower()
            # Check each partial owner against current row
            for owner in partial_owners:
                # Corrected: Check if the current owner is in either VMOwner or SuspectedOwner
                if owner.lower() in vm_owner or owner.lower() in suspected_owner:
                    matching_rows.append(row)
                    break  # Avoid adding the same row multiple times for different owner matches

    return matching_rows

# Example usage
if __name__ == "__main__":
    partial_owners = ["test01", "test02"]  # Example partial owner names
    matches = search_vms_by_owner(partial_owners)
    
    if matches:
        print("Found matching rows:")
        for match in matches:
            print(match)
    else:
        print("No matches found.")
