A quick, practical Linux + Git cheat sheet for Ubuntu 24.04.

## Conventions & Symbols

* **Command shape:** `program [subcommand] [options] [args]`
* **Short vs long options:** `-l -a` (short, one letter), `--global` (long, readable)
* **`--` (double hyphen alone):** end of options → treat the rest as filenames/args
  `rm -- -weirdname`
* **`\` (backslash at line end):** line continuation

  ```bash
  sudo apt install -y build-essential \
    git tmux
  ```
* **`~` / `$HOME`:** your home directory. `~/dev` → `/home/<you>/dev`
* **Run help:** `<cmd> --help` and `man <cmd>`

---

## 1) Navigation & Files

```bash
pwd                     # current directory
ls -la                  # list all, long format
cd ~/dev                # change directory
mkdir -p ~/dev/demo     # make directories (parents ok)
touch notes.txt         # create empty file or update timestamp
cp src.txt dst.txt      # copy
mv old new              # move/rename
rm -i file              # remove (interactive)
rm -r dir               # remove directory recursively
```

**View files**

```bash
cat file                # print whole file
less file               # paged view (q to quit, /search)
head -n 20 file         # first lines
tail -n 50 file         # last lines
tail -f logfile         # follow new lines
```

---

## 2) Find & Search

```bash
find . -type f -name "*.py"              # find files by name
find . -type f -mtime -1                 # modified in last 24h
grep -RIn "pattern" .                    # search text recursively (line numbers)
grep -RIn --include="*.cpp" "TODO" .     # only in .cpp files
```

---

## 3) Permissions & Ownership

```bash
ls -l                  # shows rwx permissions and owner:group
chmod +x script.sh     # make executable
chmod 644 file         # -rw-r--r--
chown user:group file  # change owner/group (needs sudo for others’ files)
groups                 # see your groups
sudo usermod -aG dialout $USER   # add yourself to 'dialout' (for serial/Arduino), log out/in
```

---

## 4) Processes

```bash
ps aux | head          # list processes
top                    # live view (q to quit)
kill <pid>             # send SIGTERM
kill -9 <pid>          # force kill (SIGKILL) if needed
pkill python           # kill by name
jobs; bg %1; fg %1     # shell jobs, background/foreground
nohup long_cmd &       # keep running after logout (outputs to nohup.out)
```

---

## 5) System Info

```bash
hostnamectl            # host + OS info
uname -a               # kernel info
df -h                  # disk usage
free -h                # memory
lscpu                  # CPU info
```

---

## 6) Packages (APT)

* **What:** Ubuntu’s package manager (talks to repositories).
* **Flow:** refresh → upgrade → install/remove.

```bash
sudo apt update                    # refresh package indexes
sudo apt upgrade -y                # upgrade installed packages
sudo apt install -y tmux           # install
sudo apt remove --purge tmux       # remove + config
sudo apt autoremove -y             # cleanup unused deps
apt search <name>                  # search packages
apt show <name>                    # details
```

Common bootstrap:

```bash
sudo apt install -y build-essential git curl tmux \
  openssh-client openssh-server v4l-utils ffmpeg python3-venv
```

* **`-y`** = assume “yes” to prompts.

---

## 7) Services & Logs (systemd)

* **`systemctl` manages services** (start/stop/enable/status).

```bash
sudo systemctl enable --now ssh    # start SSH server now and on boot
systemctl status ssh --no-pager    # service status
sudo systemctl restart ssh         # restart service
sudo systemctl disable ssh         # disable on boot
```

* **Logs (`journalctl`)**

```bash
journalctl -u ssh --no-pager       # logs for a unit
journalctl -f                      # follow logs (like tail -f)
journalctl -xe                     # recent errors with context
```

---

## 8) Networking & SSH

```bash
ip a                      # IP addresses
ping -c 4 8.8.8.8         # connectivity
curl -L https://example.com -o file   # download (follow redirects)
```

**SSH client tools**

* `ssh user@host` → remote shell
* `scp file user@host:/path/` → copy file
* `sftp user@host` → interactive file transfer

**Set up a key**

```bash
ssh-keygen -t ed25519 -C "you@example.com"     # accept defaults
cat ~/.ssh/id_ed25519.pub                      # add to GitHub > SSH keys
ssh -T git@github.com                          # test
```

**\~/.ssh/config** (quality of life)

```
Host github
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
```

Use: `ssh -T github`

**SSH server** (to allow others in)

```bash
sudo apt install -y openssh-server
sudo systemctl enable --now ssh
```

*(SSH is secure shell access, not remote desktop like TeamViewer.)*

---

## 9) Devices & Bring-Up

**General hardware**

```bash
lsusb                     # USB devices
lspci                     # PCI devices (Wi-Fi, GPU, etc.)
lsblk -f                  # disks/partitions/filesystems
sudo dmesg -w             # live kernel messages (plug/unplug to watch)
```

**Cameras (Video4Linux2)**

```bash
v4l2-ctl --list-devices   # from v4l-utils
v4l2-ctl --list-formats-ext -d /dev/video0
ffplay /dev/video0        # quick visual test (from ffmpeg)
```

**udev basics**

```bash
udevadm info -a -n /dev/video0     # attributes for rules
sudo udevadm control --reload-rules
sudo udevadm trigger
```

---

## 10) Tmux (terminal multiplexer)

**Why:** multiple panes/windows, detach/reattach, keep jobs alive over SSH.

```bash
tmux                       # start
Ctrl+b c                   # new window
Ctrl+b "                   # split horizontal
Ctrl+b %                   # split vertical
Ctrl+b arrow               # move focus
Ctrl+b d                   # detach
tmux attach                # reattach
```

Optional config: `~/.tmux.conf`

```tmux
set -g mouse on
setw -g mode-keys vi
bind r source-file ~/.tmux.conf \; display-message "tmux reloaded"
```

---

## 11) Git Essentials

**Global config (once)**

```bash
git config --global user.name  "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global push.autoSetupRemote true
```

**Everyday flow**

```bash
git init                          # start a repo in current dir
git clone git@github.com:you/repo.git

git status                        # what changed
git add file1 dir2                # stage changes
git commit -m "feat: message"     # commit

git branch                        # list branches
git switch -c feat/camera-demo    # create + switch
git switch main                   # switch branches

git diff                          # unstaged diffs
git log --oneline --graph --decorate

git remote add origin git@github.com:you/repo.git
git push -u origin main           # first push
git push                          # subsequent pushes

git pull                          # fetch + rebase (per config)
git merge feat/camera-demo        # merge branch into current

# Use -- to separate options from paths if needed:
git checkout -- README.md
```

* **Scopes for `git config`:**
  `--global` = your user (most common) • `--system` = all users • *(none)* = this repo only.

---

## 12) Python Virtual Environments

```bash
python3 -m venv .venv         # create venv in project
source .venv/bin/activate     # activate (current shell)
pip install numpy             # install inside venv
deactivate                    # leave venv
```

* **`source`** runs a script in the current shell (used for activating venvs or loading env vars).

---

## 13) Environment & Shell Tips

```bash
echo $PATH                 # where executables are searched
which python3              # where a command lives
export FOO=bar             # set env var for this shell
echo "$HOME"               # your home path
alias gs='git status'      # quick alias (add to ~/.bashrc)
source ~/.bashrc           # reload shell config
```

---

## 14) Safety & Good Habits

* Use `--` when a filename starts with `-` (e.g., `rm -- -odd`).
* Prefer `rm -i` until you’re confident; double-check `sudo rm -r`.
* Keep commits small and messages clear (`type: scope: message`).
* Use `journalctl -f` and `sudo dmesg -w` when debugging devices.
* Add yourself to `dialout` for serial devices: `sudo usermod -aG dialout $USER` (log out/in).

---

## Quick Glossary (the ones you asked about)

* `sudo` → run as admin (root)
* `apt update/upgrade/install/remove` → package manager actions
* `-y` → answer “yes” to prompts
* `-` vs `--` → short vs long options; `--` alone = end of options
* `build-essential` → compiler toolchain meta-package
* `git` → version control; `config` is a git subcommand; `--global` = your user
* `curl` → HTTP client (download/upload/APIs)
* `tmux` → terminal multiplexer (splits, detach/attach)
* `openssh-client/server` → SSH tools / SSH daemon
* `v4l-utils` → Video4Linux utilities (inspect/control webcams)
* `ffmpeg` → media toolkit; `ffplay` is great for quick camera checks
* `python3-venv` → create isolated Python envs
* `source` → run script in current shell (activate venv, load env)
* `systemctl` → manage services (start/stop/enable/status)
