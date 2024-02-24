/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>
/* appearance */
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int snap      = 8;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
//static const char *fonts[]          = { "SauceCodePro Nerd Font:size=9" };
//static const char dmenufont[]       = "SauceCodePro Nerd Font:size=9";
static const char *fonts[]          = { "monospace:style=Medium:pixelsize=14:antialias=true:autohint=true" };
static const char dmenufont[]       = "monospace:style=Medium:pixelsize=14:antialias=true:autohint=true";


/* Tokyonight_night theme colours from https://github.com/folke/tokyonight.nvim */
static const char col_gray1[]       = "#1A1B26";
static const char col_gray2[]       = "#16161E";
static const char col_gray3[]       = "#B4D0E9";
static const char col_gray4[]       = "#B4D0E9";
static const char col_cyan[]        = "#16161E";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	// { "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[M]",      monocle }, /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[]=",      tile },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
// #define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define SHCMD(cmd) { .v = (const char*[]){ "/usr/local/bin/st", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };
// This is my setting for `pulseaudio`, you can refer the link below
// https://www.reddit.com/r/suckless/comments/c64pv8/controlling_audiobacklight_through_keys_in_dwm/es69te5/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
// for more info about amixer
static const char *mutecmd[] = { "pactl", "set-sink-mute", "0", "toggle", NULL };
// `volume` & `brightness` executables are my shell commands, found in dotfiles repo
static const char *volupcmd[] = { "pactl", "set-sink-volume", "0", "+1%", NULL };
static const char *voldowncmd[] = { "pactl", "set-sink-volume", "0", "-1%", NULL };
// Note: For the brightness command to work, you need to add the following to `/etc/sudoers` file
// `$username ALL=(ALL) NOPASSWD: /path/to/brightness`
// where username should be your username where you are setting dwm up, and you have the path to brightness present in `~/.local/bin/` in my dotfiles
static const char *brupcmd[] = { "sudo", "brightness", "i", "2", NULL };
static const char *brdowncmd[] = { "sudo", "brightness", "d", "2", NULL };
// add the path to the screenshot folder in the 2nd argument for screenshots using `scrot` program
// also, replace 'Gamer247' with your username
static const char *prtscfullcmd[] = { "scrot", "-q", "100", "/home/Gamer247/screenshots/%m-%d-%Y-%H%M%S_$wx$h.png", NULL };
static const char *prtscselectcmd[] = { "scrot", "-q", "100", "-s", "/home/Gamer247/screenshots/%m-%d-%Y-%H%M%S_$wx$h.png", NULL };

static const Key keys[] = {
  // default key bindings
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,       quit,          {0} },
  // custom key bindings

  // media keys bindings
  { 0,            XF86XK_AudioMute,           spawn,         {.v = mutecmd } },
  { 0,            XF86XK_AudioLowerVolume,    spawn,         {.v = voldowncmd } },
  { 0,            XF86XK_AudioRaiseVolume,    spawn,         {.v = volupcmd } },
  { 0,            XF86XK_MonBrightnessUp,     spawn,         {.v = brupcmd} },
  { 0,            XF86XK_MonBrightnessDown,   spawn,         {.v = brdowncmd} },
  // screenshot bindings
  { MODKEY,                     XK_Print,     spawn,         {.v = prtscfullcmd} },
  { MODKEY|ShiftMask,           XK_Print,     spawn,         {.v = prtscselectcmd} },
};
/* button definitions */ /* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
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
