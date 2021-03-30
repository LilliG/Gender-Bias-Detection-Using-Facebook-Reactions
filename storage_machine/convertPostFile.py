import argparse

def main(inputfile, outputdir):
    read_file = open(inputfile,"r")
    lines_read = read_file.readlines()
    read_file.close()
    filename = inputfile.split('/')[-1]
    page_id = filename.split('.')[0]
    lines_to_write = []
    try:
        header = lines_read[0]
        header_items = header.split(',')
        header_items.insert(-1, 'page_id')               # insert before newline character
        lines_to_write.append(','.join(header_items))    # add header
    except IndexError:
        print('Error copying header with file ' + filename + ', file may be empty.')

    post_ids = set()
    for line in lines_read[1:]: # do not alter header line
        post_id = int(line.split(',')[-2])   # using negative index to avoid commas in post text
        if post_id in post_ids:
            continue
        post_ids.add(post_id)

        items = line.split(',')
        for i, v in enumerate(items[-10:-2], -10):  # numbers to convert, using negative indices to avoid commas in post text
            if (i==-10) and (len(v.split(' '))>1):      # handle edge case with reactions number
                v = v.split(' ')[-2]

            if not v:
                v = 0
            elif v[-1] == "K":
                v = int(float(v[:-1]) * 1000)
            elif v[-1] == "M":
                v = int(float(v[:-1]) * 1000000)
            else:
                try:
                    v = int(v)
                except ValueError:
                    print('Invalid literal ' + str(v) + ' for file ' + filename + ' in line:\n' + line)
            items[i] = str(v)
        items.insert(-1, page_id)  # adding page_id to row to easily identify page connected to post
        lines_to_write.append(','.join(items))
    
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






    