# Exhaustive search

## Requirements:

- the script accepts MD5 hash
  - should validate MD5 format
  - possible to specify original string max length and character set
  - string max length argument is mandatory
- original string is searched by comparing its hash with incoming MD5 hash
  - the script calculates or configures the number of threads and splits to chunks accordingly
  - each thread searches within its range
  - if a match is found, stop all threads and print out the result
  - if no match is found, report an error and exit
