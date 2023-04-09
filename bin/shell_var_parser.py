import sys
import fileinput

def parse_lines(lines):
    ret = {}
    for idx in range(len(lines)):
        line = lines[idx]
        equalidx = line.find('=')
        if equalidx == -1:
            print("Line %d of config '%s' contains no equals sign (=).  Skipping."
                  "" % (idx+1, line),
                  file=sys.stderr)
            continue
        varname = line[0:equalidx].strip()
        if varname == '':
            print("Line %d of config '%s' contains no variable name before the equals sign (=).  Skipping."
                  "" % (idx+1, line),
                  file=sys.stderr)
            continue
        value = line[equalidx+1:].strip()
        if value[:1] == '"' and value[-1:] == '"':
            value = value[1:-1]
        if varname in ret:
            print("Line %d of config '%s' contains variable name that occurred earlier in the config.  Replacing earlier value with later one."
                  "" % (idx+1, line),
                  file=sys.stderr)
        ret[varname] = value
    return ret

def loads(s):
    return parse_lines(s.split())

def load(fname):
    lines = []
    for line in fileinput.input(fname):
        lines.append(line)
    return parse_lines(lines)
        
