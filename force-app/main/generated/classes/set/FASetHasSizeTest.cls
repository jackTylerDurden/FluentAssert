/*
 * Copyright (c) 2020, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
public class FASetHasSizeTest {
    @IsTest
    static void testPositiveScenarios() {
        FluentAssert.that((Set<Object>) new Set<Object>()).hasSize(0);
        FluentAssert.that((Set<Object>) new Set<Object>()).size().isEqualTo(0);
        FluentAssert.that((Set<Object>) new Set<Object>{'X'}).hasSize(1);
        FluentAssert.that((Set<Object>) new Set<Object>{'X'}).size().isEqualTo(1);
    }

    @IsTest
    static void testNegativeScenarios() {
        try {
            FluentAssert.that((Set<Object>) new Set<Object>{'X'}).hasSize(10);
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
        validationScenario(null, 10);
        validationScenario(new Set<Object>(), null);
    }

    @SuppressWarnings('PMD.ApexUnitTestMethodShouldHaveIsTestAnnotation')
    private static void validationScenario(Set<Object> actual, Integer expected) {
        try {
            FluentAssert.that(actual).hasSize(expected);
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