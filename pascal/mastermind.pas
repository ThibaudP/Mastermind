program Mastermind;
uses crt, sysutils, BaseUnix;

var
level : integer = 4;
Digits : integer = 6;
NbTurns : integer = 12;
Turn : integer = 1;
SecretCode : string = '';
Code : string;
Play : string;

i, j : integer;
Hit, Miss : integer;

begin
    randomize();
    for i := 1 to level do SecretCode += IntToStr(Random(Digits) + 1);

    Writeln;
    Writeln('Welcome to Mastermind! (Pascal version)');
    Writeln('The code is 4 digits long, chosen among 6 possible digits (1 to 6)');
	Writeln('Can you find it in less than 12 turns?');
    Writeln;
    // Writeln('DEBUG: ' + SecretCode);


    while Turn <= NbTurns do
    begin
        Code := SecretCode;
        Hit := 0;
        Miss := 0;

        Writeln('Turn ' + IntToStr(Turn) + ' - Your guess:');
        Readln(Play);

        if Length(Play) <> level then
        begin
            Writeln;
            Writeln('"(╯°□°)╯︵ ┻━┻');
            Writeln;
            Writeln('You lose!');
            Writeln('Answer was ' + SecretCode);
            Writeln;
            Halt(1);
        end;

        for i := 1 to level do
        begin
            if Play[i] = Code[i] then
            begin
                Hit += 1;
                Code[i] := 'X';
                Play[i] := '#';
            end;
        end;

        for i := 1 to level do
        begin
            for j := 1 to level do
            begin
                if Play[i] = Code[j] then
                begin
                    Miss += 1;
                    Play[i] := '*';
                end;
            end;
        end;

        if Hit = 4 then
        begin
            Writeln;
            Writeln('(ง ͡ʘ ͜ʖ ͡ʘ)ง');
            Writeln;
            Writeln('You win! \o/');
            Halt(1);
        end;

        Writeln('# Right: ' + IntToStr(Hit) + ' - * Miss: ' + IntToStr(Miss));

        // Comment next block to disable hints
        for i := 1 to level do
            if (Play[i] <> '#') and (Play[i] <> '*') then Play[i] := 'x';
        Writeln('Hint: ' + Play + ' (#: Right, *: Miss, x: Wrong)');
        
        Writeln;

        Turn += 1;
    end;

    Writeln;
    Writeln('"(╯°□°)╯︵ ┻━┻');
    Writeln;
    Writeln('You lose!');
    Writeln('Answer was ' + SecretCode);
    Writeln;
end.
