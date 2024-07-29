import sys
import os

def main():
    input_file_name = sys.argv[1]
    output_file_name = list(os.path.splitext(input_file_name))
    output_file_name[0] += "_add80"
    output_file_name = "".join(output_file_name)
    with open(input_file_name, "rb") as f:
        input_bytes = f.read()
        
    output_bytes = [b^0x80 for b in input_bytes]
    
    with open(output_file_name, "wb") as f:
        f.write(bytes(output_bytes))
    

if __name__ == "__main__":
    main()
