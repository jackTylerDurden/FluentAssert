/*
 * Copyright (c) 2020, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
public class FADecimalIsBetweenTest {
    @IsTest
    static void testPositiveScenarios() {
        // start included, end included
        Decimal actual = 10;
        FluentAssert.that((Decimal) actual).isBetween(actual, actual);
        FluentAssert.that((Decimal) actual).isBetween(actual + -2, actual);
        FluentAssert.that((Decimal) actual).isBetween(actual, actual + 2);
        FluentAssert.that((Decimal) actual).isBetween(actual + -2, actual + 2);
    }

    @IsTest
    static void testFailureScenarios() {
        Decimal actual = 10;
        failureScenario((Decimal) (actual + -2 + -0.1), actual + -2, actual + 2);
        failureScenario((Decimal) (actual + 2 + 0.1), actual + -2, actual + 2);
    }

    @SuppressWarnings('PMD.ApexUnitTestMethodShouldHaveIsTestAnnotation')
    private static void failureScenario(Decimal actual, Decimal fromInclusive, Decimal toInclusive) {
        try {
            FluentAssert.that(actual).isBetween(fromInclusive, toInclusive);
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
    static void testValidations() {
        validationScenario(null, 10, 10);
        validationScenario(10, null, 10);
        validationScenario(10, 10, null);
        validationScenario(10, null, null);
        validationScenario(null, null, null);
    }

    @SuppressWarnings('PMD.ApexUnitTestMethodShouldHaveIsTestAnnotation')
    private static void validationScenario(Decimal actual, Decimal fromInclusive, Decimal toInclusive) {
        try {
            FluentAssert.that(actual).isBetween(fromInclusive, toInclusive);
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