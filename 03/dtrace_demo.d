/*
 * DTrace demo provider #03
 *
 * @author Veniamin Gvozdikov <vg@FreeBSD.org>
 */

/* Necessary define before use DTrace */
typedef struct { int dummy; } dline_t;
typedef struct { int dummy; } demo_t;

provider demo {
	probe start();
	probe stop(dline_t *dp) : (demo_t *dp);
};

#pragma D attributes Evolving/Evolving/ISA	provider demo provider
#pragma D attributes Private/Private/Unknown	provider demo module
#pragma D attributes Private/Private/Unknown	provider demo function
#pragma D attributes Private/Private/ISA	provider demo name
#pragma D attributes Evolving/Evolving/ISA	provider demo args
