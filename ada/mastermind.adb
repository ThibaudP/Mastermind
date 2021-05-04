with Ada.Text_IO; use Ada.Text_IO;
-- with Ada.Strings.Maps; use Ada.Strings.Maps;
with Ada.Numerics.discrete_random;

procedure Mastermind is
    package IO renames Ada.Text_IO;

    -- Init for the RNG.
    -- Declare a new range type (this is where we select how many digits to choose from)
    -- and call discrete_random as Rand_Int for that range.
    type RandRange is range 1..6;
    package Rand_Int is new Ada.Numerics.discrete_random(RandRange);
    use Rand_Int;
    gen: Generator;
    RandNum: RandRange;

    NbTurns: Integer := 12;
    Turn: Integer := 1;
    -- Strings have a fixed length in Ada.
    SecretCode: String := "0000";
    Code: String(1..4);
    InputPlay: String := "00000";
    Play: String(1..4);
    Last: Integer;
    Right: Integer := 0;
    Miss: Integer := 0;
    I: Natural;
    J: Natural := 1;
begin
    -- Reset the RNG
    reset(gen);

    New_Line;
    Put_Line("Welcome to Mastermind! (Ada version)");
    Put_Line("The code is 4 digits long, chosen among 6 possible digits (1 to 6)");
    Put_Line("Can you find it in less than 12 turns?");
    New_Line;

    -- Select 4 random numbers and slot them in each char of SecretCode
    I := 1;
    while I <= 4 loop
        RandNum := random(gen);
        -- Put_Line(randRange'Image(RandNum));
        SecretCode(I) := Character'Val(RandNum + 48);
        I := I + 1;
    end loop;
    SecretCode := "3123";
    Put_Line("Code: " & SecretCode);

    while Turn <= NbTurns loop
        -- Set all variables back to default
        Code := SecretCode;
        Right := 0;
        Miss := 0;
        -- Weird thing happens when you input the exact number of chars, so adding one
        -- for good measure (loop jumps twice if you enter 4 chars into a 4 char string. No idea why.)
        InputPlay := "00000";


        -- Print prompt and ask for player's guess
        Put_Line("Turn" & Integer'Image(Turn) & " - Your guess: ");
        Get_Line(InputPlay, Last);

        -- Set 4 beginning chars of InputPlay as Play
        Play := InputPlay(1..4);
        

        -- Check if player input is at least 4 characters long, game lost if not
        I := 1;
        while I <= 4 loop
            if Play(I) = '0' then
                New_Line;
                Put_Line("(╯°□°)╯︵ ┻━┻");
                New_Line;
                Put_Line("You lose!");
                Put_Line("Answer was " & SecretCode);
                return;
            end if;
            I := I + 1;
        end loop;

        for I in 1..4 loop
            if Play(I) = Code(I) then
                Right := Right + 1;
                Code(I) := '#';
                Play(I) := 'X';
            end if;
        end loop;

        for I in 1..4 loop
            for J in 1..4 loop
                if Play(J) = Code(I) then
                    Miss := Miss + 1;
                    Code(I) := '*';
                end if;
            end loop;
        end loop;


        if Right = 4 then
            New_Line;
            Put_Line("(ง ͡ʘ ͜ʖ ͡ʘ)ง");
            New_Line;
            Put_Line("You win! \o/");
            return;
        end if;

        Put_Line("Right:" & Integer'Image(Right) & " - Miss:" & Integer'Image(Miss));
        -- Commment next block to disable hints
        for I in 1..4 loop
            if Code(I) /= '#' then
                if Code(I) /= '*' then
                    Code(I) := 'x';
                end if;
            end if;
        end loop;
        Put_Line("Hint: "& Code &" (#: Right, *: Miss, x: Wrong)");

        New_Line;

        -- Put_Line("Your guess: " & Play);
        Turn := Turn + 1;

    end loop;

    New_Line;
    Put_Line("(╯°□°)╯︵ ┻━┻");
    New_Line;
    Put_Line("You lose!");
    Put_Line("Answer was " & SecretCode);
end Mastermind;
