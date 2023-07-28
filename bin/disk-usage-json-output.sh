#! /bin/bash

# Output the current usage of all mounted volumes, in JSON format,
# with units of storage capacity in MBytes.

# I found this particular way of converting the output to JSON format
# in a Q&A forum on this page:
# https://www.unix.com/unix-for-beginners-questions-and-answers/283512-printing-df-h-output-json-format.html

df -BM | tr -s ' ' | jq -sR 'split("\n") |
      .[1:-1] |
      map(split(" ")) |
      map({"file_system": .[0],
           "total": .[1],
           "used": .[2],
           "available": .[3],
           "used_percent": .[4],
           "mounted": .[5]})'
