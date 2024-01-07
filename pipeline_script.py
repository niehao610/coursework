import sys
from subprocess import Popen, PIPE
from Bio import SeqIO

"""
usage: python pipeline_script.py INPUT.fasta  
approx 5min per analysis
"""
BASE_PATH="/home/ec2-user/coursework"

def run_parser(hhr_file):
    """
    Run the results_parser.py over the hhr file to produce the output summary
    """
    cmd = ['python', BASE_PATH+'/results_parser.py', hhr_file]
    print(f'STEP 4: RUNNING PARSER: {" ".join(cmd)}')
    p = Popen(cmd, stdin=PIPE,stdout=PIPE, stderr=PIPE)
    out, err = p.communicate()
    print(out.decode("utf-8"))

def run_hhsearch(a3m_file,hhr_file):
    """
    Run HHSearch to produce the hhr file
    """
    cmd = [BASE_PATH+'/hh-suite/bin/hhsearch',
           '-i', a3m_file, '-cpu', '1', '-d', 
           BASE_PATH+'/data/hhdb/pdb70/']
    print(f'STEP 3: RUNNING HHSEARCH: {" ".join(cmd)}')
    p = Popen(cmd, stdin=PIPE,stdout=PIPE, stderr=PIPE)
    out, err = p.communicate()
    with open(hhr_file, "w") as fh_out:
        fh_out.write(out.decode("utf-8"))

def read_horiz(tmp_file, horiz_file, a3m_file):
    """
    Parse horiz file and concatenate the information to a new tmp a3m file
    """
    pred = ''
    conf = ''
    print("STEP 2: REWRITING INPUT FILE TO A3M")
    with open(horiz_file) as fh_in:
        for line in fh_in:
            if line.startswith('Conf: '):
                conf += line[6:].rstrip()
            if line.startswith('Pred: '):
                pred += line[6:].rstrip()
    with open(tmp_file) as fh_in:
        contents = fh_in.read()
    with open(a3m_file, "w") as fh_out:
        fh_out.write(f">ss_pred\n{pred}\n>ss_conf\n{conf}\n")
        fh_out.write(contents)

def run_s4pred(input_file, out_file):
    """
    Runs the s4pred secondary structure predictor to produce the horiz file
    """
    cmd = ['/usr/bin/python3', BASE_PATH+'/s4pred/run_model.py',
           '-t', 'horiz', '-T', '1', input_file]
    print(f'STEP 1: RUNNING S4PRED: {" ".join(cmd)}')
    p = Popen(cmd, stdin=PIPE,stdout=PIPE, stderr=PIPE)
    out, err = p.communicate()
    with open(out_file, "w") as fh_out:
        fh_out.write(out.decode("utf-8"))

    
def read_input(file):
    """
    Function reads a fasta formatted file of protein sequences
    """
    print("READING FASTA FILES")
    sequences = {}
    ids = []
    for record in SeqIO.parse(file, "fasta"):
        print("%s %i" % (record.id, len(record)))        
        sequences[record.id] = record.seq
        ids.append(record.id)
    return(sequences)




if __name__ == "__main__":
    sequences = read_input(sys.argv[1])
    tmp_file = BASE_PATH+"/data/tmp/tmp.fas"
    horiz_file = BASE_PATH+"/data/tmp/tmp.horiz"
    a3m_file = BASE_PATH+"/data/tmp/tmp.a3m"
    hhr_file = BASE_PATH+"/data/tmp/tmp.hhr"
    out      = BASE_PATH+"/data/output/out.cvs"
    for k, v in sequences.items():
        break        
        with open(tmp_file, "w") as fh_out:
            fh_out.write(f">{k}\n")
            fh_out.write(f"{v}\n")
        run_s4pred(tmp_file, horiz_file)
        read_horiz(tmp_file, horiz_file, a3m_file)
        run_hhsearch(a3m_file,hhr_file)
        run_parser(hhr_file)
     
    with open(out, "w") as fh_out:
        fh_out.write("hello world")     