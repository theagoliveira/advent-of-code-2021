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
        String[] diagnosticReport = readInputFile().split("\n");
        int numberSize = diagnosticReport[0].length();
        int gammaRate = 0;
        int epsilonRate;
        int powerConsumption;

        for (int i = 0; i < numberSize; i++) {
            int indexOneCount = 0;

            for (String binNumber : diagnosticReport) {
                indexOneCount += binNumber.charAt(i) - '0';
            }

            gammaRate <<= 1;
            if (indexOneCount > diagnosticReport.length / 2.0) {
                gammaRate++;
            }
        }

        epsilonRate = gammaRate ^ ((int) Math.pow(2, numberSize) - 1);
        powerConsumption = gammaRate * epsilonRate;
        return powerConsumption;
    }

    public static void main(String[] args) {
        System.out.println(new Answer().solution());
    }

}
