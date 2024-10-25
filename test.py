#!/usr/bin/env python3

from dataclasses import dataclass
import subprocess
from pathlib import Path
import sys
import os

IVL_PATH = "iverilog"
VVP_PATH = "vvp"
GTK_PATH = "gtkwave"

if os.name == "nt":
    IVL_PATH = "C:\\iverilog\\bin\\" + IVL_PATH
    VVP_PATH = "C:\\iverilog\\bin\\" + VVP_PATH
    GTK_PATH = "C:\\iverilog\\gtkwave\\bin\\" + GTK_PATH

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

def execute_test():
    verilog_files = Path(".").glob("*.v")
    out = subprocess.run([IVL_PATH] + [f"{x}" for x in verilog_files], capture_output=True, text=True)
    if (out.returncode != 0):
        print(out.stderr)
        exit(out.returncode)
    subprocess.run([VVP_PATH, "a.out"], capture_output=True)

def view_dump():
    subprocess.run([GTK_PATH, "dump.vcd"])

if __name__ == "__main__":
    execute_test()
    # Uncomment this line to view your waveform!
    # view_dump()
