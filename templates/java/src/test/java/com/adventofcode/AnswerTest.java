package com.adventofcode;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

class AnswerTest {

    public final static String EXAMPLE = "";

    @Test
    public void testSolution() {
        try (MockedStatic<Answer> utilities = Mockito.mockStatic(Answer.class)) {
            utilities.when(Answer::readInputFile).thenReturn(EXAMPLE);
            assertEquals(0, new Answer().solution());
        }
    }

}
