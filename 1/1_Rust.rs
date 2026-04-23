use std::io;

fn compressing(s: &str) -> String {
    if s.is_empty() {
        return s.to_string();
    }
    
    let chars: Vec<char> = s.chars().collect();
    let mut count = 1;
    let mut comp_s = String::new();
    
    for i in 1..=chars.len() {
        if i < chars.len() && chars[i] == chars[i - 1] {
            count += 1;
        } else {
            comp_s.push(chars[i - 1]);
            comp_s.push_str(&count.to_string());
            count = 1;
        }
    }
    
    comp_s
}

fn main() {
    println!("Write a String for compressing...");
    let mut s = String::new();
    io::stdin()
        .read_line(&mut s)
        .expect("Failed to read line...");
    s = s.trim().to_string();
    
    let comp_s = compressing(&s);
    
    if comp_s.len() >= s.len() {
        println!("String S doesn't need compressing...");
        println!("{}", s);
    } else {
        println!("{}", comp_s);
    }
}