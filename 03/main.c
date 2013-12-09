/*
 * DTrace example #03 with USDT probes at functions
 * and structs
 *
 * @author Veniamin Gvozdikov <vg@FreeBSD.org>
 */

#include <stdio.h>
#include <unistd.h>
#include "demo_provider.h"

#if ENABLE_DTRACE
#include "dtrace_demo.h"
#else
#define	DEMO_START()
#define	DEMO_START_ENABLED() (0)
#define	DEMO_STOP(arg0)
#define	DEMO_STOP_ENABLED() (0)
#endif

/*
 * @brief Fast counter characters
 * @param string
 * @return number of symbols at line
 */
int length_fast(char *);

/*
 * @brief Slow counter characters
 * @param string
 * @return number of symbols at line
 */
int length_slow(char *);

int main(void)
{
	int counter = 0;
	int c_loop  = 0; // loop counter
	char *Lines[] = { "x", "tt", "Test", NULL };

	char *line;

	printf("%10s %4s\n", "STRING", "LEN");

	while (15 > c_loop) {
		while (NULL != Lines[counter]) {
			line = Lines[counter];
			printf("%10s: %02d\n", line, length_fast(line));
			printf("%10s: %02d\n", line, length_slow(line));
			++counter;
		}
		++c_loop; counter = 0;
		sleep(c_loop);
	}

	return 0;
}

int length_fast(char *string)
{
	dline_t	data;
	int     i;

	if (DEMO_START_ENABLED()) {
		data.mystr = string;
		DEMO_START();
	}

	for (i = 0; '\0' != *string; ++i)
		++string;

	if (DEMO_STOP_ENABLED()) {
		data.len   = i;
		DEMO_STOP(&data);
	}

	return i;
}

int length_slow(char *string)
{
	dline_t	data;
	int     i;

	if (DEMO_START_ENABLED()) {
		data.mystr = string;
		DEMO_START();
	}

	for (i = 0; '\0' != *string; ++i) {
		++string;
		usleep(i*i);
	}
	
		
	if (DEMO_STOP_ENABLED()) {
		data.len   = i;
		DEMO_STOP(&data);
	}

	return i;
}

