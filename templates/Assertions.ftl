<#--
  - Copyright (c) 2021, salesforce.com, inc.
  - All rights reserved.
  - SPDX-License-Identifier: BSD-3-Clause
  - For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
-->
<@pp.dropOutputFile />
<#assign supportedAsserts = [
    {"type":"Boolean",     "asserts": ["IsTrue", "IsFalse"]},
    {"type":"Decimal",     "isNumber": true},
    {"type":"Double",      "isNumber": true},
    {"type":"Integer",     "isNumber": true},
    {"type":"Long",        "isNumber": true},
    {"type":"Id",          "asserts": ["IsSObjectType"]},
    {"type":"Object"},
    {"type":"Set<Object>", "isCollection": true, "asserts": ["Contains", "DoesNotContain", "ContainsAnyOf", "ContainsExactlyInAnyOrder", "ContainsOnly", "ContainsOnlyNulls"],
        "navigators": [{
            "name": "size",
            "method": "size",
            "returnType": "Integer"
        }]},
    {"type":"List<Object>", "isCollection": true, "asserts": ["Contains", "DoesNotContain", "ContainsAnyOf", "ContainsExactlyInAnyOrder", "ContainsExactly", "ContainsSequence", "DoesNotContainSequence", "ContainsSubsequence", "DoesNotContainSubsequence", "IsSorted", "ContainsOnly", "ContainsOnlyOnce", "ContainsOnlyNulls"],
        "navigators": [{
            "name": "size",
            "method": "size",
            "returnType": "Integer"
        }]},
    {"type":"Date",         "isDatetime": true, "asserts": ["IsToday"]},
    {"type":"Datetime",     "isDatetime": true},
    {"type":"Time",         "isDatetime": true, "comparableHelper":"TimeUtil.toMillisecondsOfDay"},
    {"type":"String",       "asserts": ["StringDelegates", "HasLength"],
        "navigators": [{
            "name": "length",
            "method": "length",
            "returnType": "Integer"
        }
        ]},
    {"type":"Map<Object, Object>", "isCollection": true, "isMap": true, "asserts": ["ContainsEntry", "DoesNotContainEntry"],
        "navigators": [{
            "name": "size",
            "method": "size",
            "returnType": "Integer"
        },{
            "name": "values",
            "method": "values",
            "returnType": "List"
        },{
            "name": "keys",
            "method": "keySet",
            "returnType": "Set"
        }
        ]},
    {"type":"Blob", "asserts": ["HasSize", "HasSameSizeAs"],
        "navigators": [{
            "name": "size",
            "method": "size",
            "returnType": "Integer"
        }
        ]},
    {"type":"SObject",     "asserts": ["Extracting", "HasErrors", "HasNoErrors", "IsClone", "IsRecordType"]},
    {"type":"Exception",   "asserts": ["HasMessage", "HasCause", "HasNoCause"],
        "navigators": [{
            "name": "cause",
            "method": "getCause",
            "returnType": "Exception"
        },{
            "name":       "rootCause",
            "method":     "getCause",
            "util":       "ExceptionUtil.getRootCause",
            "returnType": "Exception"
        },{
            "name": "message",
            "method": "getMessage",
            "returnType": "String"
        }]}
]>
<#list supportedAsserts as supportedAssert>
    <#assign asserts = supportedAssert.asserts![] />
    <#assign asserts = asserts + ["IsNull", "IsNotNull", "IsEqualTo", "IsNotEqualTo", "IsSame", "IsNotSame"] />
    <#if supportedAssert.isCollection!false>
        <#assign asserts = asserts + ["HasSize", "HasSameSizeAs", "IsEmpty", "IsNotEmpty"] />
    </#if>
    <#if supportedAssert.isNumber!false>
        <#assign asserts = asserts + ["IsBetween", "IsStrictlyBetween", "IsNegative", "IsNotNegative", "IsPositive", "IsNotPositive", "IsOne", "IsZero", "IsNotZero", "IsLessThan", "IsLessThanOrEqualTo", "IsGreaterThan", "IsGreaterThanOrEqualTo"] />
    </#if>
    <#if supportedAssert.isDatetime!false>
        <#assign asserts = asserts + ["IsBetween", "IsStrictlyBetween", "IsAfterOrEqualTo", "IsAfter", "IsBefore", "IsBeforeOrEqualTo"] />
    </#if>
    <#if !supportedAssert.isCollection!false>
        <#assign asserts = asserts + ["IsIn"] />
    </#if>
<@com.apexClass className="${supportedAssert.type?keep_before('<')}Assert" path="/classes/"/>
/**
 * @description Holds asserts for `${supportedAssert.type?keep_before('<')}`s
 */
global class ${supportedAssert.type?keep_before('<')}Assert extends AssertBase {
    private ${supportedAssert.type} actual;

    /**
     * @description Constructs an instance with an actual `${supportedAssert.type?keep_before('<')}` value.
     * @param actual The actual value to assert against.
     */
    global ${supportedAssert.type?keep_before('<')}Assert(${supportedAssert.type} actual) {
        this.actual = actual;
    }

    <#if supportedAssert.navigators?has_content><#list supportedAssert.navigators?sort_by("name") as n>
    /**
     * @description Constructs a navigator that allows asserts on ${n.name}(). Use `andThen()` to continue asserting on `${supportedAssert.type?keep_before('<')}`.
     * @return a navigator on ${n.name}().
     */
    global ${n.returnType}Assert${supportedAssert.type?keep_before('<')}Navigator ${n.name}() {
        notNull(actual, 'actual');
        return new ${n.returnType}Assert${supportedAssert.type?keep_before('<')}Navigator(<#if n.util??>${n.util}(</#if>actual.${n.method}()<#if n.util??>)</#if>, this);
    }
    <#sep>

    </#list></#if>
    
    <#list asserts?sort as assert>
        <#include "/common/assertions/${assert}.ftl">
    <#sep>
 
    </#list>
}

</#list>