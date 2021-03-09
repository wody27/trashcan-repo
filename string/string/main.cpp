//
//  main.cpp
//  string
//
//  Created by 이재용 on 2021/03/09.
//

#include <string>
#include <vector>
#include <map>

using namespace std;


string solution(vector<string> participant, vector<string> completion) {
    string answer = "";
    
    map<string,bool> m;
    
    for (int i = 0; i < participant.size(); i++) {
        m.insert(make_pair(participant[i], false));
    }
    
    for (int i = 0; i < completion.size(); i++) {
        m[completion[i]] = true;
    }
    
    for (map<string,bool>::iterator it = m.begin(); it != m.end(); it++) {
        if (it->second == false) {
            answer = it->first;
            break;
        }
    }
    
    return answer;
}

int main() {
    
    
//    string str1 = "1234";
//    string str2 = "BlogBlogBlogBlog";
//
//    int a = str1.at(0);
//    cout << a;
//
//    cout << "\n\n";
//
//    // string 인자 접근 관련
//    cout << str1.at(0) << " ";
//    cout << str1.front() << " ";
//    cout << str1.back() << " ";
//    cout << endl;
//
//    cout << str1.size() << " ";
//    cout << str1.length() << " ";
//    str1.resize(15, '!');
//    cout << str1 << "\n";
//
//    str1.replace(5, 2, str2);
//    cout << str1 << " ";
    
//    for (string::iterator iter = str1.begin(); iter != str1.end(); iter++) {
//        cout << *iter << endl;
//    }
    
    return 0;
}

