import argparse

def main(inputfile, outputdir):
    read_file = open(inputfile,"r")
    lines_read = read_file.readlines()
    read_file.close()
    filename = inputfile.split('/')[-1]
    lines_to_write = []
    try:
        header = lines_read[0]
        header_items = header.split(',')
        lines_to_write.append(','.join(header_items))    # add header
    except IndexError:
        print('Error copying header with file ' + filename + ', file may be empty.')

    for line in lines_read[1:]: # do not alter header line
        page_id = line.split(',')[-9]   # using negative index to avoid possible commas in page name
        if (not page_id) or (page_id=='n/a'):
            continue
        lines_to_write.append(line)
    
    if outputdir[-1] != '/':
        outputdir += '/'

    write_file = open(outputdir + filename,"w")
    write_file.writelines(lines_to_write)
    write_file.close()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="script to convert csv output of fbcrawl")
    parser.add_argument('-i', '--inputfile', help='Enter the input file', required=True, dest="inputfile")
    parser.add_argument('-o', '--outputdir', help='Enter the output directory the converted file will be written to', required=True, dest="outputdir")
    args = parser.parse_args()

    main(args.inputfile, args.outputdir)