#!/usr/bin/env python3

import sys
import os
import re
import struct
import numpy


# Regular exepression used to parse the filename of a trace
trace_name_re = re.compile('^wave_DES_HW_\d{4}-\d{2}-\d{2}_\d{2}-\d{2}-\d{2}__k=([0-9a-f]{16})_m=([0-9a-f]{16})_c=([0-9a-f]{16}).bin$', re.I)



class Measurement:
    '''Container class for a single measurement. It contains a plaintext, a
    ciphertext, and a trace.

    '''
    def __init__(self, plaintext, ciphertext, samples):
        self.plaintext = plaintext
        self.ciphertext = ciphertext
        self.trace = samples

    def __str__(self):
        res = 'Plaintext = ['
        res += ' '.join(str(x) for x in self.plaintext)
        res += '] Ciphertext = ['
        res += ' '.join(str(x) for x in self.ciphertext)
        res += ']'
        return res


class Trace_dir:
    '''Helper class that wraps a generator, returning a measurement on each call to
    next(). The generator iterates over data files contained in a directory.

    '''
    def __init__(self, directory_name, max_traces=None):
        self.directory_name = directory_name
        self.max_traces = max_traces
        self.traces_read = 0
        self.directory_content = os.listdir(self.directory_name)
        self.next_trace_index = 0
        #print (self.directory_content)

    def __iter__(self):
        return self

    def __next__(self):
        res = None

        # Max reached?
        if self.max_traces and self.traces_read >= self.max_traces:
            raise StopIteration

        # Find the next file with a correct name
        while True:
            if self.next_trace_index >= len(self.directory_content):
                raise StopIteration

            re_res = trace_name_re.match(self.directory_content[self.next_trace_index])
            self.next_trace_index += 1

            if re_res != None:
                break

        # Retrieve the plaintext and ciphertext from the name of the file
        plaintext_hex = re_res.group(2)
        ciphertext_hex = re_res.group(3)

        plaintext = []
        ciphertext = []
        for i in range(8):
            plaintext.append(int(plaintext_hex[2*i:2*(i+1)], 16))
            ciphertext.append(int(ciphertext_hex[2*i:2*(i+1)], 16))


        # Read the trace
        trace_file = open(os.path.join(self.directory_name, re_res.group(0)), 'rb')
        trace_file.seek(12, 1)

        size_str = trace_file.read(4)
        size = struct.unpack('i', size_str)[0]
        trace_file.seek(size - 4, 1)

        size_str = trace_file.read(4)
        size = struct.unpack('i', size_str)[0]
        trace_file.seek(size - 8, 1)

        size_str = trace_file.read(4)
        size = struct.unpack('i', size_str)[0]

        assert(size > 0)
        assert(size % 4 == 0)

        num_samples = size / 4

        content_str = trace_file.read(size)

        #format_str = str(num_samples) + 'f'
        format_str = str(int(num_samples) ) + 'f'

        content = struct.unpack(format_str, content_str)

        trace = numpy.array(content)
        result = Measurement(plaintext, ciphertext, trace)

        trace_file.close()
        self.traces_read += 1

        # Return the trace object
        return result

    # python 2 compatibility
    def next(self):
        return self.__next__()


def test():
    pass

if __name__ == "__main__":
    test()
