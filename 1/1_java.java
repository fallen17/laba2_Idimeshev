import java.util.Scanner;

class StringCompressor {
    public static String compressing(String s) {
        if (s.isEmpty()) return s;
        int count = 1;
        StringBuilder comp_s = new StringBuilder();
        for (int i = 1; i <= s.length(); i++) {
            if (i < s.length() && s.charAt(i) == s.charAt(i - 1)) {
                count++;
            } else {
                comp_s.append(s.charAt(i - 1));
                comp_s.append(count);
                count = 1;
            }
        }
        return comp_s.toString();
    }
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Write a String for compressing...");
        String S = scanner.nextLine();
        String comp_S = compressing(S);
        if (comp_S.length() >= S.length()) {
            System.out.println("String S doesn't need compressing...");
            System.out.println(S);
        } else {
            System.out.println(comp_S);
        }
        scanner.close();
    }
}