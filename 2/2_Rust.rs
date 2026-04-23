use std::io;

fn main() {
    println!("Type in your string...");
    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();
    let s = input.trim();
    if s == "" {
        println!("String is empty...");
        return;
    }
    for c in s.chars() {
        if !(c >= 'a' && c <= 'z') && c != ' ' && c != ',' && c != '!' && c != '.' && c != '\'' {
            println!("Your string contains restricted symbols...");
            return;
        }
    }
    let mut letters = [false; 26];
    for c in s.chars() {
        if c >= 'a' && c <= 'z' {
            let index = (c as usize) - ('a' as usize);
            letters[index] = true;
        }
    }
    let mut count = 0;
    for i in 0..26 {
        if letters[i] {
            count += 1;
        }
    }
    if count == 26 {
        println!("Pangram - Yes...");
    } else {
        println!("Pangram - No...");
    }
}