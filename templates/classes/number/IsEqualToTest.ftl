<#--
  - Copyright (c) 2021, salesforce.com, inc.
  - All rights reserved.
  - SPDX-License-Identifier: BSD-3-Clause
  - For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
-->
<#assign numberDataTypes = [
    {"nativeDataType":"Integer"},
    {"nativeDataType":"Long"},
    {"nativeDataType":"Decimal"},
    {"nativeDataType":"Double"}
]>
<@pp.dropOutputFile />
<#list numberDataTypes as numberDataType>
  <@com.apexClass className="${numberDataType.nativeDataType}IsEqualToTest" path="/classes/${numberDataType.nativeDataType?lower_case}/"/>
@IsTest
public class ${numberDataType.nativeDataType}IsEqualToTest {
    @IsTest
    static void testPassingScenarios() {
        Assert.that((${numberDataType.nativeDataType}) 0).isEqualTo(0);
    }

    @IsTest
    static void testFailureScenarios() {
        failureScenario(-1000,    0);        
        failureScenario(    0, 1000);
        failureScenario(-1000, 1000);
    }

        private static void failureScenario(${numberDataType.nativeDataType} actual, ${numberDataType.nativeDataType} expected) {
        try {
            Assert.that(actual).isEqualTo(expected);
            System.assert(false, 'No assert exception thrown');
        } catch(AssertException ae) {
            // Success! Correct exception being thrown
            System.debug(LoggingLevel.INTERNAL, ae);
        } catch(Exception e) {
            System.assert(false, 'Wrong exception thrown, got: ' + e.getTypeName() + ', message: \\n' + e.getMessage());
            System.debug(LoggingLevel.ERROR, e);
        }
    }

    @IsTest
    static void testValidations() {
        validationScenario(null, 0);
        validationScenario(0, null);
    }

        private static void validationScenario(${numberDataType.nativeDataType} actual, ${numberDataType.nativeDataType} expected) {
        try {
            Assert.that(actual).IsEqualTo(expected);
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