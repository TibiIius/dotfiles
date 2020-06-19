/* See LICENSE file for copyright and license details. */

/* needed for media keys to work */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 24;       /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Hack Nerd Font:size=12" };
static const char dmenufont[]       = "Hack Nerd Font:size=12";
static const char normbgcolor[]     = "#2e3440";
static const char normbordercolor[] = "#3b4252";
static const char normfgcolor[]     = "#d8dee9";
static const char selfgcolor[]      = "#81a1c1";
static const char selbgcolor[]      = "#3b4252";
static const char selbordercolor[]  = "#81a1c1";
static const char *colors[][3]      = {
	/*               fg             bg                border   */
	[SchemeNorm]  = { normfgcolor,  normbgcolor,      normbordercolor },
	[SchemeSel]   = { selfgcolor,   normbgcolor,       selbordercolor },
};

static const char *const autostart[] = {
	"sh", "-c", "/home/tim/Documents/GitHub/dotfiles/scripts/screenlayout.sh", NULL,
	"slstatus", NULL,
	"nitrogen", "--restore", NULL,
	"picom", "--experimental-backends", "--backend", "glx", NULL,
	"keepassxc", NULL,
	"discord", NULL,
	"spotify", NULL,
	"dunst", NULL,
	"nextcloud", NULL,
	"clipmenud", NULL,
	NULL /* terminate */
};

/* tagging */
static const char *tags[] = { " ", " ", " ", " ", " ", " ", " ", " ", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title                                    tags mask     isfloating   monitor */
	{ "Gimp",      NULL,       NULL,                                    0,            1,           -1 },
/*{ "Firefox",   NULL,       NULL,                                    1 << 8,       0,           -1 }, */
	{ "keepassxc", NULL,       NULL,                                    1 << 8,       0,           -1 },
	{ NULL,        NULL,       "Nextcloud",                             1 << 8,       0,           -1 },
	{ "discord",   NULL,       NULL,                                    1 << 7,       0,           -1 },
	{ "spotify",   NULL,       NULL,                                    1 << 6,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
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
static const char *dmenucmd[]     = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbordercolor, "-sf", normbgcolor, NULL };
static const char *termcmd[]      = { "st", NULL };
static const char *roficmd[]      = { "rofi", "-show", "drun", "-font", "Hack Nerd Font 12", NULL };
static const char *slockcmd[]     = { "slock" };
static const char *clipmenucmd[]  = { "clipmenu", NULL };
static const char *playpausecmd[] = { "playerctl", "play-pause", NULL };
static const char *nextsongcmd[]  = { "playerctl", "next", NULL };
static const char *prevsongcmd[]  = { "clipmenu", "previous", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ 0,                            XF86XK_AudioPlay,      spawn,          {.v = playpausecmd } },
	{ 0,                            XF86XK_AudioNext,      spawn,          {.v = nextsongcmd } },
	{ 0,                            XF86XK_AudioPrev,      spawn,          {.v = prevsongcmd } },
	{ MODKEY,                       XK_c,      spawn,          {.v = clipmenucmd } },
	{ MODKEY|ShiftMask,             XK_l,      spawn,          {.v = slockcmd } },
	{ MODKEY,                       XK_d,      spawn,          {.v = roficmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_p,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_e,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
