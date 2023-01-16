import std/strformat
import std/json
import std/os

import paramidib
import cligen
import spinny
import yaml
import fab

template withSpinny(text: string; s: Spinner; time = false; body: untyped) = 
  let currentSpinner {. inject .} = newSpinny(text, s, time)
  currentSpinner.start()

  body

proc main(file, `out`: string = "") = 
  ## Make MIDI music with YAML or JSON files
  
  if file.splitFile().ext notin [".json", ".yaml"]:
    bad &"\"{file}\" is not a JSON or YAML file."
    return
  
  
  let outfile = if `out` == "": `out`.changeFileExt("wav")
                else: `out`

  let score = if file.splitFile().ext == ".json": readFile file
              else: $loadtoJson(readFile file)[0]
  
  withSpinny("Making Music...", skDots, time=true):

    createDir(outfile.parentDir)
    saveMusic(outfile, parseJson score)

    currentSpinner.success("Completed!")

when isMainModule:
  clCfg.version = "Version v0.1.1"

  dispatch main, help={"file": "The JSON or YAML file to read from", "out": "Output file for generated audio"}
