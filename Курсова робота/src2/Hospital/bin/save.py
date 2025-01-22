import os

def save_all_files_to_text(output_file="merged_files.txt"):
    # Get the current working directory
    current_directory = os.getcwd() + "/src"

    # Open the output file for writing
    with open(output_file, "w", encoding="utf-8") as outfile:
        # Iterate through all files in the current directory
        for filename in os.listdir(current_directory):
            file_path = os.path.join(current_directory, filename)
            # Check if it's a file (not a directory)
            if os.path.isfile(file_path):
                try:
                    # Write the filename as a header
                    outfile.write(f"\n--- {filename} ---\n")
                    # Read the content of the file
                    with open(file_path, "r", encoding="utf-8") as infile:
                        outfile.write(infile.read())
                        outfile.write("\n")  # Add a newline for separation
                except Exception as e:
                    print(f"Error reading {filename}: {e}")

if __name__ == "__main__":
    save_all_files_to_text()