<#--
  - Copyright (c) 2021, salesforce.com, inc.
  - All rights reserved.
  - SPDX-License-Identifier: BSD-3-Clause
  - For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
-->
<#assign dataTypes = [
    {"native":"Object",   "concreteValue": "'X'",                          "notEqualToValue":"'Y'"},
    {"native":"Date",     "concreteValue": "Date.today()",                 "notEqualToValue":"Date.today().addDays(1)"},
    {"native":"Datetime", "concreteValue": "Datetime.now()",               "notEqualToValue":"Datetime.now().addDays(1)"},
    {"native":"Time",     "concreteValue": "Time.newInstance(1, 2, 3, 4)", "notEqualToValue":"Time.newInstance(1, 2, 3, 4).addMilliseconds(1)"},
    {"native":"String",   "concreteValue": "'X'",                          "notEqualToValue":"'Y'"},
    {"native":"Blob",     "concreteValue": "Blob.valueOf('X')",            "notEqualToValue":"Blob.valueOf('Y')"},
    {"native":"SObject",  "concreteValue": "new Account(Name = 'X')",      "notEqualToValue":"new Account(Name = 'Y')"},
    {"native":"Exception","concreteValue": "new UnexpectedException('X')", "notEqualToValue":"new UnexpectedException('Y')"}
]>
<@pp.dropOutputFile />
<#list dataTypes as dataType>
<@com.apexClass className="${dataType.native}IsEqualToTest" path="/classes/${dataType.native?lower_case}/"/>
@IsTest
public class ${dataType.native}IsEqualToTest {
    @IsTest
    static void testPassingScenarios() {
        ${dataType.native} value = ${dataType.concreteValue};
        Assert.that(value).isEqualTo(value);
    }

    @IsTest
    static void testFailureScenarios() {
        failureScenario(${dataType.concreteValue}, ${dataType.notEqualToValue});
    }

    private static void failureScenario(${dataType.native} actual, ${dataType.native} expected) {
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
        validationScenario(null, ${dataType.concreteValue});
        validationScenario(${dataType.concreteValue}, null);
    }

    private static void validationScenario(Object actual, Object expected) {
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