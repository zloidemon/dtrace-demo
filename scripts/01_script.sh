#!/usr/sbin/dtrace -Zs

#pragma D option quiet

demo*:::start
{
	self->ts = timestamp;
}

demo*:::stop
{
	printf("time: %d\n", timestamp - self->ts);
	self->ts = 0;
}
