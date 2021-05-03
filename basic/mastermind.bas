LEVEL=4
DIGITS=6
NBTURNS=12
TURN=1
SECRETCODE$=""

PRINT ""
PRINT "Welcome to Mastermind! (BwBASIC edition)"
PRINT "The code is 4 digits long, chosen among 6 possible digits (1 to 6)"
PRINT "Can you find it in less than 12 turns?"
PRINT ""

PRINT "Computing combination (should take ~5 seconds)"
FOR I=1 TO 4
    RANDOMIZE TIMER
    SECRETCODE$ = SECRETCODE$+RIGHT$(STR$(INT(RND*(DIGITS)+1)), 1)

    REM Pause for 1 second
    T = TIMER + 1
    WHILE TIMER < T
    WEND
NEXT

PRINT "Combination found!"
REM PRINT SECRETCODE$
PRINT ""

WHILE TURN <= NBTURNS
    CODE$=SECRETCODE$
    RIGHT=0
    WRONG=0

    PRINT "Turn"+STR$(TURN)+" - Your guess:"
    INPUT PLAY$

    IF LEN(PLAY$)<4 THEN
        PRINT ""
        PRINT "(╯°□°)╯︵ ┻━┻"
        PRINT ""
        PRINT "You lose!"
        PRINT "Answer was "+SECRETCODE$
        QUIT
    END IF

    REM Check all the correct characters
    FOR I=1 TO 4
        IF MID$(PLAY$,I,1)=MID$(CODE$,I,1) THEN
            RIGHT=RIGHT+1
            MID$(PLAY$,I,1) = "#"
            MID$(CODE$,I,1) = "*"
        END IF
    NEXT

    REM Check the wrong characters
    FOR I=1 TO 4
        FOR J=1 TO 4
            IF MID$(PLAY$,J,1)=MID$(CODE$,I,1) THEN
                WRONG=WRONG+1
                MID$(CODE$,I,1) = "*"
            END IF
        NEXT
    NEXT

    IF RIGHT=4 THEN
        PRINT ""
        PRINT "(ง ͡ʘ ͜ʖ ͡ʘ)ง"
        PRINT ""
        PRINT "You win! \o/"
        QUIT
    END IF

    PRINT "Right:"+STR$(RIGHT)+" - Wrong:"+STR$(WRONG)
    PRINT ""

    TURN=TURN+1
WEND

PRINT ""
PRINT "(╯°□°)╯︵ ┻━┻"
PRINT ""
PRINT "You lose!"
PRINT "Answer was "+SECRETCODE$

QUIT