#!/usr/bin/node
// Simple Mastermind clone in js

const mastermind = function () {
  const readline = require('readline-sync');
  const level = 4;
  const digits = 6;
  const nbTurns = 12;
  let turn = 1;
  const secretCode = [];
  let code, right, miss;

  for (let i = 0; i < level; i++) {
    const rand = String(Math.floor(Math.random() * digits) + 1);
    secretCode.push(rand);
  }

  console.log('');
  console.log('Welcome to Mastermind! (Node.js version)');
  console.log('The code is 4 digits long, chosen among 6 possible digits (1 to 6)');
  console.log('Can you find it in less than 12 turns?');
  console.log('');
  // console.log('DEBUG: ' + secretCode.join(''));

  while (turn <= nbTurns) {
    code = secretCode.slice();
    right = 0;
    miss = 0;
    let play = readline.question(`Turn ${turn} - Your guess:\n`);
    play = Array.from(play);

    if (play.length !== level) {
      console.log(`\n(╯°□°)╯︵ ┻━┻\n\nYou lose!\nAnswer was ${secretCode.join('')}\n`);
      return;
    }

    for (let i = 0; i < level; i++) {
      if (code[i] === play[i]) {
        right++;
        code[i] = 'X';
        play[i] = '#';
      }
    }

    for (let i = 0; i < level; i++) {
      for (let j = 0; j < level; j++) {
        if (play[i] === code[j]) {
          miss++;
          play[i] = '*';
        }
      }
    }

    if (right === level) {
      console.log('\n(ง ͡ʘ ͜ʖ ͡ʘ)ง\n\nYou win! \\o/\n\n');
    }

    console.log(`# Right: ${right} - * Miss: ${miss}`);
    /* Comment next block to disable hints */
    for (let i = 0; i < level; i++) {
      if (play[i] !== '#' && play[i] !== '*') {
        play[i] = 'x';
      }
    }
    console.log(`Hint: ${play.join('')} (#: Right, *: Miss, x: Wrong)\n`);

    turn++;
  }
  console.log(`\n(╯°□°)╯︵ ┻━┻\n\nYou lose!\nAnswer was ${secretCode.join('')}\n`);
};

if (require.main === module) {
  mastermind();
}
