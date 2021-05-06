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
REM BwBASIC uses current time as seed for its rng, so we need to wait for
REM ~1 second for the current time to change before we request another random number
FOR I=1 TO LEVEL
    RANDOMIZE TIMER
    SECRETCODE$=SECRETCODE$+RIGHT$(STR$(INT(RND*(DIGITS)+1)), 1)
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
    MISS=0

    PRINT "Turn"+STR$(TURN)+" - Your guess:"
    INPUT PLAY$

    IF LEN(PLAY$)<LEVEL THEN
        PRINT ""
        PRINT "(╯°□°)╯︵ ┻━┻"
        PRINT ""
        PRINT "You lose!"
        PRINT "Answer was "+SECRETCODE$
        QUIT
    END IF

    FOR I=1 TO LEVEL
        IF MID$(PLAY$,I,1)=MID$(CODE$,I,1) THEN
            RIGHT=RIGHT+1
            MID$(CODE$,I,1)="X"
            MID$(PLAY$,I,1)="#"
        END IF
    NEXT

    FOR I=1 TO LEVEL
        FOR J=1 TO LEVEL
            IF MID$(PLAY$,I,1)=MID$(CODE$,J,1) THEN
                MID$(PLAY$,I,1)="*"
                MISS=MISS+1
            END IF
        NEXT
    NEXT

    IF RIGHT=LEVEL THEN
        PRINT ""
        PRINT "(ง ͡ʘ ͜ʖ ͡ʘ)ง"
        PRINT ""
        PRINT "You win! \o/"
        QUIT
    END IF

    PRINT "# Right:"+STR$(RIGHT)+" - * Miss:"+STR$(MISS)

    REM Uncomment following block to enable hints
    FOR I=1 TO LEVEL
        IF MID$(PLAY$,I,1)<>"#" AND MID$(PLAY$,I,1)<>"*" THEN
            MID$(PLAY$,I,1)="x"
        END IF
    NEXT
    PRINT "Hint: "+PLAY$+" (#: Right, *: Miss, x: Wrong)"

    PRINT ""

    TURN=TURN+1
WEND

PRINT ""
PRINT "(╯°□°)╯︵ ┻━┻"
PRINT ""
PRINT "You lose!"
PRINT "Answer was "+SECRETCODE$

QUIT