/*
 * serial.h
 *
 *  Created on: Mar 16, 2014
 *      Author: peter
 */

#ifndef SERIAL_H_
#define SERIAL_H_

int serial_init(const char *file);
int serial_read(unsigned char *c);
int serial_write(unsigned char *c);
void serial_exit();

#endif /* SERIAL_H_ */
