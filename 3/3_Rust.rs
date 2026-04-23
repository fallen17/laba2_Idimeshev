use std::io;

fn all_digs_the_same(mut number: i32) -> bool {//ф-я bool для проверки цифр числа
    if number < 10 {//отметаем отриц. и однозначные числа
        return false;//завершаемся в случае отказа
    }
    let first_dig = number % 10;//вводим цифру
    while number > 0 {//пилим число до конца
        if number % 10 != first_dig {//проверяем подходимость
            return false;
        }
        number /= 10;//продвигаемся дальше, убирая самый младший разряд
    }
    true
}

fn do_check_numb(amount_n: i32) {//ф-я для проверки чисел, ввода и вывода
    let mut numbers = Vec::new();//объявляем вектор и выделяем ему дин.память
    for _ in 0..amount_n {//цикл для записи чисел в вектор
        let mut input = String::new();//объявляем строку для числа
        io::stdin().read_line(&mut input).unwrap();//вводим число
        let temp_item: i32 = input.trim().parse().unwrap();//объявляем и инициализируем число, обрабатываем
        numbers.push(temp_item);//вносим число в вектор
    }
    for item in numbers {
        if all_digs_the_same(item) {
            print!("{} ", item);
        }
    }
    println!();
}

fn main() {
    println!("Type in N amount of numbers... And then write numbers...");
    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();
    let amount_n: i32 = input.trim().parse().unwrap();
    if amount_n < 1 {
        println!("N can't be less than 1...");
        return;
    }
    do_check_numb(amount_n);
}