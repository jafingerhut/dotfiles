If you run the command:
```
ldd <executable-name>
```
it will show all shared libraries used by that executable, at least
those statically loaded before the `main` function begins execution,
because those shared libraries were marked as DT_NEEDED in its ELF
headers when the binary was created.

It will not include in its output any shared libraries that are loaded
after `main` begins execution, e.g. those that might be loaded via a
`dlopen` system call.

If any of the shared libraries needed _directly_ by the executable in
turn require other shared libraries, `ldd` output shows them all in
one flattened list, without revealing the hierarchical structure that
may be present.

If you want to see the hierarchical structure, use instead this
command:
```
lddtree <executable-name>
```

Note: There are other ways to get similar information about an
executable.  Note that using either `ldd` or `lddtree` should ONLY be
done on a trusted executable.  It does involve some code execution, so
there are apparently some vulnerabilities that could be exploited by a
malicious executable file.


Question give to google.com on 2026-Nov-22:

The shared libraries loaded by a linux executable can vary from one
execution to another, yes? How can a tool like ldd know that some
shared libraries are loaded unconditionally when the program is
executed?

Google's AI assisted answer on that date:

Yes, the shared libraries loaded by a Linux executable can vary
between runs, primarily due to runtime dynamic loading (dlopen),
environment variables (like LD_PRELOAD), or conditional code paths.

However, ldd can reliably identify libraries that are loaded
unconditionally because those dependencies are hardcoded into the
executable's binary file itself before any application code ever runs.

Here is how ldd knows what is guaranteed to load, versus what might
change at runtime.

1. Hardcoded ELF Headers (DT_NEEDED)

When a program is compiled and linked against shared libraries (e.g.,
-lm or -lpthread), the static linker writes metadata directly into the
Executable and Linkable Format (ELF) header of the binary.

+ The .dynamic section: Inside this section of the ELF file, the
  linker creates entries tagged as DT_NEEDED. Each entry holds the
  exact filename (the SONAME, like libc.so.6) of a required library.
+ Startup guarantee: When you run the program, the Linux kernel hands
  control to the dynamic linker/loader (ld-linux.so) before executing
  the program's main() function. ld-linux.so reads these DT_NEEDED
  tags and unconditionally loads those libraries (and recursively
  loads their DT_NEEDED libraries) into memory. If any of them are
  missing, the program immediately crashes with an error before
  executing a single line of its own code.

2. How ldd Actually Works

ldd is usually a shell script that doesn't actually parse the binary
itself. Instead, it invokes the real dynamic linker (ld-linux.so) with
a special environment variable set (LD_TRACE_LOADED_OBJECTS=1).

When ld-linux.so sees this flag, it performs its normal startup
routine—reading the DT_NEEDED entries, checking LD_LIBRARY_PATH,
reading /etc/ld.so.cache, and resolving all file paths—and then prints
the list and exits without ever running the program's main() function.

Why Libraries Still Vary Between Executions

Because ldd stops before main() runs, it captures the static startup
baseline, while runtime execution can diverge in several ways:

+ Explicit Dynamic Loading (dlopen): A program can call
  dlopen("libplugin.so", ...) inside an if statement at
  runtime. Because this is a function call inside the compiled machine
  code rather than a DT_NEEDED header entry, ldd has no idea it
  exists.
+ Environment Overrides: Variables like LD_PRELOAD force ld-linux.so
  to inject extra libraries at startup, and LD_LIBRARY_PATH can
  redirect DT_NEEDED entries to different versions of a library on
  disk.
+ Hardware Capabilities (glibc-hwcaps): Modern ld-linux.so
  implementations can automatically select different optimized
  versions of a shared library depending on the CPU features detected
  at runtime.

(Note: Because ldd achieves this by asking ld-linux.so to partially
execute the binary, running ldd on untrusted executables is a known
security risk; tools like readelf -d <binary> | grep NEEDED inspect
the DT_NEEDED entries safely without invoking the loader.)
