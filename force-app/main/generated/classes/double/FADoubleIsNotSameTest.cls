/*
 * Copyright (c) 2020, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
public class FADoubleIsNotSameTest {
    private static final Double SELF = 10.0;
    private static final Object OTHER = 12.0;

    @IsTest
    static void testPositiveScenarios() {
        FluentAssert.that((Double) SELF).isNotSame(OTHER);
    }

    @IsTest
    static void testFailureScenarios() {
        try {
            FluentAssert.that((Double) SELF).isNotSame(SELF);
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
        validationScenario((Double) SELF, null);
        validationScenario(null, (Double) SELF);
    }

    @SuppressWarnings('PMD.ApexUnitTestMethodShouldHaveIsTestAnnotation')
    private static void validationScenario(Double actual, Object expected) {
        try {
            FluentAssert.that(actual).isNotSame(expected);
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