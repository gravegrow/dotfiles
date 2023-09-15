function ue
	set ue4cli ue4
	set engine_path $($ue4cli root)

  if [ "$argv" = "engine" ]
      cd $engine_path

  else if [ "$argv" = "gen" ]
		$ue4cli gen
    set project $(basename $PWD)

  cat ".vscode/compileCommands_$project.json" | python -c 'import json,sys
j = json.load(sys.stdin)
for o in j:
  file = o["file"]
  arg = o["arguments"][1]
  o["arguments"] = ["clang++ -std=c++20 -ferror-limit=0 -Wall -Wextra -Wpedantic -Wshadow-all -Wno-unused-parameter " + file + " " + arg]
print(json.dumps(j, indent=2))' > compile_commands.json
	else
		$ue4cli $argv
  end
end
