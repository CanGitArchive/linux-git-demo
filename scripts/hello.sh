#!/usr/bin/env bash
# Demo: run in tmux, prints system info.
echo "Hello from $(whoami) on $(hostname)"
echo "Kernel: $(uname -sr)"
echo "Uptime: $(uptime -p)"
