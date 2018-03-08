Running a script in background
======================

Use the shebang line in your python script. Make it executable using the command,

```chmod +x test.py```

Use no hangup to run a program in background even if you close your terminal.

```nohup /path/to/test.py &```

Do not forget to use & to put it in background.

To see the process again, use in terminal,

```ps ax | grep test.py```