import std/json
import std/os

import paramidib
import cligen
import spinny
import yaml

template withSpinny(text: string; s: Spinner; time = false; body: untyped) = 
  let currentSpinner {. inject .} = newSpinny(text, s, time)
  currentSpinner.start()

  body

  #currentSpinner.success(successMsg)

proc main(file, `out`: string) = 
  ## Make music with YAML or JSON files
  
  if file.splitFile().ext notin [".json", ".yaml"]:
    echo file, " is not a Json or Yaml file."
    return
  

  let score = if file.splitFile().ext == ".json": readFile file
              else: $loadtoJson(readFile file)[0]
  
  withSpinny("Making Music...", skDots, time=true):

    createDir(`out`.parentDir)
    saveMusic(`out`, parseJson score)

    currentSpinner.success("Completed!")


dispatch main
