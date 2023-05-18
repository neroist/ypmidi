import std/strformat
import std/json
import std/os

import paramidib
import cligen
import spinny
import termui
import yaml
import fab

const
  Version = "v0.2.0"

template withSpinny(text: string; s: spinny.Spinner; time = false; body: untyped) = 
  let currentSpinner {.inject.} = newSpinny(text, s, time)
  currentSpinner.start()

  body

proc fileChecks(file: string): bool = 
  result = true
  
  if file.splitFile().ext notin [".json", ".yaml"]:
    bad &"\"{file}\" is not a JSON or YAML file."
    return false

  if not file.fileExists():
    bad &"\"{file}\" does not exist."
    return false

proc main(file, `out`: string = "", ext: string = "") = 
  ## Make MIDI music with YAML or JSON files
  
  if not fileChecks(file): return
  
  let 
    outext = if ext == "": 
      "wav"
    else:
      ext

    outfile = if `out` == "": 
      file.changeFileExt(outext)
    elif ext != "":
      `out`.changeFileExt(outext)
    else:
      `out`

  if outfile.fileExists():
    let confirmed = termuiConfirm(
      &"The file \"{outfile}\" exists. Do you want to overwrite this file?"
    )

    if not confirmed: return
  
  let score = if file.splitFile().ext == ".json": 
      readFile file
    else: 
      $loadtoJson(readFile file)[0]

  echo "" # print newline
  
  withSpinny("Making Music...", skArc, time=true):

    createDir(outfile.parentDir)
    saveMusic(outfile, parseJson score)

    currentSpinner.success("Completed!")

when isMainModule:
  clCfg.version = "ypmidi version " & Version

  dispatch main, 
    cmdName="ypmidi", 
    help={
      "file": "The JSON or YAML file to read from", 
      "out": "Output file for generated audio",
      "ext": "Extension to save the generated audio file as"
    }
