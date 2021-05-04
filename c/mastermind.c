#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/**
 * Simple Mastermind Clone - C version
 **/

int main(void)
{
	int level = 4;
	int digits = 6;
	int nb_turns = 12;
	int turn = 1;
	int random_num;
	int i, j, right = 0, wrong = 0;
	char *code = malloc(sizeof(char) * 5);
	char *secret_code = malloc(sizeof(char) * 5);
	char *play = NULL;
	size_t buf;

	srand(time(NULL));
	for (i = 0; i < level; i++)
	{
		random_num = (rand() % digits) + 1;
		secret_code[i] = random_num + '0';
	}
	secret_code[i] = '\0';

	printf("\n");
	printf("Welcome to Mastermind! (C version)\n");
	printf("The code is 4 digits long, chosen among 6 possible digits (1 to 6)\n");
	printf("Can you find it in less than 12 turns?\n");
	printf("\n");
	/* printf("DEBUG: %s\n", secret_code); */
	printf("\n");

	while (turn <= nb_turns)
	{
		strcpy(code, secret_code);
		right = 0;
		wrong = 0;

		printf("Turn %d: Your guess:\n", turn);
		getline(&play, &buf, stdin);

		if (strlen(play) != 5)
		{
			printf("\n(╯°□°)╯︵ ┻━┻\n\nYou lose!\nAnswer was %s\n\n", secret_code);
			free(code);
			free(secret_code);
			free(play);
			return (1);
		}

		for (i = 0; i < level; i++)
		{
			if (play[i] == code[i])
			{
				right += 1;
				code[i] = '#';
				play[i] = '*';
			}
		}

		for (i = 0; i < level; i++)
		{
			for (j = 0; j < level; j++)
			{
				if (play[j] == code[i])
				{
					wrong += 1;
					code[i] = '*';
				}
			}
		}

		if (right == 4)
		{
			printf("\n(ง ͡ʘ ͜ʖ ͡ʘ)ง\n\nYou win! \\o/\n\n");
			free(code);
			free(secret_code);
			free(play);
			return (0);
		}

		printf("Right: %d - Wrong: %d\n\n", right, wrong);
		turn += 1;
	}

	printf("\n(╯°□°)╯︵ ┻━┻\n\nYou lose!\nAnswer was %s\n\n", secret_code);

	free(code);
	free(secret_code);
	free(play);
	return (1);
}
