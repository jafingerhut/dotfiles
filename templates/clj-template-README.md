# Introduction

Eric Normand wrote and published a short script
[here](https://gist.github.com/ericnormand/6bb4562c4bc578ef223182e3bb1e72c5)
that can be invoked from a Linux/Unix command line, and it ends up
running the `clojure` command (more documentation for that
[here](https://clojure.org/guides/deps_and_cli)) on Clojure code that
is in the rest of the same file.

This document describes how it works.

# The code

Here is a listing, with line numbers that will be referred to later.

```
 1. #!/bin/bash
 2. #_(
 3. 
 4.    #_DEPS is same format as deps.edn. Multiline is okay.
 5.    DEPS='
 6.    {:deps {clj-time {:mvn/version "0.14.2"}}}
 7.    '
 8. 
 9.    #_You can put other options here
10.    OPTS='
11.    -J-Xms256m -J-Xmx256m -J-client
12.    '
13. 
14. exec clojure $OPTS -Sdeps "$DEPS" "$0" "$@"
15. 
16. )
17.
18. (println "Hello, world!")
19. 
20. (println "The full path name of the file containing this code becomes the\n"
21.          "value of the Clojure variable *file*:\n"
22.          *file*)
23. (println)
24. (println "Any command line arguments given after the name of this file\n"
25.          "become the value of the Clojure variable *command-line-args*,\n"
26.          "which is a list of strings.  It never contains the name of the\n"
27.          "command, and is an empty list if no arguments are given for the\n"
28.          "command:")
29. (pr *command-line-args*)
```

An attempt to explain the sorcery at work here, step by step:

First, this is a shell script. The shell treats a `#` character and
everything following it, up to the end of the line, as a comment.

Clojure comments are the `;` character up to the next end of line, but
there are two other ways to make Clojure ignore some of what it reads.

(1) When the Clojure reader encounters the pair of characters `#_`, it
    will then read the next form, which must be legal Clojure syntax,
    and then discard it.  See
    [discard](https://clojure.org/guides/weird_characters#_discard)
    for examples.

(2) When the Clojure reader encounters the pair of characters `#!`, it
    treats the rest of the line after that as a comment, the same as
    it does for the semicolon `;` character.  This has been in Clojure
    since 2009, but is very seldom used in production code.  It
    appears to have been put into Clojure specifically for the use
    case of ignoring the first line of a Unix/Linux script.

So you use this file as an executable file on a Unix-like or Linux
system, which interprets the first two characters `#!` to mean "the
rest of the line is a command to invoke, with this file as input".  It
says to run `/bin/bash` on it.  The `#!` pair is sometimes called
[Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)).

`/bin/bash` reads it and treats lines 1, 2, and 4 as comments because
they begin with `#` characters.  Line 3 is blank.  The shell executes
nothing for blank lines.

Lines 5 through 7 assign a value to the variable named `DEPS`.  Its
value is a string.

Line 9 is a comment again.  Lines 10 through 12 assign a value to a
variable named `OPTS`.  Its value is also a string.

Line 14 is another command for the shell to execute.  `exec` is a
command that means "take the rest of the line as a command to execute,
and make this process effectively start over and execute that".  That
is, without the `exec`, the shell would execute the command in a new
child process, and when it completed, the shell would continue
attempting to execute further lines in the file.  But because `exec`
replaces the current process with that of the command on the rest of
the line after it, the original shell process will never "come back"
and try to execute commands from any later lines.  See more
[here](https://www.geeksforgeeks.org/exec-command-in-linux-with-examples/)
if you are interested.

So now what was the shell process is instead the process running the
command `clojure $OPTS -Sdeps "$DEPS" "$0" "$@"`.

`$OPTS` and `$DEPS` are replaced by the shell with the values of those
variables.

`$0` is replaced with the full path name of the file containing the
script, e.g. `/home/username/bin/scriptname`.  When Clojure starts
running, the var `*file*` will become equal to that full path file
name.

`$@` is replaced with any and all command line options that you type
as part of the command when you run the script.  When Clojure starts
running, the var `*command-line-args*` will become equal to a list of
strings, one for each separate argument on the command line (or an
empty list if no such command line arguments are given).  See [this
StackOverflow
question](https://stackoverflow.com/questions/12314451/accessing-bash-command-line-args-vs/12316565)
and its answers for differences in behavior between `$@` and `"$@"`,
which explains why `"$@"` is a good choice here.

The `clojure` command does various things like checking a local cache
of dependencies in `$HOME/.clojure/.cpcache` to see if they are
already on the local file system, and if not, tries to go to the
network and retrieve whatever dependencies are needed.  Assuming that
all goes well, the `clojure` command then starts a JVM (Java Virtual
Machine) process with appropriate command line options so that the JVM
calls a method in `clojure.main`.  That method reads the lines of the
file, from the beginning, reading them using the Clojure reader and
evaluating them, similar to what would happen if you entered them into
a Clojure REPL.

As mentioned in numbered item (2) above, the Clojure reader treats
everything from `#!` to the end of a line as a comment, so line 1 is a
comment for Clojure, too.

When the Clojure reader reads the `#_` on line 2, it then reads
whatever the next form is, which is the entire parenthesized
expression starting on line 2, ending on line 16, since the right
parenthesis on line 16 balances the left parenthesis on line 2.
Everything between those parentheses is legal syntax for Clojure data.

Why is there `#_DEPS` instead of `# DEPS` on line 4, and a similar
thing on line 9, you may wonder?  Because if it were `# DEPS`, while
`bash` still treats that all as part of a comment, the Clojure reader
treats `# DEPS` as a [reader
tag](https://clojure.org/guides/weird_characters#tagged_literals).  By
putting an underscore immediately after the `#` character, the Clojure
reader reads `DEPS` as a Clojure symbol, and discards it.

Another thing that may be slightly subtle is that the single quote `'`
characters are used by `bash` to denote that the characters between
are in a string, as well as double quote characters.  Clojure treats
characters between double quote characters as strings, but the single
quote is syntax where `'foo` becomes `(quote foo)`.  The uses of the
single quote on lines 5, 7, 10, and 12 do that when Clojure reads
them.  The single quote on line 12, for example, causes Cloure to read
that and the following symbol `exec`, and they become `(quote exec)`.
It would be an error for the Clojure reader if a single quote was the
last non-whitespace non-comment character before the right parenthesis
on line 16.

Once the Clojure reader reads the list on lines 2 through 16, it
discards it, because of the `#_` immediately before it on line 2.

Now the Clojure reader continues reading expressions and evaluating
them in the rest of the file.  As mentioned above, this is similar to
what Clojure would do if you were entering these lines at a REPL.
