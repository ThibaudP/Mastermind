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
        miss = 0

        if len(play) != 4:
            player_lost(secretCode)
            return

        for i, v in enumerate(play):
            if v == code[i]:
                right += 1
                code[i] = 'X'
                play[i] = '#'
        for i, v in enumerate(play):
            if v in code:
                miss += 1
                play[i] = '*'

        if right == level:
            return(print("\n(ง ͡ʘ ͜ʖ ͡ʘ)ง\n\nYou win! \o/\n"))

        print("# Right: {} - * Miss: {}".format(right, miss))
        
        # Uncomment the next 5 lines to enable hints
        for i, v in enumerate(play):
            if '1' <= play[i] <= str(digits):
                play[i] = 'x'
        
        print("Hint: {} (#: Right, *: Miss, x: Wrong)".format("".join(play)))
        print("")

        turn += 1

    return (player_lost(secretCode))


def player_lost(code):
    """Humiliate player after he loses"""
    str = "\n(╯°□°)╯︵ ┻━┻\n\nYou lose!\nAnswer was {}".format("".join(code))
    return(print(str))


if __name__ == "__main__":
    mastermind()
