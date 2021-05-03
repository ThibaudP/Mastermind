#!/usr/bin/python3
"""Simple Mastermind clone"""
from random import *


def mastermind():
    """Main logic"""
    level = 4
    digits = 6
    nbTurns = 12

    secretCode = [str(randint(1, digits)) for i in range(level)]
    turn = 1

    print("")
    print("Welcome to Mastermind! (python version)")
    print("The code is 4 digits long, chosen among 6 possible digits (1 to 6)")
    print("Can you find it in less than 12 turns?")
    print("")
    # print("".join(secretCode))

    while (turn <= nbTurns):

        play = list(input("Turn {} - Your guess:\n".format(turn)))
        code = list(secretCode)
        right = 0
        wrong = 0

        if len(play) != 4:
            player_lost(secretCode)
            return

        for i, v in enumerate(play):
            if v == code[i]:
                right += 1
                code[i] = '#'
                play[i] = '*'
        for i, v in enumerate(code):
            if v in play:
                wrong += 1
                code[i] = '*'

        if right == 4:
            return(print("\n(ง ͡ʘ ͜ʖ ͡ʘ)ง\n\nYou win! \o/\n"))

        print("Right: {} - Wrong: {}\n".format(right, wrong))

        turn += 1

    return (player_lost(secretCode))


def player_lost(code):
    """Humiliate player after he loses"""
    str = "\n(╯°□°)╯︵ ┻━┻\n\nYou lose!\nAnswer was {}".format("".join(code))
    return(print(str))


if __name__ == "__main__":
    mastermind()
