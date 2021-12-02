package com.adventofcode;

import java.io.FileInputStream;
import java.io.IOException;

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

    public int solution() {
        String[] commands = readInputFile().split("\n");

        int depth = 0;
        int horizontal = 0;

        for (String command : commands) {
            String[] commandArray = command.split(" ");
            String word = commandArray[0];
            int number = Integer.parseInt(commandArray[1]);

            switch (word) {
                case "down":
                    depth += number;
                    break;

                case "up":
                    depth -= number;
                    break;

                case "forward":
                    horizontal += number;
                    break;

                default:
                    break;
            }
        }

        return depth * horizontal;
    }

    public static void main(String[] args) {
        System.out.println(new Answer().solution());
    }

}
