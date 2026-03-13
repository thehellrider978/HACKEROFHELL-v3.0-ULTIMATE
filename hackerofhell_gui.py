#!/usr/bin/env python3
"""
HackerOfHell v3.0 — Ultimate GUI
Author: RAJESH BAJIYA | Handle: HACKEROFHELL
Run: python3 hackerofhell_gui.py
Requires: sudo apt install python3-tk
"""

import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox, filedialog
import subprocess, threading, os, json, time, signal
from datetime import datetime
from pathlib import Path

# ── THEME ───────────────────────────────────────────────────────────
BG     = "#050a0f"
S      = "#0a1520"
S2     = "#0f1e2e"
BORDER = "#1a3a5c"
TEXT   = "#c8e6f0"
MUTED  = "#4a7a9b"
ACCENT = "#00d4ff"
RED    = "#ff2d55"
ORANGE = "#ff6b35"
GREEN  = "#39ff14"
YELLOW = "#ffd60a"
PURPLE = "#bf5af2"

FM  = ("Courier New", 9)
FMS = ("Courier New", 8)
FML = ("Courier New", 12, "bold")
FT  = ("Courier New", 16, "bold")
FH  = ("Courier New", 10, "bold")

class HackerOfHellGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("HackerOfHell v3.0 — RAJESH BAJIYA | HACKEROFHELL")
        self.root.geometry("1280x800")
        self.root.minsize(1000, 650)
        self.root.configure(bg=BG)
        self.process = None
        self.running = False
        self.start_time = None
        self.counts = {"CRITICAL":0,"HIGH":0,"MEDIUM":0,"LOW":0,"CHAIN":0}
        self._build()
        self._clock()
        self._matrix_tick()

    def _build(self):
        # ── TOP BAR ──
        top = tk.Frame(self.root, bg=S, height=70)
        top.pack(fill=tk.X)
        top.pack_propagate(False)
        tk.Frame(self.root, bg=RED, height=2).pack(fill=tk.X)

        # ASCII mini logo
        tk.Label(top, text="⚡", font=("Courier New",28), fg=RED, bg=S
                 ).pack(side=tk.LEFT, padx=14, pady=8)

        title_frame = tk.Frame(top, bg=S)
        title_frame.pack(side=tk.LEFT, pady=8)
        tk.Label(title_frame, text="HACKEROFHELL", font=FT,
                 fg=RED, bg=S).pack(anchor=tk.W)
        tk.Label(title_frame, text="v3.0 ULTIMATE  |  RAJESH BAJIYA  |  World's Most Complete Bug Bounty Suite",
                 font=FMS, fg=MUTED, bg=S).pack(anchor=tk.W)

        # Right side of top bar
        self.clock_lbl = tk.Label(top, text="", font=FM, fg=MUTED, bg=S)
        self.clock_lbl.pack(side=tk.RIGHT, padx=16)
        self.status_dot = tk.Label(top, text="●", font=("Courier New",14), fg=BORDER, bg=S)
        self.status_dot.pack(side=tk.RIGHT, padx=4)
        tk.Label(top, text="STATUS:", font=FMS, fg=MUTED, bg=S).pack(side=tk.RIGHT)

        # ── MAIN LAYOUT ──
        main = tk.Frame(self.root, bg=BG)
        main.pack(fill=tk.BOTH, expand=True)

        # Left sidebar
        left = tk.Frame(main, bg=S, width=320)
        left.pack(side=tk.LEFT, fill=tk.Y)
        left.pack_propagate(False)
        tk.Frame(main, bg=BORDER, width=1).pack(side=tk.LEFT, fill=tk.Y)

        # Right content
        right = tk.Frame(main, bg=BG)
        right.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

        self._build_left(left)
        self._build_right(right)

    def _build_left(self, p):
        # Scrollable left panel
        canvas = tk.Canvas(p, bg=S, highlightthickness=0)
        scroll = tk.Scrollbar(p, orient=tk.VERTICAL, command=canvas.yview)
        frame  = tk.Frame(canvas, bg=S)
        canvas.configure(yscrollcommand=scroll.set)
        scroll.pack(side=tk.RIGHT, fill=tk.Y)
        canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        canvas.create_window((0,0), window=frame, anchor=tk.NW)
        frame.bind("<Configure>", lambda e: canvas.configure(scrollregion=canvas.bbox("all")))

        # ── TARGET ──
        self._sec(frame, "// TARGET")
        self._lbl(frame, "DOMAIN")
        self.target_v = tk.StringVar()
        self._entry(frame, self.target_v, "target.com", GREEN)

        self._lbl(frame, "OUTPUT DIR")
        od = tk.Frame(frame, bg=S)
        od.pack(fill=tk.X, padx=10, pady=(0,8))
        self.outdir_v = tk.StringVar(value=str(Path.home()/"hackerofhell"))
        tk.Entry(od, textvariable=self.outdir_v, font=FMS, bg=BG, fg=TEXT,
                 insertbackground=TEXT, relief=tk.FLAT, bd=0,
                 highlightthickness=1, highlightcolor=ACCENT, highlightbackground=BORDER
                 ).pack(side=tk.LEFT, fill=tk.X, expand=True, ipady=5)
        tk.Button(od, text="…", font=FMS, bg=BORDER, fg=TEXT, relief=tk.FLAT,
                  bd=0, padx=6, cursor="hand2",
                  command=lambda: self.outdir_v.set(
                      filedialog.askdirectory(initialdir=str(Path.home())) or self.outdir_v.get())
                  ).pack(side=tk.RIGHT, padx=(3,0), ipady=5)

        self._lbl(frame, "SCRIPT PATH")
        self.script_v = tk.StringVar(value=str(Path.home()/"autopwn/hackerofhell.sh"))
        self._entry(frame, self.script_v, "~/autopwn/hackerofhell.sh", TEXT)

        self._lbl(frame, "PROXY (optional)")
        self.proxy_v = tk.StringVar()
        self._entry(frame, self.proxy_v, "http://127.0.0.1:8080", MUTED)

        self._lbl(frame, "DISCORD/SLACK WEBHOOK (optional)")
        self.webhook_v = tk.StringVar()
        self._entry(frame, self.webhook_v, "https://hooks.slack.com/...", MUTED)

        # ── MODE ──
        tk.Frame(frame, bg=BORDER, height=1).pack(fill=tk.X, padx=10, pady=6)
        self._sec(frame, "// SCAN MODE")
        self.mode_v = tk.StringVar(value="normal")
        modes = [
            ("PASSIVE   — No active requests", "passive"),
            ("NORMAL    — Balanced (recommended)", "normal"),
            ("ULTRA     — Deep scan, all modules", "ultra"),
        ]
        for txt, val in modes:
            tk.Radiobutton(frame, text=txt, variable=self.mode_v, value=val,
                           font=FMS, fg=TEXT, bg=S, selectcolor=BG,
                           activebackground=S, activeforeground=ACCENT,
                           indicatoron=True, bd=0
                           ).pack(anchor=tk.W, padx=18, pady=2)

        # Rate limit
        self._lbl(frame, "RATE LIMIT (req/sec)")
        self.rate_v = tk.StringVar(value="150")
        self._entry(frame, self.rate_v, "150", YELLOW)

        # ── MODULES ──
        tk.Frame(frame, bg=BORDER, height=1).pack(fill=tk.X, padx=10, pady=6)
        self._sec(frame, "// MODULES")
        self.mods = {}
        modules = [
            ("Subdomain Enum (subfinder+amass)", "recon",   True,  ACCENT),
            ("Cert Transparency (crt.sh)",        "crt",    True,  ACCENT),
            ("DNS Intelligence + Zone XFR",       "dns",    True,  ACCENT),
            ("URL Harvesting (gau+wayback)",       "urls",   True,  ACCENT),
            ("Nmap Full Port Scan",                "nmap",   True,  PURPLE),
            ("WAF + Tech Fingerprint",             "waf",    True,  PURPLE),
            ("WordPress Scan (wpscan)",            "wpscan", True,  PURPLE),
            ("Admin Panel Discovery",              "admin",  True,  ORANGE),
            ("Backup File Hunting",                "backup", True,  ORANGE),
            ("Sensitive File Check (30+ paths)",   "files",  True,  ORANGE),
            ("JS Secret Mining",                   "js",     True,  ORANGE),
            ("API Endpoint Discovery",             "api",    True,  ORANGE),
            ("Nuclei Full Template Scan",          "nuclei", True,  RED),
            ("Subdomain Takeover (10 services)",   "takeover",True, RED),
            ("XSS — dalfox + DOM mining",          "xss",    True,  RED),
            ("SQL Injection — sqlmap",             "sqli",   True,  RED),
            ("CORS Misconfiguration (4 bypasses)", "cors",   True,  RED),
            ("Open Redirect (15+ params)",         "redir",  True,  YELLOW),
            ("SSRF (cloud metadata probes)",       "ssrf",   True,  YELLOW),
            ("LFI / Path Traversal",               "lfi",    True,  YELLOW),
            ("403 Bypass Techniques",              "bypass", True,  YELLOW),
            ("Default Credential Testing",         "auth",   True,  GREEN),
            ("Bug Chain Analysis",                 "chains", True,  GREEN),
        ]
        for name, key, default, col in modules:
            v = tk.BooleanVar(value=default)
            self.mods[key] = v
            row = tk.Frame(frame, bg=S)
            row.pack(fill=tk.X, padx=10, pady=1)
            tk.Label(row, text="■", font=("Courier New",7), fg=col, bg=S).pack(side=tk.LEFT, padx=(4,0))
            tk.Checkbutton(row, text=name, variable=v, font=FMS,
                           fg=TEXT, bg=S, selectcolor=BG,
                           activebackground=S, activeforeground=GREEN,
                           bd=0, padx=4
                           ).pack(side=tk.LEFT, anchor=tk.W)

        # ── OPTIONS ──
        tk.Frame(frame, bg=BORDER, height=1).pack(fill=tk.X, padx=10, pady=6)
        self._sec(frame, "// OPTIONS")
        self.skip_heavy = tk.BooleanVar(value=False)
        self.deep_mode  = tk.BooleanVar(value=False)
        tk.Checkbutton(frame, text="--skip-heavy  (faster, skip sqlmap)", variable=self.skip_heavy,
                       font=FMS, fg=TEXT, bg=S, selectcolor=BG,
                       activebackground=S, activeforeground=YELLOW, bd=0, padx=18
                       ).pack(anchor=tk.W, pady=2)
        tk.Checkbutton(frame, text="--deep  (all 65535 ports, full scan)", variable=self.deep_mode,
                       font=FMS, fg=TEXT, bg=S, selectcolor=BG,
                       activebackground=S, activeforeground=RED, bd=0, padx=18
                       ).pack(anchor=tk.W, pady=2)

        # ── BUTTONS ──
        tk.Frame(frame, bg=BORDER, height=1).pack(fill=tk.X, padx=10, pady=8)
        bf = tk.Frame(frame, bg=S)
        bf.pack(fill=tk.X, padx=10, pady=(0,10))

        self.start_btn = tk.Button(bf, text="▶  LAUNCH SCAN",
            font=FH, bg=GREEN, fg=BG, relief=tk.FLAT, bd=0,
            padx=10, pady=12, cursor="hand2", command=self._start)
        self.start_btn.pack(fill=tk.X, pady=(0,5))

        self.stop_btn = tk.Button(bf, text="■  ABORT",
            font=FH, bg=RED, fg=TEXT, relief=tk.FLAT, bd=0,
            padx=10, pady=10, cursor="hand2", command=self._stop,
            state=tk.DISABLED)
        self.stop_btn.pack(fill=tk.X, pady=(0,5))

        self.report_btn = tk.Button(bf, text="📄  OPEN REPORT",
            font=FH, bg=ACCENT, fg=BG, relief=tk.FLAT, bd=0,
            padx=10, pady=10, cursor="hand2", command=self._open_report,
            state=tk.DISABLED)
        self.report_btn.pack(fill=tk.X, pady=(0,5))

        tk.Button(bf, text="📁  OPEN OUTPUT DIR",
            font=FH, bg=BORDER, fg=TEXT, relief=tk.FLAT, bd=0,
            padx=10, pady=8, cursor="hand2",
            command=lambda: subprocess.Popen(
                ["xdg-open", self.outdir_v.get()+"/"+self.target_v.get()])
            ).pack(fill=tk.X)

        # ── TIMER ──
        tk.Frame(frame, bg=BORDER, height=1).pack(fill=tk.X, padx=10, pady=6)
        tr = tk.Frame(frame, bg=S)
        tr.pack(fill=tk.X, padx=10, pady=(0,16))
        tk.Label(tr, text="ELAPSED:", font=FMS, fg=MUTED, bg=S).pack(side=tk.LEFT)
        self.elapsed = tk.Label(tr, text="00:00:00", font=FM, fg=ACCENT, bg=S)
        self.elapsed.pack(side=tk.LEFT, padx=8)

    def _build_right(self, p):
        # ── TAB BAR ──
        tabbar = tk.Frame(p, bg=S2, height=36)
        tabbar.pack(fill=tk.X)
        tabbar.pack_propagate(False)
        tk.Frame(p, bg=BORDER, height=1).pack(fill=tk.X)

        content = tk.Frame(p, bg=BG)
        content.pack(fill=tk.BOTH, expand=True)

        self.tabs = {}
        self.tbtns = {}
        tab_defs = [
            ("LIVE OUTPUT",  "out"),
            ("FINDINGS",     "find"),
            ("PHASES",       "phase"),
            ("VULN CHAINS",  "chain"),
            ("MATRIX",       "matrix"),
        ]
        for lbl, key in tab_defs:
            btn = tk.Button(tabbar, text=lbl, font=FMS, bg=S2, fg=MUTED,
                            relief=tk.FLAT, bd=0, padx=14,
                            cursor="hand2",
                            command=lambda k=key: self._tab(k))
            btn.pack(side=tk.LEFT, fill=tk.Y)
            self.tbtns[key] = btn

        # ── OUTPUT TAB ──
        out_f = tk.Frame(content, bg=BG)
        self.tabs["out"] = out_f
        th = tk.Frame(out_f, bg="#010409", height=26)
        th.pack(fill=tk.X); th.pack_propagate(False)
        for c in ["#ff5f57","#febc2e","#28c840"]:
            tk.Label(th, text="●", fg=c, bg="#010409", font=FM).pack(side=tk.LEFT, padx=4, pady=3)
        self.term_title = tk.Label(th, text="hackerofhell.sh — idle",
            font=FMS, fg=MUTED, bg="#010409")
        self.term_title.pack(side=tk.LEFT, padx=8)
        self.out_txt = scrolledtext.ScrolledText(out_f, font=FMS,
            bg="#010409", fg="#8ec8e8", relief=tk.FLAT, bd=0,
            wrap=tk.WORD, state=tk.DISABLED)
        self.out_txt.pack(fill=tk.BOTH, expand=True)
        for tag, col, bold in [
            ("phase", PURPLE, True),("found",GREEN,True),("vuln",RED,True),
            ("warn",YELLOW,False),("info",ACCENT,False),("muted",MUTED,False),("n","#8ec8e8",False)]:
            self.out_txt.tag_config(tag, foreground=col,
                font=("Courier New",9,"bold") if bold else FMS)

        # ── FINDINGS TAB ──
        find_f = tk.Frame(content, bg=BG)
        self.tabs["find"] = find_f
        sev_bar = tk.Frame(find_f, bg=S)
        sev_bar.pack(fill=tk.X)
        self.sev_lbls = {}
        for sev, col in [("CRITICAL",RED),("HIGH",ORANGE),("MEDIUM",YELLOW),("LOW",GREEN)]:
            box = tk.Frame(sev_bar, bg=S)
            box.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=1, pady=6)
            tk.Label(box, text=sev, font=FMS, fg=col, bg=S).pack()
            l = tk.Label(box, text="0", font=("Courier New",20,"bold"), fg=col, bg=S)
            l.pack()
            self.sev_lbls[sev] = l
        tk.Frame(find_f, bg=BORDER, height=1).pack(fill=tk.X)
        self.find_txt = scrolledtext.ScrolledText(find_f, font=FMS,
            bg=BG, fg=TEXT, relief=tk.FLAT, bd=0, wrap=tk.WORD, state=tk.DISABLED)
        self.find_txt.pack(fill=tk.BOTH, expand=True, padx=6, pady=6)
        for t,c,b in [("ct",RED,True),("ht",ORANGE,True),("mt",YELLOW,True),
                       ("lt",GREEN,True),("lbl",MUTED,False),("val",TEXT,False),
                       ("poc",GREEN,False),("sep",BORDER,False)]:
            self.find_txt.tag_config(t, foreground=c,
                font=("Courier New",9,"bold") if b else FMS)

        # ── PHASES TAB ──
        phase_f = tk.Frame(content, bg=BG)
        self.tabs["phase"] = phase_f
        self.phase_rows = {}
        phases = [
            ("01","PASSIVE INTEL","Subfinder, Amass, crt.sh, GAU, Wayback, WHOIS, ASN"),
            ("02","ACTIVE ENUM","Nmap, HTTPX, WAF, Whatweb, WPScan, Email harvest"),
            ("03","CONTENT DISCOVERY","Gobuster, FFUF, Backup files, 30+ sensitive paths, JS mining"),
            ("04","VULN SCANNING","Nuclei full templates, Subdomain takeover (10 services)"),
            ("05","VERIFICATION","SQLi, XSS, CORS, SSRF, LFI, Open Redirect, 403 Bypass, Auth"),
            ("06","CHAIN ANALYSIS","Combining vulns for escalated impact paths"),
            ("07","REPORT","Professional HTML report with CVSS, PoC, remediation"),
        ]
        for num, name, tools in phases:
            row = tk.Frame(phase_f, bg=S, relief=tk.FLAT)
            row.pack(fill=tk.X, padx=14, pady=4)
            nl = tk.Label(row, text=num, font=("Courier New",18,"bold"),
                          fg=BORDER, bg=S, width=3)
            nl.pack(side=tk.LEFT, padx=10, pady=10)
            info = tk.Frame(row, bg=S)
            info.pack(side=tk.LEFT, fill=tk.X, expand=True, pady=6)
            nname = tk.Label(info, text=name, font=FH, fg=TEXT, bg=S, anchor=tk.W)
            nname.pack(fill=tk.X)
            tk.Label(info, text=tools, font=FMS, fg=MUTED, bg=S, anchor=tk.W).pack(fill=tk.X)
            sl = tk.Label(row, text="WAITING", font=FMS, fg=MUTED, bg=S, width=12)
            sl.pack(side=tk.RIGHT, padx=10)
            self.phase_rows[num] = {"frame":row,"num":nl,"name":nname,"status":sl}

        # Progress bar
        pf = tk.Frame(phase_f, bg=BG)
        pf.pack(fill=tk.X, padx=14, pady=14)
        tk.Label(pf, text="OVERALL PROGRESS", font=FMS, fg=MUTED, bg=BG).pack(anchor=tk.W)
        style = ttk.Style(); style.theme_use('clam')
        style.configure("H.TProgressbar", troughcolor=BORDER, background=GREEN, thickness=10)
        self.progress = ttk.Progressbar(pf, style="H.TProgressbar",
                                         mode='determinate', maximum=100)
        self.progress.pack(fill=tk.X, pady=4)
        self.prog_lbl = tk.Label(pf, text="0%", font=FMS, fg=ACCENT, bg=BG)
        self.prog_lbl.pack(anchor=tk.E)

        # ── CHAIN TAB ──
        chain_f = tk.Frame(content, bg=BG)
        self.tabs["chain"] = chain_f
        tk.Label(chain_f,
                 text="⛓  VULNERABILITY CHAINS",
                 font=FH, fg=RED, bg=BG).pack(anchor=tk.W, padx=14, pady=(14,4))
        tk.Label(chain_f,
                 text="Combinations of findings that create escalated impact paths",
                 font=FMS, fg=MUTED, bg=BG).pack(anchor=tk.W, padx=14)
        tk.Frame(chain_f, bg=BORDER, height=1).pack(fill=tk.X, padx=14, pady=8)
        self.chain_txt = scrolledtext.ScrolledText(chain_f, font=FM,
            bg=BG, fg=TEXT, relief=tk.FLAT, bd=0, wrap=tk.WORD, state=tk.DISABLED)
        self.chain_txt.pack(fill=tk.BOTH, expand=True, padx=8, pady=4)
        for t,c,b in [("ch",RED,True),("ci",ORANGE,False),("cv",TEXT,False),("cm",MUTED,False)]:
            self.chain_txt.tag_config(t, foreground=c,
                font=("Courier New",9,"bold") if b else FM)

        # ── MATRIX TAB ──
        matrix_f = tk.Frame(content, bg=BG)
        self.tabs["matrix"] = matrix_f
        tk.Label(matrix_f, text="// LIVE FINDINGS MATRIX",
                 font=FH, fg=ACCENT, bg=BG).pack(anchor=tk.W, padx=14, pady=(14,4))
        tk.Frame(matrix_f, bg=BORDER, height=1).pack(fill=tk.X, padx=14, pady=4)
        self.matrix_canvas = tk.Canvas(matrix_f, bg=BG, highlightthickness=0)
        self.matrix_canvas.pack(fill=tk.BOTH, expand=True)
        self._matrix_chars = []
        self._matrix_cols = []

        # ── BOTTOM STATUS ──
        tk.Frame(self.root, bg=BORDER, height=1).pack(fill=tk.X, side=tk.BOTTOM)
        sb = tk.Frame(self.root, bg=S2, height=22)
        sb.pack(fill=tk.X, side=tk.BOTTOM)
        sb.pack_propagate(False)
        self.status_lbl = tk.Label(sb,
            text="  Ready — RAJESH BAJIYA | HACKEROFHELL v3.0",
            font=FMS, fg=MUTED, bg=S2, anchor=tk.W)
        self.status_lbl.pack(side=tk.LEFT, fill=tk.X, expand=True)
        self.count_lbl = tk.Label(sb, text="Findings: 0  ",
            font=FMS, fg=ACCENT, bg=S2)
        self.count_lbl.pack(side=tk.RIGHT)

        # Switch to output tab
        self._tab("out")

    # ── MATRIX ANIMATION ─────────────────────────────────────────────
    def _matrix_tick(self):
        try:
            c = self.matrix_canvas
            w = c.winfo_width() or 800
            h = c.winfo_height() or 400
            if not self._matrix_cols:
                cols = w // 14
                self._matrix_cols = [{'x': i*14+7, 'y': (i*37)%h, 'speed': 1+(i%3)} for i in range(cols)]
                for col in self._matrix_cols:
                    lbl = c.create_text(col['x'], col['y'],
                        text=chr(0x30A0 + (col['x']%96)),
                        font=("Courier New",9), fill=GREEN, anchor=tk.N)
                    self._matrix_chars.append(lbl)
            for i, col in enumerate(self._matrix_cols):
                if i < len(self._matrix_chars):
                    col['y'] = (col['y'] + col['speed']) % (h + 20)
                    c.coords(self._matrix_chars[i], col['x'], col['y'])
                    c.itemconfig(self._matrix_chars[i],
                        text=chr(0x30A0 + (col['y']//3 % 96)),
                        fill=GREEN if col['y'] % 40 < 5 else "#0a3a0a")
        except Exception:
            pass
        self.root.after(60, self._matrix_tick)

    # ── HELPERS ──────────────────────────────────────────────────────
    def _sec(self, p, t):
        tk.Label(p, text=t, font=FM, fg=ACCENT, bg=S, anchor=tk.W
                 ).pack(fill=tk.X, padx=10, pady=(10,3))

    def _lbl(self, p, t):
        tk.Label(p, text=t, font=FMS, fg=MUTED, bg=S, anchor=tk.W
                 ).pack(fill=tk.X, padx=10, pady=(0,2))

    def _entry(self, p, var, ph, col):
        e = tk.Entry(p, textvariable=var, font=FM, bg=BG, fg=col,
                     insertbackground=col, relief=tk.FLAT, bd=0,
                     highlightthickness=1, highlightcolor=ACCENT,
                     highlightbackground=BORDER)
        e.pack(fill=tk.X, padx=10, pady=(0,8), ipady=6)
        if not var.get():
            e.insert(0, ph)
            e.config(fg=MUTED)
            def on_focus_in(ev, entry=e, c=col, v=var, placeholder=ph):
                if entry.get() == placeholder:
                    entry.delete(0, tk.END)
                    entry.config(fg=c)
            def on_focus_out(ev, entry=e, placeholder=ph):
                if not entry.get():
                    entry.insert(0, placeholder)
                    entry.config(fg=MUTED)
            e.bind("<FocusIn>", on_focus_in)
            e.bind("<FocusOut>", on_focus_out)
        return e

    def _clock(self):
        self.clock_lbl.config(text=datetime.now().strftime("%Y-%m-%d  %H:%M:%S"))
        self.root.after(1000, self._clock)

    def _tab(self, key):
        for k, f in self.tabs.items(): f.pack_forget()
        for k, b in self.tbtns.items(): b.config(bg=S2, fg=MUTED)
        self.tabs[key].pack(fill=tk.BOTH, expand=True)
        self.tbtns[key].config(bg=BG, fg=ACCENT)

    def _write(self, text, tag="n"):
        self.out_txt.config(state=tk.NORMAL)
        self.out_txt.insert(tk.END, text, tag)
        self.out_txt.config(state=tk.DISABLED)
        self.out_txt.see(tk.END)

    def _clear_out(self):
        self.out_txt.config(state=tk.NORMAL)
        self.out_txt.delete(1.0, tk.END)
        self.out_txt.config(state=tk.DISABLED)

    def _set_phase(self, num, status):
        if num not in self.phase_rows: return
        r = self.phase_rows[num]
        if status == "RUNNING":
            r["frame"].config(bg=S2); r["num"].config(fg=YELLOW,bg=S2)
            r["name"].config(bg=S2); r["status"].config(text="▶ RUNNING",fg=YELLOW,bg=S2)
        elif status == "DONE":
            r["frame"].config(bg=S); r["num"].config(fg=GREEN,bg=S)
            r["name"].config(bg=S); r["status"].config(text="✓ DONE",fg=GREEN,bg=S)

    def _upd_counts(self):
        for s, l in self.sev_lbls.items():
            l.config(text=str(self.counts.get(s,0)))
        total = sum(self.counts.values())
        self.count_lbl.config(text=f"Findings: {total}  ")

    def _add_finding(self, sev, line):
        self.counts[sev] = self.counts.get(sev,0) + 1
        self._upd_counts()
        tag_map = {"CRITICAL":"ct","HIGH":"ht","MEDIUM":"mt","LOW":"lt"}
        tag = tag_map.get(sev,"ht")
        self.find_txt.config(state=tk.NORMAL)
        self.find_txt.insert(tk.END, f"\n[{sev}] ", tag)
        self.find_txt.insert(tk.END, line.replace("[VULN]","").strip()+"\n", "val")
        self.find_txt.insert(tk.END, "─"*65+"\n", "sep")
        self.find_txt.config(state=tk.DISABLED)
        self.find_txt.see(tk.END)

    def _process_line(self, line):
        line = line.rstrip()
        if not line: return
        tag = "n"
        if any(c in line for c in ["╔","╚","║","╠","╗","╝"]) or "PHASE" in line: tag="phase"
        elif line.startswith("[VULN]") or "CONFIRMED" in line or "TAKEOVER" in line or \
             "SECRET" in line or "EXPOSED" in line or "BYPASS" in line: tag="vuln"
        elif line.startswith("[+]"): tag="found"
        elif line.startswith("[!]"): tag="warn"
        elif line.startswith("[*]") or line.startswith("[i]"): tag="info"
        self._write(line+"\n", tag)

        # Phase detection
        for ptext, pnum in [("PHASE 1","01"),("PHASE 2","02"),("PHASE 3","03"),
                             ("PHASE 4","04"),("PHASE 5","05"),("PHASE 6","06"),("PHASE 7","07")]:
            if ptext in line:
                self._set_phase(pnum,"RUNNING")
                prev = f"{int(pnum)-1:02d}"
                if prev != "00": self._set_phase(prev,"DONE")
                prog = (int(pnum)-1)*14
                self.progress["value"] = prog
                self.prog_lbl.config(text=f"{prog}%")

        # Vuln detection
        if tag == "vuln":
            sev = "HIGH"
            if any(k in line for k in ["INJECTION","SECRET","SSRF","LFI","ZONE TRANSFER","DEFAULT CRED"]): sev="CRITICAL"
            elif any(k in line for k in ["XSS","TAKEOVER","ADMIN","EXPOSED SERVICE","BACKUP"]): sev="HIGH"
            elif any(k in line for k in ["REDIRECT","CORS","BYPASS"]): sev="MEDIUM"
            self._add_finding(sev, line)

        # Chain detection
        if "CHAIN ANALYSIS" in line or "⛓" in line:
            self.chain_txt.config(state=tk.NORMAL)
            self.chain_txt.insert(tk.END, line+"\n", "ch")
            self.chain_txt.config(state=tk.DISABLED)

    # ── SCAN CONTROL ─────────────────────────────────────────────────
    def _start(self):
        target = self.target_v.get().strip()
        script = self.script_v.get().strip()
        outdir = self.outdir_v.get().strip()
        rate   = self.rate_v.get().strip() or "150"
        proxy  = self.proxy_v.get().strip()
        webhook= self.webhook_v.get().strip()
        mode   = self.mode_v.get()

        if not target or target == "target.com":
            messagebox.showerror("Error","Enter a valid target domain!")
            return
        if not os.path.exists(script):
            messagebox.showerror("Script Not Found",
                f"Script not found:\n{script}\n\nMake sure hackerofhell.sh is there.")
            return

        os.makedirs(outdir, exist_ok=True)

        # Reset
        self._clear_out()
        self.find_txt.config(state=tk.NORMAL); self.find_txt.delete(1.0,tk.END); self.find_txt.config(state=tk.DISABLED)
        self.chain_txt.config(state=tk.NORMAL); self.chain_txt.delete(1.0,tk.END); self.chain_txt.config(state=tk.DISABLED)
        for k in self.counts: self.counts[k]=0
        self._upd_counts()
        for p in self.phase_rows.values():
            p["frame"].config(bg=S); p["num"].config(fg=BORDER,bg=S)
            p["status"].config(text="WAITING",fg=MUTED,bg=S)
        self.progress["value"]=0; self.prog_lbl.config(text="0%")
        self.report_btn.config(state=tk.DISABLED)
        self.elapsed.config(text="00:00:00")

        self.running = True
        self.start_time = time.time()
        self.start_btn.config(state=tk.DISABLED, bg=BORDER, fg=MUTED)
        self.stop_btn.config(state=tk.NORMAL)
        self.status_dot.config(fg=YELLOW)
        self.term_title.config(text=f"hackerofhell.sh — scanning {target}")
        self.status_lbl.config(text=f"  Scanning: {target}  |  Mode: {mode.upper()}  |  HACKEROFHELL v3.0")

        # Banner
        self._write("╔══════════════════════════════════════════════════════════╗\n","phase")
        self._write(f"║  HACKEROFHELL v3.0  |  RAJESH BAJIYA  |  {target:<18}║\n","phase")
        self._write(f"║  Mode: {mode.upper():<52}║\n","phase")
        self._write("╚══════════════════════════════════════════════════════════╝\n\n","phase")

        self._update_elapsed()
        threading.Thread(target=self._run,
            args=(script, target, outdir, mode, rate, proxy, webhook),
            daemon=True).start()

    def _run(self, script, target, outdir, mode, rate, proxy, webhook):
        try:
            cmd = ["sudo","bash",script,"-t",target,"-o",outdir,"-m",mode,"-r",rate]
            if proxy:   cmd += ["-p", proxy]
            if webhook: cmd += ["-n", webhook]
            if self.skip_heavy.get(): cmd.append("--skip-heavy")
            if self.deep_mode.get():  cmd.append("--deep")

            self.process = subprocess.Popen(
                cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                text=True, bufsize=1, preexec_fn=os.setsid)

            for line in iter(self.process.stdout.readline,''):
                if not self.running: break
                self.root.after(0, self._process_line, line)
            self.process.wait()
            self.root.after(0, self._finished, target, outdir)
        except Exception as e:
            self.root.after(0, self._write, f"ERROR: {e}\n", "vuln")
            self.root.after(0, self._finished, target, outdir)

    def _finished(self, target, outdir):
        self.running = False
        self._set_phase("07","DONE")
        self.progress["value"]=100; self.prog_lbl.config(text="100% — COMPLETE")
        self.start_btn.config(state=tk.NORMAL, bg=GREEN, fg=BG)
        self.stop_btn.config(state=tk.DISABLED)
        self.status_dot.config(fg=GREEN)
        total = sum(self.counts.values())
        self._write(f"\n✓ SCAN COMPLETE — {total} findings\n","found")

        # Find report
        reports = list(Path(outdir).glob(f"**/{target}**/07_report/*.html"))
        if reports:
            self.last_report = str(sorted(reports)[-1])
            self.report_btn.config(state=tk.NORMAL)
            self._write(f"✓ Report: {self.last_report}\n","found")
        self.status_lbl.config(text=f"  COMPLETE — {total} findings — HACKEROFHELL v3.0")
        self.term_title.config(text=f"hackerofhell.sh — finished [{target}]")

        # Load chain analysis from findings.json
        fj = Path(outdir)/target/"findings.json"
        if fj.exists(): self._load_chains(fj)

    def _load_chains(self, path):
        try:
            with open(path) as f: data = json.load(f)
            chains = data.get("chains",[])
            if not chains: return
            self.chain_txt.config(state=tk.NORMAL)
            self.chain_txt.delete(1.0, tk.END)
            for c in chains:
                self.chain_txt.insert(tk.END,
                    f"\n⛓  {c.get('chain','')}  [CVSS {c.get('combined_cvss','?')}]\n","ch")
                self.chain_txt.insert(tk.END,
                    f"Impact: {c.get('impact','')}\n","ci")
                self.chain_txt.insert(tk.END,
                    f"{c.get('description','')}\n","cv")
                self.chain_txt.insert(tk.END,"━"*65+"\n","cm")
            self.chain_txt.config(state=tk.DISABLED)
            self.counts["CHAIN"] = len(chains)
        except Exception:
            pass

    def _stop(self):
        if self.process:
            try: os.killpg(os.getpgid(self.process.pid), signal.SIGTERM)
            except: pass
        self.running = False
        self.start_btn.config(state=tk.NORMAL, bg=GREEN, fg=BG)
        self.stop_btn.config(state=tk.DISABLED)
        self.status_dot.config(fg=RED)
        self._write("\n[!] Scan aborted by user.\n","warn")

    def _open_report(self):
        if hasattr(self,'last_report') and os.path.exists(self.last_report):
            subprocess.Popen(["firefox",self.last_report])
        else:
            outdir=self.outdir_v.get(); target=self.target_v.get()
            results=list(Path(outdir).glob(f"**/{target}**/07_report/*.html"))
            if results: subprocess.Popen(["firefox",str(results[0])])
            else: messagebox.showinfo("Not Found",
                    f"Report not found yet.\nLook in:\n{outdir}/{target}/07_report/")

    def _update_elapsed(self):
        if self.running and self.start_time:
            e=int(time.time()-self.start_time)
            h,r=divmod(e,3600); m,s=divmod(r,60)
            self.elapsed.config(text=f"{h:02d}:{m:02d}:{s:02d}")
            self.root.after(1000, self._update_elapsed)

if __name__ == "__main__":
    root = tk.Tk()
    root.option_add("*tearOff", False)
    try: root.tk.call('tk','scaling',1.2)
    except: pass
    app = HackerOfHellGUI(root)
    root.mainloop()
