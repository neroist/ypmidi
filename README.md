# ypmidi
Make midi music via a JSON or YAML file

## help
```
Usage:
  ypmidi [REQUIRED,optional-params]
Make MIDI music with YAML or JSON files
Options:
  -h, --help                       print this cligen-erated help      
  --help-syntax                    advanced: prepend,plurals,..       
  --version      bool    false     print version
  -f=, --file=   string  REQUIRED  The JSON or YAML file to read from 
  -o=, --out=    string  ""        Output file for generated audio 
```

## supported audio formats
It supports all audio formats on [Wikipedia's list of audio formats](https://en.wikipedia.org/wiki/Audio_file_format#List_of_formats), though it probably supports more. 
