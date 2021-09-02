<#--
  - Copyright (c) 2021, salesforce.com, inc.
  - All rights reserved.
  - SPDX-License-Identifier: BSD-3-Clause
  - For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
-->

<@pp.dropOutputFile />
<@com.apexClass className="${classPrefix}ListContainsExactlyTest" path="/classes/list/"/>
@IsTest
public class ${classPrefix}ListContainsExactlyTest {
    private static final List<String> EMPTY_LIST = new List<String>();
    private static final List<String> PART_OF_ALPHABET = new List<String>{
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'
    };

    @IsTest
    static void testPositiveScenarios() {
        FluentAssert.that(PART_OF_ALPHABET).containsExactly(new List<String>{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'});
    }

    @IsTest
    static void testNegativeScenarios() {
        failureScenario(PART_OF_ALPHABET, new List<String>{'J', 'I', 'H', 'G', 'F', 'E', 'D', 'C', 'B', 'A'});
        failureScenario(PART_OF_ALPHABET, new List<String>{'A', 'B', 'C'});
    }

    @SuppressWarnings('PMD.ApexUnitTestMethodShouldHaveIsTestAnnotation')
    private static void failureScenario(List<Object> actual, List<Object> expected) {
        try {
            FluentAssert.that(actual).containsExactly(expected);
            System.assert(false, 'No assert exception thrown');
        } catch(FluentAssert.AssertException ae) {
            // Success! Correct exception being thrown
            System.debug(LoggingLevel.INTERNAL, ae);
        } catch(Exception e) {
            System.assert(false, 'Wrong exception thrown, got: ' + e.getTypeName() + ', message: \\n' + e.getMessage());
            System.debug(LoggingLevel.ERROR, e);
        }
    }

    @IsTest
    static void testContainsExactlyValidations() {
        validationScenario(null, new List<String>{'K', 'L'});
        validationScenario(PART_OF_ALPHABET, null);

        // Empty inputs throws IllegalArgumentException
        try {
            FluentAssert.that(PART_OF_ALPHABET).containsExactly(new List<Object>());
            System.assert(false, 'No assert exception thrown');
        } catch(IllegalArgumentException iae) {
            // Success! Correct exception being thrown
            System.debug(LoggingLevel.INTERNAL, iae);
        } catch(Exception e) {
            System.assert(false, 'Wrong exception thrown, got: ' + e.getTypeName() + ', message: \\n' + e.getMessage());
            System.debug(LoggingLevel.ERROR, e);
        }
    }

    @SuppressWarnings('PMD.ApexUnitTestMethodShouldHaveIsTestAnnotation')
    private static void validationScenario(List<Object> actual, List<Object> expected) {
        try {
            FluentAssert.that(actual).containsExactly(expected);
            System.assert(false, 'No assert exception thrown');
        } catch(NullPointerException npe) {
            // Success! Correct exception being thrown
            System.debug(LoggingLevel.INTERNAL, npe);
        } catch(Exception e) {
            System.assert(false, 'Wrong exception thrown, got: ' + e.getTypeName() + ', message: \\n' + e.getMessage());
            System.debug(LoggingLevel.ERROR, e);
        }
    }
}