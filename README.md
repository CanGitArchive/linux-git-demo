# Linux + Git (Core) — Module 1

**Goal:** Prove baseline Linux + Git fluency: dotfiles, tmux use, SSH to GitHub, clean branching & PR.

## What’s included (proof)
- `~/.tmux.conf` (mouse, history, vi-keys)
- `scripts/hello.sh` (simple system info demo)
- `.gitignore`
- This README

## How to run
```bash
tmux new -s dev         # start a session (Ctrl-b d to detach)
./scripts/hello.sh      # run the demo

Hello world!

5) Stage + commit + push:
```bash
git status
git add -A
git commit -m "feat(module1): add tmux conf, hello script, readme, gitignore"
git push -u origin 01-linux-setup

cat > README.md << 'EOF'

Some change
