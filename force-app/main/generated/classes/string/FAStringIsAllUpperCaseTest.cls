/*
 * Copyright (c) 2020, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
public class FAStringIsAllUpperCaseTest {
    @IsTest
    static void testPositiveScenarios() {
        String actual;
        actual = 'ABC';
        FluentAssert.that(actual).isAllUpperCase();
    }

    @IsTest
    static void testNegativeScenarios() {
        String actual;
        actual = 'abc';
        failureScenario(actual);
        actual = 'aBc';
        failureScenario(actual);
    }

    @SuppressWarnings('PMD.ApexUnitTestMethodShouldHaveIsTestAnnotation')
    private static void failureScenario(String actual) {
        try {
            FluentAssert.that(actual).isAllUpperCase();
            System.assert(false, 'No assert exception thrown');
        } catch(FluentAssert.AssertException ae) {
            // Success! Correct exception being thrown
            System.debug(LoggingLevel.INTERNAL, ae);
        } catch(Exception e) {
            System.assert(false, 'Wrong exception thrown, got: ' + e.getTypeName() + ', message: \\n' + e.getMessage());
            System.debug(LoggingLevel.ERROR, e);
        }
    }
}