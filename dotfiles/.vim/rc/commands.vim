command! -range=% FormatJSON :<line1>,<line2>!python -m json.tool
command! SudoWrite write !sudo tee % >/dev/null
