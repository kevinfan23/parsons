// 1. Condition Test
// Using Math.random() function, create random numbers between 1 and 100 and create a simple condition that outputs whether its odd or even,

let num = Math.floor(Math.random() * 101) + 1;
console.log(oddOrEven(num));

function oddOrEven(num) {
  return num%2;
}

// 2. Loops and Maths Operators
// Loop through numbers 1 to 100 and for each of these numbers, output (console.log()) its square (ie 2 * 2 = 4).

loopNumbers(1, 100);

function loopNumbers(min, max) {
  for (let i = min; i<=max; i++) {
    console.log(Math.pow(i, 2));
    return;
  }
}

// 3. Random and while loop
// Again, using Math.random() output either 0 (heads) or 1 (tails) Then make a while loop that keeps repeating UNTIL the random function has returned 1 (tails).

let found = false;
while(!found) {
  headsOrTails() ? found = true : found = false;
  // console.log(found);
}

function headsOrTails() {
  return Math.round(Math.random()) ? 1 : 0;
}

// 4. Complex Patterns
// Using the loop approach above, create a chess board using # and space ' '. You could try using loops inside a loop to create the alternative pattern
printChessBoard();

function printChessBoard() {
  for (let i = 0; i < 8; i++) {
    var strline = "";
    for (let j = 0; j < 8; j++) {
      if (i%2) {
        j%2 ? strline += " " : strline += "#";
      }
      else {
        j%2 ? strline += "#" : strline += " ";
      }
    }
    console.log(strline);
    strline = "";
  }
}

// 5. ASCII Art
// Create ASCII Art using arrays, loops and conditions. You can choose to create generative art using standard keyboard characters (possibly usingMath.random() )or make a more precise illustration (name, face, object, symbol).

// printing a tree...or an arrow...
let rows = 6;
printLeaves(rows);

let trunkRow = 3;
printTrunk(trunkRow);

function printLeaves(height) {
  let str="";
  for (let i = 1; i <= rows -1; i++) {
      for (let j = 1; j < rows - i; j++) {
        str += " ";
      }
      let counter = i*2 - 1;
      while (counter) {
        str += "*";
        counter--;
      }
      console.log(str);
      str = "";
  }
}

function printTrunk(height) {
  for (let i = 1; i <= height; i++) {
    console.log("    *");
  }
}

// output
//     *
//    ***
//   *****
//  *******
// *********
//     *
//     *
//     *
