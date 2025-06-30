#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/gpio.h"

#define VERSION	"--- ANEWAND brutus V1 ---\n"


// brutus =^ BRUnnen staTUS
// Brunnen ANEWAND:
//
// ____        ____
// oooo|      |oooo
// oooo|      |oooo
// oooo|  X3  |oooo
// oooo|      |oooo
// oooo|      |oooo
// oooo|  X2  |oooo
// oooo|      |oooo
// oooo|      |oooo
// oooo|  X1  |oooo
// oooo--------oooo
// oooooooooooooooo
// oooooooooooooooo

const uint LED_PIN = 16;
const uint X3_PIN  = 11;
const uint X2_PIN  = 12;
const uint X1_PIN  = 13;


int main()
{
	char request_state;

	// define LED PIN as output
	gpio_init(LED_PIN);
	gpio_set_dir(LED_PIN, GPIO_OUT);

	// define level pins as inputs
	gpio_init(X3_PIN);
	gpio_set_dir(X3_PIN, GPIO_IN);
	gpio_init(X2_PIN);
	gpio_set_dir(X2_PIN, GPIO_IN);
	gpio_init(X1_PIN);
	gpio_set_dir(X1_PIN, GPIO_IN);


	stdio_init_all();

	printf(VERSION);

	while (1) {
		scanf("%c", &request_state);
		if (request_state == 'g') {

			// LED on while working
			gpio_put(LED_PIN, 1);

			// X3
			if (gpio_get(X3_PIN)) {
				printf("1\n");
			} else {
				printf("0\n");
			}
			// X2
			if (gpio_get(X2_PIN)) {
				printf("1\n");
			} else {
				printf("0\n");
			}
			// X1
			if (gpio_get(X1_PIN)) {
				printf("1\n");
			} else {
				printf("0\n");
			}
		}
		// LED OFF
		gpio_put(LED_PIN, 0);
	} // while
} // main
