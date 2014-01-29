## Sample code to demonstrate missing EOF notifications

### Summary

When using the `NSNotificationCenter` with `NSFileHandle`
`readInBackgroundAndNotify`, a process that waits for a writer to close a FIFO
can block forever, as it does not receive an event containing a zero-length
`NSData` object.

See [echoud](/jeberle/echoud) for a UNIX domain socket equivalent that behaves properly.

### Contents

    Makefile  - to build echof program
    README.md - this file
    echof.m   - echof source. this is an echo server that uses 2 fifos
    kit.h     - precompiled header
    test.py   - test client

### To Build

    make

### To Run

    mkfifo f1 f2
    ./echof

    ... in another console ...
    
    ./test.py 5

In my tests, I get about 3 good runs (such that both programs exit normally)
until `echof` hangs, waiting for the client to close its write end, which it
obviously does by not running anymore.

When run with `./test.py 1` it _always_ hangs.

I trust this has nothing to do w/ buffering, but I have made mistakes in the
past :)

