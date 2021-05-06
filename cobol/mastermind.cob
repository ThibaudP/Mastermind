       IDENTIFICATION DIVISION.
       PROGRAM-ID. Mastermind.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

           1 CurrentTime.
               2 filler PIC 9(4).
               2 seed PIC 9(4).
           77 level PIC 9(1) VALUE 4.
           77 digits PIC 9(1) VALUE 6.
           77 nbTurns PIC 9(2) VALUE 12.

           77 randomNum PIC 9(1).
           77 secretCode PIC 9(4).
           77 sCode PIC x(4).

           77 turn PIC 9(2) VALUE 1.
           77 play PIC x(4).
           77 hit PIC 9(1).
           77 miss PIC 9(1).

           77 i PIC 9(1) VALUE 1.
           77 j PIC 9(1) VALUE 1.
           77 len PIC 9(1) VALUE 0.

       PROCEDURE DIVISION.

           DISPLAY " ".
           DISPLAY "Welcome to Mastermind! (COBOL version)".
           DISPLAY
               "The code is 4 digits long, chosen among 6 possible "
               "digits (1 to 6)"
           END-DISPLAY.
           DISPLAY "Can you find it in less than 12 turns?".
           DISPLAY " ".
           DISPLAY "Computing secret combination (~4 seconds)...".

      *>     Computing combination
           A0001-COMPUTE-DIGIT.
           PERFORM UNTIL i = 5
               ACCEPT CurrentTime FROM TIME
               COMPUTE randomNum = (FUNCTION RANDOM (seed) * digits) + 1
               COMPUTE secretCode = (secretCode * 10) + randomNum
               CALL "C$SLEEP" USING 1 END-CALL
               ADD 1 TO i
           END-PERFORM.

           A0001-DISPLAY-FOUND.
           DISPLAY "Combination found!".
      *>     DISPLAY secretCode.

           A0002-MAIN-LOOP.
           PERFORM UNTIL turn = nbTurns + 1
               MOVE secretCode TO sCode
               MOVE 0 TO hit
               MOVE 0 TO miss
               DISPLAY "Turn " WITH NO ADVANCING
               DISPLAY turn WITH NO ADVANCING
               DISPLAY " - Your guess?"
               ACCEPT play

      *>         Compute length of play
               MOVE 0 TO len
               INSPECT FUNCTION REVERSE(play)
               TALLYING len FOR LEADING SPACES
               COMPUTE len = LENGTH OF play - len

      *>         If play is too short or not a number, user lost
               IF len NOT = 4 OR play NOT NUMERIC
                   THEN GO TO Z0001-YOU-LOST
               END-IF

               MOVE 1 TO i
               PERFORM UNTIL i = level + 1
                   IF play(i:1) = sCode(i:1)
                       THEN ADD 1 TO hit
                           MOVE 'X' TO sCode(i:1)
                           MOVE '#' TO play(i:1)
                   END-IF
                   ADD 1 TO i
               END-PERFORM

               MOVE 1 TO i
               MOVE 1 TO j
               PERFORM UNTIL i = level + 1
                   PERFORM UNTIL j = level + 1
                       IF play(j:1) = sCode(i:1)
                           THEN ADD 1 TO miss
                               MOVE '*' TO play(j:1)
                       END-IF
                       ADD 1 TO j
                   END-PERFORM
                   ADD 1 TO i
                   MOVE 1 to j
               END-PERFORM

               IF hit = level
                   THEN DISPLAY "(ง ͡ʘ ͜ʖ ͡ʘ)ง"
                       DISPLAY " "
                       DISPLAY "You win! \o/"
                       DISPLAY " "
                   STOP RUN
               END-IF

               DISPLAY "# Right: " WITH NO ADVANCING
               DISPLAY hit WITH NO ADVANCING
               DISPLAY " - * Miss: " WITH NO ADVANCING
               DISPLAY miss

      *>     Comment next block to disable hints
               MOVE 1 to i
               PERFORM UNTIL i = level + 1
                   IF play(i:1) NOT = '#' AND play(i:1) NOT = '*'
                       THEN MOVE 'x' TO play(i:1)
                   END-IF
                   ADD 1 TO i
               END-PERFORM
               DISPLAY "Hint: " WITH NO ADVANCING
               DISPLAY play WITH NO ADVANCING
               DISPLAY " (#: Right, *: Miss, x: Wrong)"
               
               DISPLAY " "

               ADD 1 TO turn
           END-PERFORM.

           Z0001-YOU-LOST.
           DISPLAY " ".
           DISPLAY "(╯°□°)╯︵ ┻━┻".
           DISPLAY " ".
           DISPLAY "You lose!".
           DISPLAY "Answer was " WITH NO ADVANCING.
           DISPLAY secretCode.

           STOP RUN.
       END PROGRAM Mastermind.