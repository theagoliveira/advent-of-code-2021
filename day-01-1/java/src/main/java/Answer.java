import java.io.FileInputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

class Answer {

    public static void main(String[] args) {
        StringBuilder rawInput = new StringBuilder();
        int result = 0;
        int readVar;

        try (FileInputStream fileInput = new FileInputStream("./input.txt")) {
            do {
                readVar = fileInput.read();
                if (readVar != -1) {
                    rawInput.append((char) readVar);
                }
            } while (readVar != -1);
        } catch (IOException e) {
            System.out.println("I/O Error: " + e);
            return;
        }

        List<Integer> inputArray = Arrays.stream(rawInput.toString().split("\n"))
                                         .map(Integer::valueOf)
                                         .collect(Collectors.toList());

        for (int i = 1; i < inputArray.size(); i++) {
            if (inputArray.get(i) > inputArray.get(i - 1)) {
                result++;
            }
        }

        System.out.println(result);
    }

}
