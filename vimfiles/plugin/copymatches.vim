function! s:CopyMatches(line1, line2, reg)
  let reg = a:reg != '' ? a:reg : '+'
  for line in range(a:line1, a:line2)
    let txt = getline(line)
    let idx = match(txt, @/)
    while idx > -1
      exec "let @".reg." .= matchstr(txt, @/, idx) . \"\n\""
      let end = matchend(txt, @/, idx)
      let idx = match(txt, @/, end)
    endwhile
  endfor
endfunction
