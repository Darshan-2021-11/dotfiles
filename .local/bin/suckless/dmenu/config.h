/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 0;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	// "monospace:size=10"
  "SauceCodePro Nerd Font Mono:pixelsize=10:antialias=true:autohint=true"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	// [SchemeNorm] = { "#bbbbbb", "#222222" },
	// [SchemeSel] = { "#eeeeee", "#005577" },
	// [SchemeOut] = { "#000000", "#00ffff" },
	[SchemeNorm] = { "#B4D0E9", "#011628" },
	[SchemeSel] = { "#CBE0F0", "#0A64AC" },
	[SchemeOut] = { "#011628", "#275378" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
