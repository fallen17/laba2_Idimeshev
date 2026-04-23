#include <iostream>
#include <string>
#include <set>

using namespace std;

int check_str(const string &S);
bool check_allowedSymb(const string &S);

int main(){
	string S;
	cout << "Type in your string... " << endl;
	getline(cin, S);
	if (S.empty()) {cout << "String is empty... " << endl; return 0; }
	if (!check_allowedSymb(S))
	 {cout << "Your string contains restricted symbols..." << endl;
	 return 0;}
	cout << ( (check_str(S) == 26) ? "Pangram - Yes..." : "Pangram - No...") << endl;
	return 0;
}

int check_str(const string &S){
	set<char> pangram = {};
	for (char a : S){
		if (a >= 'a' && a <= 'z')
			{pangram.insert(a);}
		else continue;
	}
	return pangram.size();
}

bool check_allowedSymb(const string &S){
	for (char a : S){
		bool allowedSymbs = (a >= 'a' && a <= 'z') || a == ' ' || a == ','
		|| a == '!' || a == '.' || a == '\'';
		if (!allowedSymbs) {return false;}
	}
	return true;
}