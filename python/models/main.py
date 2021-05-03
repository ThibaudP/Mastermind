#!/usr/bin/python3
"""Simple Mastermind clone"""
from random import *


def mastermind():
    """Main logic"""
    level = 4
    digits = 6
    nbTurns = 12

    code = [str(randint(1, digits)) for i in range(level)]
    turn = 0

    print("")
    print("Welcome to Mastermind! (python version)")
    print("The code is 4 digits long, chosen among 6 possible digits (1 to 6)")
    print("Can you find it in less than 12 turns?")
    print("")
    # print("".join(code))

    while (turn < nbTurns):
        play = list(input("Turn {} - Your guess : ".format(turn)))
        if len(play) != 4:
            player_lost(code)
            return
        right = 0
        wrong = 0
        for i, v in enumerate(play):
            if v == code[i]:
                right += 1
        wrong = level - right
        if right == 4:
            return(print("\n(ง ͡ʘ ͜ʖ ͡ʘ)ง\n\nYou win! \o/\n"))

        print("Right: {} - Wrong : {}".format(right, wrong))

        turn += 1

    return (player_lost(code))


def player_lost(code):
    """Humiliate player after he loses"""
    str = "\n(╯°□°)╯︵ ┻━┻\n\nYou lose!\nAnswer was {}".format("".join(code))
    return(print(str))


if __name__ == "__main__":
    mastermind()
