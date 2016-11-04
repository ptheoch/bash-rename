# bash-rename
A Bash implementation of Perl rename.

## Description
Bash-rename is a Bash implementation of Perl rename that renames the filenames
supplied according to the rule specified as the first argument. Instead of
using perl expressions, bash-rename uses standard regular expressions.

## Usage
```bash
rename.sh [-n] 's/../../' <FILES>
```

## Options
    -n : No action: show what files would have been renamed.

## License
This program is free software, licensed under GNU GPLv3.