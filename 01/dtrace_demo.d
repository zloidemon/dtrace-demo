/*
 * DTrace demo provider #01
 *
 * @author Veniamin Gvozdikov <vg@FreeBSD.org>
 */

provider demo {
	probe start();
	probe stop();
};
