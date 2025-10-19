#!/usr/bin/env zsh

## Logfiles are separated as follows:
# - Log Dir
# - Session
# - Date
# - Filename (datetime-session-window-pane)
LOG_DIR="$HOME/.tmux/logs"

## Returns the current session's identifier
session_id() {
	local session="$(tmux display-message -p "#{session_name}")"
	echo "${session}"
}

## gets a target pane identifier
# $1: session name
# $2: window index
# $3: target pane
get_pane_unique_id() {
	local target="$1:$2.$3"
	tmux display-message -t $target -p "#{session_name}_$2:#{window_name}_$3"
}

## Gets the windows of a session, used for targetting
# $1: session_name
# returns: list of indices
get_windows() {
	local target="$1"
	local array_of_lines=("${(@f)$(tmux list-windows -t $target)}")
	local length="${#array_of_lines[@]}"
	seq 1 $length
}

## Gets the panes contained in a window of a session, used for targetting
# $1: session_name
# $2: window index
# returns: list of indices
get_panes() {
	local target="$1:$2"
	local array_of_lines=("${(@f)$(tmux list-panes -t $target)}")
	local length="${#array_of_lines[@]}"
	seq 1 $length
}

start_log_current_pane() {
	local session="$(session_id)"
	local window="$(tmux display-message -p "#{window_index}")"
	local pane="$(tmux display-message -p "#{pane_index}")"
	start_log $session $window $pane
}

## Starts the logging for the specified tmux session,window,pane:
# $1: session_name
# $2: window index
# $3: pane index
start_log() {
	# test if log directory exists, if not create it
	local date="$(date +"%Y-%m-%d")"
	local t="$(date +"%T")"
	if [ ! -d "$LOG_DIR/$1/$date" ]; then mkdir --parents "$LOG_DIR/$1/$date"; fi
	local target="$1:$2.$3"
	local UNIQUE_ID="$(get_pane_unique_id $1 $2 $3)"
	local LOG_FILE="$LOG_DIR/$1/$date/${UNIQUE_ID}-${date}T${t}.log"
	tmux pipe-pane -t "${target}" "exec cat - | tee -a ${LOG_FILE}"
}

## Stops the logging for the specified tmux session,window,pane:
# $1: session_name
# $2: window index
# $3: pane index
stop_log() {
	local target="$1:$2.$3"
	tmux pipe-pane -t "${target}"
}

## Tests if the specified session is logging
# $1: session_id
is_logging() {
	local current_session_logging=$(tmux show-option -gqv "@session_logging:$1")
	if [ -z "${current_session_logging}" ]; then
		# No option set, thus not logging
		return 0
	else
		# option is set, thug logging
		return 1
	fi
}

## enables logging for the current tmux session
enable_logging() {
	local session="$(session_id)"
	# Test if already logging
	if [ $(is_logging $session) ]; then
		return;
	fi
	tmux set-option -gq "@session_logging:${session}" "true"
	# Setup window and pane hooks for session
	tmux set-hook -t $session after-split-window 'run-shell "$XDG_CONFIG_HOME/tmux/scripts/logging.sh current_pane"'
	tmux set-hook -t $session after-new-window 'run-shell "$XDG_CONFIG_HOME/tmux/scripts/logging.sh current_pane"'
	# For all existing panes, enable pipe-pane
	for window in $(get_windows $session); do
		for pane in $(get_panes $session $window); do
			start_log "$session" "${window}" "${pane}"
		done
	done
}

## disables logging for the current tmux session
disable_logging() {
	local session="$(session_id)"
	if [ ! $(is_logging $session) ]; then
		return;
	fi
	# Unhook new window and panes
	tmux set-hook -t $session -u after-split-window
	tmux set-hook -t $session -u after-new-window
	# For all panes, stop logging
	for window in $(get_windows $session); do
		for pane in $(get_panes $session $window); do
			stop_log "$session" "${window}" "${pane}"
		done
	done
	tmux set-option -gqu "@session_logging:${session}"
}

# specify "enable" or "disable" to start/stop logging
case $1 in
"enable")
	enable_logging
	;;
"disable")
	disable_logging
	;;
"current_pane")
	start_log_current_pane
	;;
esac
