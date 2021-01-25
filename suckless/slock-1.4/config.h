/* user and group to drop privileges to */
static const char *user  = "tim";
static const char *group = "wheel";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#0F111A",   /* during input */
	[FAILED] = "#fe4151",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;
