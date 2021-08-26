/*
 * Copyright (c) 2020, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
public class FAMapIsNotSameTest {
    private static final Map<Object, Object> SELF = new Map<Object, Object>{'X' => 'X'};
    private static final Object OTHER = new Map<Object, Object>{'Y' => 'Y'};

    @IsTest
    static void testPositiveScenarios() {
        FluentAssert.that((Map<Object, Object>) SELF).isNotSame(OTHER);
    }

    @IsTest
    static void testFailureScenarios() {
        try {
            FluentAssert.that((Map<Object, Object>) SELF).isNotSame(SELF);
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
        validationScenario((Map<Object, Object>) SELF, null);
        validationScenario(null, (Map<Object, Object>) SELF);
    }

    @SuppressWarnings('PMD.ApexUnitTestMethodShouldHaveIsTestAnnotation')
    private static void validationScenario(Map<Object, Object> actual, Object expected) {
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