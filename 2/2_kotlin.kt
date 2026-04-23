fun main() {
    println("Type in your string...")
    val S = readLine() ?: ""
    if (S.isBlank()) {
        println("String is empty...")
        return
    }
    if (!checkAllowedSymb(S)) {
        println("Your string contains restricted symbols...")
        return
    }
    println(if (checkStr(S) == 26) "Pangram - Yes..." else "Pangram - No...")
}

fun checkStr(S: String): Int {
    val pangram = mutableSetOf<Char>()
    for (a in S) {
        if (a in 'a'..'z') {
            pangram.add(a)
        }
    }
    return pangram.size
}

fun checkAllowedSymb(S: String): Boolean {
    for (a in S) {
        val allowedSymbs = a in 'a'..'z' || 
                           a == ' ' || 
                           a == ',' || 
                           a == '!' || 
                           a == '.' || 
                           a == '\''
        if (!allowedSymbs) {
            return false
        }
    }
    return true
}