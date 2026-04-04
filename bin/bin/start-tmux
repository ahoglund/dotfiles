#!/bin/bash

tmux new-session -d -s ah-dev
tmux rename-window SERVERS
tmux new-window -n CODE
tmux new-window -n SHELL
tmux new-window -n NOTES -c ~/Notes
tmux split-window -v -t ah-dev:SERVERS
tmux split-window -v -t ah-dev:CODE
tmux select-window -t ah-dev:2
tmux attach -t ah-dev
