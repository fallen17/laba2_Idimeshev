const readlineSync = require('readline-sync');

function all_digs_the_same(number) {
    if (number < 10) return false;
    
    const firstDig = number % 10;
    let num = number;
    
    while (num > 0) {
        if (num % 10 !== firstDig) return false;
        num = Math.floor(num / 10);
    }
    return true;
}

function do_check_numb(amountN) {
    const numbers = [];
    
    console.log(`Enter ${amountN} numbers:`);
    
    for (let i = 0; i < amountN; i++) {
        const tempItem = readlineSync.questionInt();
        numbers.push(tempItem);
    }
    
    let result = '';
    for (let item of numbers) {
        if (all_digs_the_same(item)) {
            result += item + ' ';
        }
    }
    
    console.log(result.trim());
}

function main() {
    console.log("Type in N amount of numbers... And then write numbers...");
    const amountNumb = readlineSync.questionInt();
    
    if (amountNumb < 1) {
        console.log("N can't be less than 1...");
        return;
    }
    
    do_check_numb(amountNumb);
}

main();