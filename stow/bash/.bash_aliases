### $PATH additions

export PATH="$HOME/.local/bin:$PATH"


### Aliases

## work aliases
alias simplethink='tmux new-session -c ~/work/qsrsoft/simplethink -s simple_think'
alias reports='tmux new-session -c ~/work/qsrsoft/reports -s reports'

alias devtime='tmux new-session -c ~/dev/sw -s dev'

# script aliases
alias compare-crew='~/work/qsrsoft/simplethink/scripts/compare.sh -d --sql "ORDER BY store,name,dob,start_date,last_day,jobcode,term_code" --cut-args "-f 3-10,12-13,15-"'
alias compare-punches='~/work/qsrsoft/simplethink/scripts/compare.sh -d --sql "WHERE date_time>=CURDATE() ORDER BY store,DATE(dateref),type,value1,value2,value3" --cut-args "-f 3-"'
alias compare-schedules='~/work/qsrsoft/simplethink/scripts/compare.sh -d --sql "WHERE date_time>=CURDATE() ORDER BY store,DATE(dateref),type,value1,value2,value3" --cut-args "-f 3-"'

## helpful bits
# Add an "alert" alias for long running commands.  Usage: sleep 10; alert
alias alert='~/share/notify-send.exe "Alert" -i "$([ $? = 0 ] && echo info || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias timestamp='date +"%Y.%m.%d-%H.%M.%S"'
alias datestamp='date +"%Y.%m.%d"'
alias update='sudo apt update && sudo apt upgrade'
alias refresh='source ~/.bashrc'

## shortcuts
alias c='clear'

function newest() {
	ls $1 | sort -V -r | head -n 1
}


## still working on this one
# Call a given command with the `--help` argument
function help() {
	usage="$0 <program>

	Displays the long form help for a given command. Intended as an qu8cker way to write '<program --help'


	-h Show help message
	-s Show short help (-h)";
	pager="bat --language=man --style=grid";
	prog="$1";

	# If no program supplied, print help
	if [ $# -lt 2 ]; then
		echo $usage;
		exit 1;
	fi

	$prog --help | $pager;
}

function h() {
	help="h <program>";
	pager="bat --language=man --style=grid";
	prog="$1";

	# If no program supplied, print help
	if [ $# -lt 1 ]; then
		echo $help | $pager;
		exit 1;
	fi;

	$prog -h | $pager;
}
