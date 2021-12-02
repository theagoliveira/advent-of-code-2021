package com.adventofcode;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

class AnswerTest {

    public final static String EXAMPLE = "forward 5\ndown 5\nforward 8\nup 3\ndown 8\nforward 2";

    @Test
    public void testSolution() {
        try (MockedStatic<Answer> utilities = Mockito.mockStatic(Answer.class)) {
            utilities.when(Answer::readInputFile).thenReturn(EXAMPLE);
            assertEquals(900, new Answer().solution());
        }
    }

}
