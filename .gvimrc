
" Simplified version of  https://vim.fandom.com/wiki/Restore_screen_size_and_position
if has("gui_running")
  function! ScreenFilename()
    return $HOME.'/.vimsize'
  endfunction

  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if filereadable(f)
      let vim_instance = 'GVIM'
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    let vim_instance = 'GVIM'
    let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
          \ (getwinposx()<0?0:getwinposx()) . ' ' .
          \ (getwinposy()<0?0:getwinposy())
    let f = ScreenFilename()
    if filereadable(f)
      let lines = readfile(f)
      call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
      call add(lines, data)
    else
      let lines = [data]
    endif
    call writefile(lines, f)
  endfunction

  autocmd VimEnter * call ScreenRestore()
  autocmd VimLeavePre * call ScreenSave()
endif
