#include <iostream>
#include <string>

using namespace std;

string compressing(string s);

int main (){
    string S;
    cout << "Write a string for compressing..." << endl;
    getline(cin, S);
    string comp_S = compressing(S);
    if (comp_S.length() >= S.length()) {cout << "String S doesn't need compressing..." << endl << S;} 
    else cout << comp_S;
    return 0;
}

string compressing(string s){
    if (s.empty()) return s;
    int count = 1;
    string comp_s;
    for (size_t i = 1; i <= s.length();i++) {
        if (i < s.length() && s[i] == s[i - 1])
            {count++;}
        else {
            comp_s += s[i - 1];
            comp_s += to_string(count);
            count = 1;
        }}
    return comp_s;
}