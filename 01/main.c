/*
 * DTrace example #02 with USDT probes at main
 *
 * @author Veniamin Gvozdikov <vg@FreeBSD.org>
 */

#include <stdio.h>
#include <unistd.h>

#if ENABLE_DTRACE
#include "dtrace_demo.h"
#else
#define	DEMO_START()
#define	DEMO_START_ENABLED() (0)
#define	DEMO_STOP()
#define	DEMO_STOP_ENABLED() (0)
#endif

int main(void)
{
	int counter = 0;
	int i = 0;

	char *Lines[] = { "x", "tt", "Test", NULL };

	char *line;

	printf("%10s %4s\n", "STRING", "LEN");

	while (1) {
		if (DEMO_START_ENABLED())
			DEMO_START();
		while (NULL != Lines[counter]) {
			line = Lines[counter];
			printf("%10s: ", line);
			for (i = 0; '\0' != *line; ++i) {
				++line;
			}
			printf("%02d\n", i);
			++counter;
		}
		counter = 0;
		sleep(1);
		if (DEMO_STOP_ENABLED())
			DEMO_STOP();
	}
	return 0;
}

