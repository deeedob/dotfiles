# Description: My collection of useful aliases

# ---- Filesystem ----
alias ls 'exa --icons --color=always'
alias ll 'ls --long --tree --level=$argv'

function _ll
  if test -n "$argv"
    ls --long --tree --level="$argv"
  else
    ls --long --tree --level=1
  end
end
alias ll _ll  # Same as above, but with custom levels

function _la
  if test -n "$argv"
    ls --long --tree --all --level="$argv"
  else
    ls --long --tree --all --level=1
  end
end
alias la _la

alias cp 'cp -v'
alias mv 'mv -v'
alias del 'rm -i -v'

# ---- System ----
alias c 'clear'
alias h 'history'
function neovidecloseterminal
    if count $argv > /dev/null
        neovide "$argv" & disown
        exit
    else
        neovide & disown
        exit
    end
end
alias nv neovidecloseterminal
alias r 'ranger'
alias fh 'find . -name'
alias sc 'grep -i -w -n -r -I --color=always'
alias f 'find . -type f -iname '
alias rm 'trash -vr'
#alias cd 'z'
alias untar 'tar -zxvf'
alias dsize='du -sh *'
alias topmem='ps aux | sort -rk 4,4 | head -n 11'
alias sha 'shasum -a 256'
alias grep "rg --color=always --smart-case"
alias find "find . -name"
# alias cmake 'cmake -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'
alias make "make -j$(nproc)"
alias ninja "ninja -j$(nproc)"

# ---- Networking ----
alias www 'python3 -m http.server'
alias ipe 'echo -n "0: ext   ";curl ipinfo.io/ip;echo "" '
alias ipi 'ip -4 -o a | cut -d "" -f 2,7 | cut -d "/" -f 1'
alias ipa 'ipe;ipi'
alias ports 'nmap localhost'
alias netcon='sudo netstat -tulanp'
alias netcon='sudo netstat -tulanp'

# ---- Virtualization ----
function virton
  sudo systemctl start libvirtd.service
  sudo systemctl start virtlogd.service
end
alias virton virton
function virtoff
  sudo systemctl stop libvirtd.service
  sudo systemctl stop virtlogd.service
end
alias virtoff virtoff

# ---- WiFi ----
alias wifioff 'sudo ip link set wlo1 down'
alias wifion 'sudo ip link set wlo1 up'

# you have to quote the link
alias grabwav 'yt-dlp --no-playlist -x --audio-format wav -o "~/Samples/DropZone/%(title)s.%(ext)s"'
alias grabmp3 'yt-dlp --no-playlist -x --audio-format mp3 -o "~/Samples/DropZone/%(title)s.%(ext)s"'

