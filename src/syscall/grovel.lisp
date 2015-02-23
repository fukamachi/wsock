(include "errno.h" "sys/types.h")

(in-package :wsys)

(ctype size-t "size_t")
(ctype ssize-t "ssize_t")
(ctype pid-t "pid_t")

(cvar ("errno" errno) :int)
