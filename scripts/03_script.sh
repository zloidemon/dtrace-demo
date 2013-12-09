#!/usr/sbin/dtrace -sZ

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
}

demo*:::stop
/self->ts/
{
	printf("String: %10s len: %2d time: %6d\n",
		args[0]->str, args[0]->len, timestamp - self->ts);
	@[arg0] = quantize((timestamp - self->ts) / 1000); /* microseconds */
	self->ts = 0;
}

END
{
	printf("Time %d.%d sec\n",
		(timestamp - self->start)/1000/1000/1000,
		(timestamp - self->start)/1000/1000/100);
}
