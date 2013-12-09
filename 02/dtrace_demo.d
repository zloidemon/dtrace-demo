/*
 * DTrace demo provider #02
 *
 * @author Veniamin Gvozdikov <vg@FreeBSD.org>
 */

provider demo {
	probe start(char *);
	probe stop(int);
};
