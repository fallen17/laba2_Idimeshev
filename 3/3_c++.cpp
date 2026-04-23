#include <iostream>
#include <vector>
#include <cstdlib>
using namespace std;

bool all_digs_the_same(int number) {
    if (number < 10) return false;
    int firstDig = number % 10;
    
    while (number > 0) {
        if (number % 10 != firstDig) return false;
        number /= 10;
    }
    return true;
}

int do_check_numb(int amountN){
    vector<int> numbers;

    for (int i = 0; i < amountN;i++){
        int tempItem;
        cin >> tempItem;
        numbers.push_back(tempItem);
    }
    for (int item : numbers){
        if (all_digs_the_same(item)) cout << item << " ";
}
    return 0;
}

int main (){
    int amountNumb;

    cout << "Type in N amount of numbers... And then write numbers..." << endl;
    cin >> amountNumb;
    if (amountNumb < 1)
        {cout << "N can't be less than 1..." << endl; return 0;}
    do_check_numb(amountNumb);
    return 0;
}