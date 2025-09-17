# Linux + Git (Core) — Proof Pack

**Goal:** Prove baseline Linux + Git fluency (SSH, branches, PRs) and tmux use.

## What’s included
- `scripts/hello.sh` — simple system info script
- `.gitignore` — ignores common noise
- `images/tmux-demo.png` — tmux run screenshot
- This README

## How to run
```bash
tmux new -s dev         # start a tmux session (Ctrl-b then d to detach)
./scripts/hello.sh      # run the demo

tmux demo
Feature branch via git switch -c

Commit locally with git commit

Publish with git push -u origin <branch>

Open PR (GitHub UI or gh pr create) and merge into main

Proof artifacts

Closed PRs: #5, #6Screenshot:
![tmux demo](images/tmux-demo.png)
