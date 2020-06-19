/* user and group to drop privileges to */
static const char *user  = "tim";
static const char *group = "wheel";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#81A1C1",   /* during input */
	[FAILED] = "#BF616A",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;
