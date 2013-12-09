/*
 * DTrace library for translating arguments from the demo provider
 *
 * @author Veniamin Gvozdikov <vg@FreeBSD.org>
 */

/*
 * Structure from demo application and tronsform to dline_t
 */
typedef struct {
	char  *mystr; /* string */
	int    len;   /* length */
} dline_t;

/*
 * Structure with data from dline_t
 */
typedef struct {
	string str;
	int    len;
} demo_t;

/*
 * Translator from dline_t to demo_t
 */
#pragma D binding "1.7" translator
translator demo_t < dline_t *p >
{
	str = copyinstr(*(uintptr_t *)copyin(
		(uintptr_t)&p->mystr, sizeof (char*)));
	len = *(uint64_t *)copyin((uintptr_t)&p->len,
		sizeof (p->len));
};
