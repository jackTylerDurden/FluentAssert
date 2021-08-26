<#--
  - Copyright (c) 2021, salesforce.com, inc.
  - All rights reserved.
  - SPDX-License-Identifier: BSD-3-Clause
  - For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
-->
<#import "../../common/apex-class.ftl" as com>

<#assign numberDataTypes = [
    {"type": "List<Object>",        "emptyValue": "new List<Object>()",         "nonEmptyValue": "new List<Object>{'X'}"},
    {"type": "Set<Object>",         "emptyValue": "new Set<Object>()",          "nonEmptyValue": "new Set<Object>{'X'}"},
    {"type": "Map<Object, Object>", "emptyValue": "new Map<Object, Object>()",  "nonEmptyValue": "new Map<Object, Object>{'X' => 'X'}"},
    {"type": "Blob",                "emptyValue": "Blob.valueOf('')",           "nonEmptyValue": "Blob.valueOf('X')"}
]>
<@pp.dropOutputFile />
<#list numberDataTypes as numberDataType>
  <@com.apexClass className="${classPrefix}${numberDataType.type?keep_before('<')}HasSizeTest" path="/classes/${numberDataType.type?lower_case?keep_before('<')}/"/>
@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
public class ${classPrefix}${numberDataType.type?keep_before('<')}HasSizeTest {
    @IsTest
    static void testPositiveScenarios() {
        FluentAssert.that((${numberDataType.type}) ${numberDataType.emptyValue}).hasSize(0);
        FluentAssert.that((${numberDataType.type}) ${numberDataType.emptyValue}).size().isEqualTo(0);
        FluentAssert.that((${numberDataType.type}) ${numberDataType.nonEmptyValue}).hasSize(1);
        FluentAssert.that((${numberDataType.type}) ${numberDataType.nonEmptyValue}).size().isEqualTo(1);
    }

    @IsTest
    static void testNegativeScenarios() {
        try {
            FluentAssert.that((${numberDataType.type}) ${numberDataType.nonEmptyValue}).hasSize(10);
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
        validationScenario(${numberDataType.emptyValue}, null);
    }

    @SuppressWarnings('PMD.ApexUnitTestMethodShouldHaveIsTestAnnotation')
    private static void validationScenario(${numberDataType.type} actual, Integer expected) {
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
</#list>