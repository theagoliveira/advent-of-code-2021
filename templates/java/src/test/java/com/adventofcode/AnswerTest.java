package com.adventofcode;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;

class AnswerTest {

    @Test
    public void testReadInputFile() {
        assertEquals("", Answer.readInputFile());
    }

    @Test
    public void testSplitAndConvertToIntegers() {
        assertEquals(
            new ArrayList<Integer>(List.of(1, 2, 3)), Answer.splitAndConvertToIntegers("1\n2\n3")
        );
    }

}
