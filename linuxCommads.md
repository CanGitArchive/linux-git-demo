* **`-` vs `--`**

  * **Fix:** Single dash (`-`) is for **short** one-letter options (and they can be combined, e.g. `-la`). Double dash (`--`) is for **long** named options (e.g. `--global`). A bare `--` by itself means “**end of options**; treat the rest as arguments.”
  * **Ex:** `ls -la`, `git config --global …`, `rm -- -weirdfilename`

* **`sudo`**

  * **Fix:** Runs the command as **root** (administrator). Use when changing system state (installing packages, editing `/etc`, managing services).
  * **Ex:** `sudo apt install tmux`

* **Backslash `\`**

  * **Fix:** At end of a line it means **line continuation**. Elsewhere it **escapes** the next character (e.g., spaces).
  * **Ex:**

    ```
    sudo apt install -y build-essential \
      git tmux
    ```

    or `mv "My File.txt" My\ File.txt`

* **`apt`**

  * **Fix:** Ubuntu’s **package manager** (talks to repositories, not a GUI app store).

    * `apt update` = refresh package *indexes*
    * `apt upgrade` = upgrade installed packages
    * `apt install/remove/purge` = add/remove software
  * **Ex:** `sudo apt update && sudo apt upgrade -y`

* **`-y`**

  * **Fix:** “Assume **yes** to prompts” (for `apt` and many other tools).
  * **Ex:** `sudo apt install -y curl`

* **`build-essential`**

  * **Fix:** A **meta-package** that installs a C/C++ **toolchain** (`gcc`, `g++`, `make`, headers). Needed for building native code (not only drivers).
  * **Ex:** compiling ROS packages with C++.

* **`git`**

  * **Fix:** Full **version control system**, not just “check versions.” You run subcommands like `git add/commit/branch/merge/push`.
  * **Ex:** `git commit -m "feat: add sensor node"`

* **`curl`**

  * **Fix:** Command-line **HTTP client** for downloading, uploading, and calling APIs.
  * **Ex:** `curl -L https://example.com/file -o file`

* **`tmux`**

  * **Fix:** A **terminal multiplexer**. Lets you split panes, keep sessions alive after you disconnect, and reattach later—not “run in a side terminal,” but manage many terminals in one.
  * **Ex:** `tmux` → `Ctrl+b %` (split) → `Ctrl+b d` (detach) → `tmux attach`

* **`openssh-client`**

  * **Fix:** Gives you `ssh` (remote shell), `scp` (secure copy), `sftp` (file transfer).
  * **Ex:** `ssh user@server`, `scp file user@server:/path`

* **`openssh-server`**

  * **Fix:** Runs the **SSH daemon** (`sshd`) so others can log in to your machine via the network (secure shell). It’s not a remote desktop like TeamViewer; it’s command-line access (plus port forwarding/tunnels).
  * **Ex:** `sudo systemctl enable --now ssh`

* **`v4l-utils`**

  * **Fix:** **Utilities** for Video4Linux2 devices (webcams, capture cards). Not a driver and doesn’t “enable” the webcam; it **inspects/controls** one that the kernel already sees.
  * **Ex:** `v4l2-ctl --list-devices`, `v4l2-ctl --list-formats-ext`

* **`ffmpeg` (why here)**

  * **Fix:** A suite:

    * `ffplay` = quick **viewer** (great for bring-up)
    * `ffprobe` = **inspect** media
    * `ffmpeg` = **convert/record/stream**
  * **Ex:** `ffplay /dev/video0` to sanity-check a camera feed.

* **`python3-venv`**

  * **Fix:** Provides the `venv` **module** to create **isolated Python environments** (doesn’t install Python itself). Activating a venv tweaks your shell’s PATH—no permanent env vars needed.
  * **Ex:**

    ```
    python3 -m venv .venv
    source .venv/bin/activate
    pip install numpy
    ```

* **`source`**

  * **Fix:** Shell builtin that **executes a script in the current shell** (doesn’t spawn a subshell). Used to activate venvs or load env vars/aliases.
  * **Ex:** `source ~/.bashrc`, `source .venv/bin/activate`

* **`git config --global …` scope**

  * **Fix:** `--global` applies to **your user account only** (all repos for you).

    * `--system` = all users (system-wide)
    * *(no flag)* = this repo only
  * **Ex:** `git config --global user.email "you@example.com"`

* **`systemctl`**

  * **Fix:** Controls **systemd units/services** (start/stop/restart, enable at boot, view status). It doesn’t edit system files itself.
  * **Ex:** `sudo systemctl restart ssh`, `systemctl status ssh --no-pager`

---

If you want the next tiny batch, I’ll cover: `lsusb`/`lspci`/`lsblk`, `journalctl`, `udevadm`, `ssh-keygen` + `~/.ssh/config`, and a 60-second tmux cheat sheet.
