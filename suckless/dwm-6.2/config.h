/* See LICENSE file for copyright and license details. */

/* needed for media keys to work */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx       = 2;        /* border pixel of windows */
static const unsigned int snap           = 32;       /* snap pixel */
static const unsigned int gappih         = 10;        /* horiz inner gap between windows */
static const unsigned int gappiv         = 10;        /* vert inner gap between windows */
static const unsigned int gappoh         = 20;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov         = 20;       /* vert outer gap between windows and screen edge */
static const int smartgaps               = 0;        /* 1 means no outer gap when there is only one window */
static const unsigned int systraypinning = 1;        /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;        /* systray spacing */
static const int systraypinningfailfirst = 1;        /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray             = 1;        /* 0 means no systray */
static const int showbar                 = 1;        /* 0 means no bar */
static const int topbar                  = 1;        /* 0 means bottom bar */
static const int user_bh                 = 24;        /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
/*  Display modes of the tab bar: never shown, always shown, shown only in  */
/*  monocle mode in the presence of several windows.                        */
/*  Modes after showtab_nmodes are disabled.                                */
enum showtab_modes { showtab_never, showtab_auto, showtab_nmodes, showtab_always};
static const int showtab                 = showtab_never;      /* Default tab bar show mode */
static const int toptab                  = True;               /* False means bottom tab bar */
static const char *fonts[]               = { "FiraCode Nerd Font:size=10:style=bold" };
static const char dmenufont[]            = "FiraCode Nerd Font:size=10:style=bold";
static char normbgcolor[]                = "#222222";
static char normbordercolor[]            = "#444444";
static char normfgcolor[]                = "#bbbbbb";
static char selfgcolor[]                 = "#eeeeee";
static char selbordercolor[]             = "#005577";
static char selbgcolor[]                 = "#005577";
static char hidfgcolor[]                 = "#005577";
static char hidbordercolor[]             = "#005577";
static char hidbgcolor[]                 = "#005577";
static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
       [SchemeHid]  = { hidfgcolor,  hidbgcolor,  hidbordercolor },
};

static const char *const autostart[] = {
	"sh", "-c", "/home/tim/Documents/GitHub/dotfiles/scripts/screenlayout.sh", NULL,
	"nitrogen", "--restore", NULL,
	"picom", "--experimental-backends", "--backend", "glx", NULL,
	"keepassxc", NULL,
	"discord", NULL,
	"evolution", NULL,
	"sh", "-c", "/usr/local/bin/spotify", NULL,
	"dunst", NULL,
	"nextcloud", NULL,
	"clipmenud", NULL,
	"blueman-tray", NULL,
	"nm-applet", NULL,
	"kmix", NULL,
	"slstatus", NULL,
	"polychromatic-tray-applet", NULL,
	"deja-dup", NULL,
	"steam", NULL,
	"calcurse", "--daemon", NULL,
	"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1", NULL,
	NULL /* terminate */
};

/* tagging */
static const char *tags[] = { "一", "二", "三", "四", "五", "六", "七", "八", "九" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class     	          instance    title     														  	tags mask     isfloating   monitor */
	{ "Gimp",               NULL,       NULL,                                     0,            1,           -1 },
/*{ "Firefox",            NULL,       NULL,                                     1 << 8,       0,           -1 }, */
	{ "KeePassXC",          NULL,       NULL,                                     1 << 8,       0,            0 },
	{ "discord",            NULL,       NULL,                                     1 << 7,       0,            1 },
	{ NULL,                 NULL,       "Backups",                                1 << 8,       0,            1 },
	{ "Evolution",          NULL,       NULL,                                     1 << 7,       0,            0 },
	{ "Steam",              NULL,       NULL,    								                  0,            1,           -1 },
	{ "Spotify",            NULL,       NULL,                                     1 << 6,       0,            0 },
	{ NULL,                 NULL,       "Calculator",                             0,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
	/* first entry is default */
	/* symbol     arrange function */
	{ "[]=",      tile },   
	{ "><>",      NULL },           /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
	{ "H[]",      deck },
	{ "[\\]",     dwindle },
	{ "[@]",      spiral },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
	{ "HHH",      grid },
	{ "###",      nrowgrid },
	{ "---",      horizgrid },
	{ ":::",      gaplessgrid },
	{ NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]       = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbordercolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]        = { "st", NULL };
static const char *roficmd[]        = { "rofi", "-show", "drun", NULL };
static const char *rofiswitcher[]   = { "rofi", "-show", "window", "-theme", "~/Documents/GitHub/dotfiles/rofi/current-switcher.rasi", NULL };
static const char *sysctlcmd[]      = { "sh", "-c", "/home/tim/Documents/GitHub/dotfiles/scripts/syscontrol.sh", NULL };
static const char *scrotcmd_area[]  = { "sh", "-c", "/home/tim/Documents/GitHub/dotfiles/scripts/scrot.sh area", NULL };
static const char *scrotcmd_focus[] = { "sh", "-c", "/home/tim/Documents/GitHub/dotfiles/scripts/scrot.sh focused", NULL };
static const char *clipmenucmd[]    = { "clipmenu", NULL };
static const char *audiolowercmd[]  = { "pamixer",   "-d", "5", NULL };
static const char *audioraisecmd[]  = { "pamixer",   "-i", "5", NULL };
static const char *audiomutecmd[]   = { "pamixer",   "-t", NULL };
static const char *playpausecmd[]   = { "playerctl", "play-pause", NULL };
static const char *nextsongcmd[]    = { "playerctl", "next", NULL };
static const char *prevsongcmd[]    = { "playerctl", "previous", NULL };
static const char *i3lock[]         = { "i3lock", "-B", "sigma", "--indicator", "-k", "--insidecolor=a3be8c44", "--insidevercolor=88c0d0aa", "--insidewrongcolor=fe4151ff", "--ringvercolor=88C0D0aa", "--ringcolor=a3be8caa", "--ringwrongcolor=fe4151ff", "--keyhlcolor=a3be8cff", "--bshlcolor=fe4151ff", "--wrongtext=\"BAKA!\"", "--pass-media-keys", "--pass-volume-keys", NULL };

static Key keys[] = {
	/* modifier                     key                      function        argument */
	{ 0,                            XF86XK_AudioLowerVolume, spawn,          {.v = audiolowercmd } },
	{ 0,                            XF86XK_AudioMute,        spawn,          {.v = audiomutecmd } },
	{ 0,                            XF86XK_AudioRaiseVolume, spawn,          {.v = audioraisecmd } },
	{ 0,                            XF86XK_AudioPlay,        spawn,          {.v = playpausecmd } },
	{ 0,                            XF86XK_AudioNext,        spawn,          {.v = nextsongcmd } },
	{ 0,                            XF86XK_AudioPrev,        spawn,          {.v = prevsongcmd } },
	{ 0,                            XK_Print,                spawn,          {.v = scrotcmd_area } },
	{ 0|ShiftMask,                  XK_Print,                spawn,          {.v = scrotcmd_focus } },
	{ MODKEY,                       XK_less,                 spawn,          {.v = clipmenucmd } },
	{ MODKEY,                       XK_d,                    spawn,          {.v = roficmd } },
	{ MODKEY,                       XK_Tab,                  spawn,          {.v = rofiswitcher } },
	{ 0|Mod1Mask,                   XK_Tab,                  spawn,          {.v = rofiswitcher } },
	{ MODKEY,                       XK_BackSpace,            spawn,          {.v = sysctlcmd } },
	{ MODKEY,                       XK_Return,               spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,                    togglebar,      {0} },
	{ MODKEY,                       XK_j,                    focusstackvis,  {.i = +1 } },
	{ MODKEY,                       XK_k,                    focusstackvis,  {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,                    focusstackhid,  {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,                    focusstackhid,  {.i = -1 } },
	{ MODKEY,                       XK_i,                    incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_p,                    incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,                    setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,                    setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_h,                    setcfact,       {.f = +0.25} },
	{ MODKEY|ShiftMask,             XK_l,                    setcfact,       {.f = -0.25} },
	{ MODKEY|Mod1Mask,              XK_h,                    incrgaps,       {.i = +1 } },
	{ MODKEY|Mod1Mask,              XK_l,                    incrgaps,       {.i = -1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_h,                    incrogaps,      {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_l,                    incrogaps,      {.i = -1 } },
	{ MODKEY|Mod1Mask|ControlMask,  XK_h,                    incrigaps,      {.i = +1 } },
	{ MODKEY|Mod1Mask|ControlMask,  XK_l,                    incrigaps,      {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_0,                    togglegaps,     {0} },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_0,                    defaultgaps,    {0} },
	{ MODKEY,                       XK_y,                    incrihgaps,     {.i = +1 } },
	{ MODKEY,                       XK_o,                    incrihgaps,     {.i = -1 } },
	{ MODKEY|ControlMask,           XK_y,                    incrivgaps,     {.i = +1 } },
	{ MODKEY|ControlMask,           XK_o,                    incrivgaps,     {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_y,                    incrohgaps,     {.i = +1 } },
	{ MODKEY|Mod1Mask,              XK_o,                    incrohgaps,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_y,                    incrovgaps,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_o,                    incrovgaps,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Return,               zoom,           {0} },
	{ MODKEY|ShiftMask,             XK_q,                    killclient,     {0} },
	{ MODKEY,                       XK_t,                    setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_w,                    tabmode,        {-1} },
	{ MODKEY,                       XK_f,                    setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,                    setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_u,     							 setlayout,      {.v = &layouts[3]} },
	{ MODKEY|ShiftMask,             XK_u,     							 setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_r,     							 setlayout,      {.v = &layouts[5]} },
	{ MODKEY|ControlMask,	        	XK_comma,                cyclelayout,    {.i = -1 } },
	{ MODKEY|ControlMask,           XK_period,               cyclelayout,    {.i = +1 } },
	{ MODKEY,                       XK_Up,                   show,           {0} },
	{ MODKEY,                       XK_Down,                 hide,           {0} },
	{ MODKEY,                       XK_space,                setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,                togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_f,                    togglefullscr,  {0} },
	{ MODKEY,                       XK_0,                    view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,                    tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,                focusmon,       {.i = +1 } },
	{ MODKEY,                       XK_period,               focusmon,       {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_comma,                tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_period,               tagmon,         {.i = -1 } },
	{ MODKEY,                       XK_F5,                   xrdb,           {.v = NULL } },
	TAGKEYS(                        XK_1,                                    0)
	TAGKEYS(                        XK_2,                                    1)
	TAGKEYS(                        XK_3,                                    2)
	TAGKEYS(                        XK_4,                                    3)
	TAGKEYS(                        XK_5,                                    4)
	TAGKEYS(                        XK_6,                                    5)
	TAGKEYS(                        XK_7,                                    6)
	TAGKEYS(                        XK_8,                                    7)
	TAGKEYS(                        XK_9,                                    8)
	{ MODKEY|ShiftMask,             XK_e,                    quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
//{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button1,        cyclelayout,    {.i = +1 } },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkTabBar,            0,              Button1,        focuswin,       {0} },
};

