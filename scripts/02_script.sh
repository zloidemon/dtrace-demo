#!/usr/sbin/dtrace -Zs

#pragma D option quiet

BEGIN
{
	self->start = timestamp;
	self->ts    = 0;
	printf("Start tracing....\n\n");
}

demo*:::start
{
	self->ts = timestamp;
	printf("String: %10s ", copyinstr(arg0));
}

demo*:::stop
/self->ts/
{
	printf("len: %2d time: %6d \n",
		arg0, timestamp - self->ts);
	@[arg0] = quantize((timestamp - self->ts) / 1000); /* microseconds */
	self->ts = 0;
}

END
{
	printf("Time %d.%d sec\n",
		(timestamp - self->start)/1000/1000/1000,
		(timestamp - self->start)/1000/1000/100);
}
