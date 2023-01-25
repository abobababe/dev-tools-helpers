# -*- mode: gdb-script; -*-

shell echo "# -*- mode: gdb-script; -*-" > gdbinit

# good idea to set as sometimes the command arguments have chars that the shell tries to interpret
shell echo "set startup-with-shell off" >> gdbinit

# extract files being debugged
pipe info files | awk '/, file type/ { print "# " $0; sub(/^./, "", $1); sub(/..$/, "", $1); print "file " $1; }' >> gdbinit

#get args passed to the program
pipe show args | awk 'NR == 1 { print "# " $0; match($0, /".*"\.$/); print "set args " substr($0, RSTART + 2, RLENGHT - 4); }' >> gdbinit


# This is optional. Use when stopping at cc1 suffices
quit 1
