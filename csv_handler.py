# CSV Filter Script Tag: VM_CSV_FILTER

import csv

def filter_vms_by_owner(filename, partial_owner):
    """
    Filter VM entries by partial owner name.
    
    Parameters:
    - filename: Path to the CSV file.
    - partial_owner: The partial owner name to search for.
    
    Returns:
    A list of dictionaries, each representing a row from the CSV where the partial owner name matches.
    """
    matching_rows = []
    partial_owner_lower = partial_owner.lower()

    with open(filename, mode='r', newline='') as file:
        reader = csv.DictReader(file)
        for row in reader:
            if partial_owner_lower in row['VMOwner'].lower() or partial_owner_lower in row['SuspectedOwner'].lower():
                matching_rows.append(row)

    return matching_rows

# Example Usage:
# matching_rows = filter_vms_by_owner('path_to_your_csv_file.csv', 'partial_owner_string')
# for row in matching_rows:
#     print(row)
