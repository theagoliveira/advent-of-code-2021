package com.adventofcode;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
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

    public List<String> filterByCharAndIndex(List<String> list, char chr, int index) {
        return list.stream()
                   .filter(binNumber -> binNumber.charAt(index) == chr)
                   .collect(Collectors.toList());
    }

    public int indexOneCount(List<String> list, int index) {
        return (int) list.stream()
                         .map(binNumber -> binNumber.charAt(index))
                         .filter(bit -> bit == '1')
                         .count();
    }

    public int solution() {
        String[] diagnosticReport = readInputFile().split("\n");
        List<String> oxygenCandidates = new ArrayList<>(Arrays.asList(diagnosticReport));
        List<String> co2Candidates = new ArrayList<>(Arrays.asList(diagnosticReport));
        int oxygenGeneratorRating;
        int co2ScrubberRating;
        int lifeSupportRating;
        int index;

        index = 0;
        while (oxygenCandidates.size() > 1) {
            int indexOneCount = indexOneCount(oxygenCandidates, index);
            char mostCommon = indexOneCount >= oxygenCandidates.size() / 2.0 ? '1' : '0';
            oxygenCandidates = filterByCharAndIndex(oxygenCandidates, mostCommon, index++);
        }

        index = 0;
        while (co2Candidates.size() > 1) {
            int indexOneCount = indexOneCount(co2Candidates, index);
            char leastCommon = indexOneCount >= co2Candidates.size() / 2.0 ? '0' : '1';
            co2Candidates = filterByCharAndIndex(co2Candidates, leastCommon, index++);
        }

        oxygenGeneratorRating = Integer.parseInt(oxygenCandidates.get(0), 2);
        co2ScrubberRating = Integer.parseInt(co2Candidates.get(0), 2);

        lifeSupportRating = oxygenGeneratorRating * co2ScrubberRating;
        return lifeSupportRating;
    }

    public static void main(String[] args) {
        System.out.println(new Answer().solution());
    }

}
