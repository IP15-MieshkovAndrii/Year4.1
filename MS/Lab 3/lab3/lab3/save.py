import os

def save_all_files_to_text(output_file="merged_files.txt"):
    # Get the current working directory
    current_directory = os.getcwd()

    # Open the output file for writing
    with open(output_file, "w", encoding="utf-8") as outfile:
        # Walk through all directories and files starting from the current directory
        for root, dirs, files in os.walk(current_directory):
            for filename in files:
                file_path = os.path.join(root, filename)
                try:
                    # Write the filename as a header (including the path relative to the current directory)
                    outfile.write(f"\n--- {os.path.relpath(file_path, current_directory)} ---\n")
                    # Read the content of the file
                    with open(file_path, "r", encoding="utf-8") as infile:
                        outfile.write(infile.read())
                        outfile.write("\n")  # Add a newline for separation
                except Exception as e:
                    print(f"Error reading {file_path}: {e}")

if __name__ == "__main__":
    save_all_files_to_text()
