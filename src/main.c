#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>

#include "serial.h"


int main(int argc,char** argv)
{
	if(argc < 2) {
		printf("Please start with /dev/ttyS1 (for example)\n");
		return 0;
	}

	unsigned char c='D';

	serial_init(argv[1]);

	while (c!='q')
	{
		if (serial_read(&c)>0)        write(STDOUT_FILENO,&c,1);              // if new data is available on the serial port, print it out
		if (read(STDIN_FILENO,&c,1)>0)  serial_write(&c);                     // if new data is available on the console, send it to the serial port

	}

	serial_exit();

	return EXIT_SUCCESS;
}
