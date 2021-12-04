package com.adventofcode;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

class AnswerTest {

    public final static String EXAMPLE = "00100\n" + "11110\n" + "10110\n" + "10111\n" + "10101\n"
            + "01111\n" + "00111\n" + "11100\n" + "10000\n" + "11001\n" + "00010\n" + "01010";

    @Test
    public void testSolution() {
        try (MockedStatic<Answer> utilities = Mockito.mockStatic(Answer.class)) {
            utilities.when(Answer::readInputFile).thenReturn(EXAMPLE);
            assertEquals(198, new Answer().solution());
        }
    }

}
