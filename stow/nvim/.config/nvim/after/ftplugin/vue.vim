setlocal shiftwidth=2 softtabstop=2 expandtab
setlocal suffixesadd+=.js,.ts,.vue
setlocal isfname+=@-@
setlocal includeexpr=substitute(v:fname,'^@\/','src/','')
