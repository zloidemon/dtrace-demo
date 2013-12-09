#!/usr/sbin/dtrace -s

#pragma D option quiet

pid$target::length_*:entry
{
	self->ts = timestamp;
	printf("String: %s\n", copyinstr(arg0));
}

pid$target::length_*:return
/self->ts/
{
	@num[probefunc] = count();
	@sum[probefunc] = sum(timestamp - self->ts);
	@q[probefunc]    = quantize(timestamp - self->ts);

	self->ts = 0;
}

profile:::tick-10sec
{
	exit(0);
}

END
{
	printf("Count of call functions:\n");
	printa(@num);
	printf("Time of call functions:\n");
	printa(@sum);
	printf("Distribution of times by functions:\n");
	printa(@q);
}
