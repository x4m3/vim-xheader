" autoload/xheader.vim
"
" made by x4m3

" set default settings if they are not set
if !exists('g:xheader_name')
	let g:xheader_name = 'Anonymous'
endif

" dictionary of the comments styles for supported languages
" 1: first line
" 2: middle lines
" 3: last line
let s:comStyles = {
			\'make': {'1': '##', '2': '##', '3': '##'},
			\'c': {'1': '/*', '2': ' *', '3': ' */'},
			\'cpp': {'1': '/*', '2': ' *', '3': ' */'},
			\}

" check if current filetype is supported
function! s:CheckFiletype()
	" check dictionary for current filetype
	return has_key(s:comStyles, &filetype)
endfunction

" function to get current date
function! s:xheader_get_date()
	let currentYear = strftime("%Y")
	let currentMonth = strftime("%m")
	let currentDay = strftime("%d")
	let currentDate = currentYear . "-" . currentMonth . "-" . currentDay
	return currentDate
endfunction

" function to insert header
function xheader#addHeader()
	" if checkFiletype() fails, return error
	if !s:CheckFiletype()
		echoerr "Unsupported filetype for header: " . &filetype
		return
	endif

	let l:com1 = s:comStyles[&filetype]['1']
	let l:com2 = s:comStyles[&filetype]['2']
	let l:com3 = s:comStyles[&filetype]['3']

	let l:let = append(0, l:com1)
	let l:let = append(1, l:com2 . " " . expand('%:r'))
	let l:let = append(2, l:com2)
	let l:let = append(3, l:com2 . " " . g:xheader_name)
	let l:let = append(4, l:com2 . " " . s:xheader_get_date())
	let l:let = append(5, l:com2)
	let l:let = append(6, l:com3)
	let l:let = append(7, "")
	:8
endfunction
