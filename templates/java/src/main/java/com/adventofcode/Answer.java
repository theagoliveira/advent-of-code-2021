package com.adventofcode;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

class Answer {

    public static String readInputFile() {
        StringBuilder strBuilder = new StringBuilder();
        int readVar;

        try (FileInputStream fileInput = new FileInputStream("input.txt")) {
            do {
                readVar = fileInput.read();
                if (readVar != -1) {
                    strBuilder.append((char) readVar);
                }
            } while (readVar != -1);
        } catch (IOException e) {
            System.out.println("I/O Error: " + e);
            return "";
        }

        return strBuilder.toString();
    }

    public static List<Integer> splitAndConvertToIntegers(String data) {
        return Arrays.stream(data.split("\n")).map(Integer::valueOf).collect(Collectors.toList());
    }

    public int solution() {
        String[] data = readInputFile().split("\n");
        int result = 0;

        // CODE

        return result;
    }

    public static void main(String[] args) {
        System.out.println(new Answer().solution());
    }

}
