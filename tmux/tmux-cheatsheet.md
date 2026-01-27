#### Session management:
* Create a new session: `tmux new -s <session name>`
* Attach to a session by name: `tmux attach -t <session name`
* List sessions: `tmux ls`
* Kill a session: `tmux kill-session -t <session name>`

#### Window (tabs) control:
* Create window: `<prefix>c`
* Move to window: `<prefix><window number>`
* List windows: `<prefix>w`
* Next window: `<prefix>n`
* Previous window: `<prefix>p`
* Find window: `<prefix>f`
* Name window: `<prefix>,`
* Kill window: `<prefix>&`

#### Pane management:
* Swap panes: `<prefix>o`
* Maximize a pane: `<prefix>m`
* Display pane numbers: `<prefix>q`
* Toggle zoom: `<prefix>z`
* Toggle pane layouts: `<prefix>space`
* Kill pane: `<prefix>x`
* Move current pane left: `<prefix>{`
* Move current pane right: `<prefix>}`

#### Navigation
* Enter copy mode: `<prefix>[`
