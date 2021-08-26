# Fluent Assertions for Apex
This project aims provide better asserts for tests in Apex. Inspired by [AssertJ](https://assertj.github.io/doc/) and other fluent libraries. Currently supports Boolean, Decimal, Double, Integer, Long, List, Set, Map, Id, Blob, String, Date, Time, Datetime and generic Object.

## Usage
Untill proper documentation is done, this will have to work for now.

The asserts below can all be chanied like the example below.

```
FluentAssert.that('Hello World!')
            .length()
                .isLessThan(100)
            .back()
            .startsWith('Hello')
            .contains('World');

FluentAssert.that(aList)
            .size()
                .isGreaterThan(10)
            .back()
            .contains(someOtherList)
            .isSorted();
```

### Navigators
A navigator is a handy feature that allows to zoom in on a specific part of a value, do some asserts and get back to the initial value. Once done using the navigator, simply do `back()` to get back to the initial value.

Type     | Navigators
---------|-------------------------------
`Set`    | `size()`
`List`   | `size()`
`Map`    | `size()`, `values()`, `keys()`
`String` | `length()`
`Blob`   | `size()`

While one could do the same asserts in other ways, using a navigator allows a much more fluent way of expression.

Method     | `FluentAssert` equivalent
-----------|-------------------------------
`size()`   | `FluentAssert.that(someCollection.size())`
`values()` | `FluentAssert.that(someMap.values())`
`keys()`   | `FluentAssert.that(someMap.keySet())`
`length()` | `FluentAssert.that(someString.length())`
`size()`   | `FluentAssert.that(someBlob.size())`

### Object
```
// Object equality
FluentAssert.that(something).isEqualTo(somethingElse);
FluentAssert.that(something).isNotEqualTo(somethingElse);

FluentAssert.that(something).isNull();
FluentAssert.that(something).isNotNull();

// Same memory
FluentAssert.that(something).isSame(somethingElse);
FluentAssert.that(something).isNotSame(somethingElse);

// In some collection
FluentAssert.that(something).isIn(someList));
FluentAssert.that(something).isIn(someSet);
```

### Boolean
Also supports `isEqualTo`, `isNotEqualTo`, `isNull`, `isNotNull`, `isSame`, `isNotSame`, and `IsIn`.
```
FluentAssert.that(something).isTrue();
FluentAssert.that(something).isFalse();
```

### Numbers
Snippet below works for `Integer`, `Long`, `Double`, and `Decimal`. Also supports `isEqualTo`, `isNotEqualTo`, `isNull`, `isNotNull`, `isSame`, `isNotSame`, and `IsIn`.
```
// start included, end included
FluentAssert.that(something).isBetween​(start, end);
// start excluded, end excluded
FluentAssert.that(something).isStrictlyBetween​(start, end);

FluentAssert.that(something).isNegative();
FluentAssert.that(something).isNotNegative();

FluentAssert.that(something).isPositive();
FluentAssert.that(something).isNotPositive();

FluentAssert.that(something).isZero();
FluentAssert.that(something).isNotZero();

FluentAssert.that(something).isOne();

FluentAssert.that(something).isLessThan(somethingElse);
FluentAssert.that(something).isLessThanOrEqualTo(somethingElse);
FluentAssert.that(something).isGreaterThan(somethingElse);
FluentAssert.that(something).isGreaterThanOrEqualTo(somethingElse);
```

### List / Set
Snippet below works for `List` and `Set`. Set is not supported in `containsExactly`, `containsSequence`, `doesNotContainSequence`, `containsSubsequence`, or `doesNotContainSubsequence` since they are unordered.
Also supports `isEqualTo`, `isNotEqualTo`, `isNull`, `isNotNull`, `isSame`, and `isNotSame`.

All examples below uses the following constants:

```
private static final List<Object> ABC = new List<Object>{
    'A', 'B', 'C'
};
private static final List<Object> EMPTY_LIST = new List<Object>();
private static final List<Object> LATIN_ALPHABET = new List<Object>{
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'X', 'Y', 'Z'
};
```

#### isEmpty / isNotEmpty
```
// Pass
FluentAssert.that(EMPTY_LIST).isEmpty();
FluentAssert.that(LATIN_ALPHABET).isNotEmpty();

// Failure
FluentAssert.that(LATIN_ALPHABET).isEmpty();
FluentAssert.that(EMPTY_LIST).isNotEmpty();
```

#### hasSize / hasSameSizeAs
```
// Pass
FluentAssert.that(LATIN_ALPHABET).hasSize(25);

// Failure
FluentAssert.that(LATIN_ALPHABET).hasSameSizeAs(new List<String>{'A', 'B', 'C'});
FluentAssert.that(LATIN_ALPHABET).hasSameSizeAs(new Set<String>{'A', 'B', 'C'});
```

#### contains / doesNotContain
These methods will simply look at the presence of elements. Supports both single input as well as `List`s.
```
// Pass
FluentAssert.that(LATIN_ALPHABET).contains(new List<String>{'A', 'B', 'C'});
FluentAssert.that(LATIN_ALPHABET).contains(new Set<String>{'A', 'B', 'C'});

FluentAssert.that(LATIN_ALPHABET).doesNotContain(new List<String>{'@', '#', '!'});
FluentAssert.that(LATIN_ALPHABET).doesNotContain(new Set<String>{'@', '#', '!'});

// Failure
FluentAssert.that(LATIN_ALPHABET).doesNotContain(new List<String>{'A', 'B', 'C'});
FluentAssert.that(LATIN_ALPHABET).doesNotContain(new Set<String>{'A', 'B', 'C'});

FluentAssert.that(LATIN_ALPHABET).contains(new List<String>{'@', '#', '!'});
FluentAssert.that(LATIN_ALPHABET).contains(new Set<String>{'@', '#', '!'});
```

#### containsAnyOf
This method will pass if any of the expected elements are in the list.
```
// Pass
FluentAssert.that(LATIN_ALPHABET).containsAnyOf(new List<String>{'A', '@'});
FluentAssert.that(LATIN_ALPHABET).containsAnyOf(new Set<String>{'A', '@'});

// Failure
FluentAssert.that(LATIN_ALPHABET).containsAnyOf(new List<String>{'@', '#', '!'});
FluentAssert.that(LATIN_ALPHABET).containsAnyOf(new Set<String>{'@', '#', '!'});
```

#### containsExactly (`List` only)
This method will pass if all elements are in the same position in the list and no other elements are present.
```
// Pass
FluentAssert.that(LATIN_ALPHABET).containsExactly(new List<String>{'A', ... 'Z'});

// Failure
FluentAssert.that(LATIN_ALPHABET).containsExactly(new List<String>{'A', 'B', 'C'});
```

#### containsExactlyInAnyOrder
This method will pass if all elements the list regardless of their position and no other elements are present.
```
// Pass
FluentAssert.that(LATIN_ALPHABET).containsExactlyInAnyOrder(new List<String>{'Z', ... 'A'});
FluentAssert.that(LATIN_ALPHABET).containsExactlyInAnyOrder(new Set<String>{'Z', ... 'A'});

// Failure
FluentAssert.that(LATIN_ALPHABET).containsExactlyInAnyOrder(new List<String>{'A', 'B', 'C'});
FluentAssert.that(LATIN_ALPHABET).containsExactlyInAnyOrder(new Set<String>{'A', 'B', 'C'});
```

#### containsSequence / doesNotContainSequence (`List` only)
This methods will pass (or not) if a given sequence is in the list of elements. In order to pass the sequence must be in the same order and without gaps/other elements in between.
```
// Pass
FluentAssert.that(LATIN_ALPHABET).containsSequence(new List<String>{'X', 'Y', 'Z'});
FluentAssert.that(LATIN_ALPHABET).doesNotContainSequence(new List<String>{'Z', 'A'});

// Failure
FluentAssert.that(LATIN_ALPHABET).doesNotContainSequence(new List<String>{'Z', 'A'});
```

#### containsSubsequence / doesNotContainSubsequence
This methods will pass (or not) if a given subsequence is in the list of elements. In order to pass the subsequence must be in the same order but it can have gaps/other elements in between.
```
// Pass
FluentAssert.that(LATIN_ALPHABET).containsSubsequence(new List<String>{'A', 'E', 'I', 'O', 'U', 'Y'});
FluentAssert.that(LATIN_ALPHABET).doesNotContainSubsequence(new List<String>{'Y', 'U', 'O', 'I', 'E', 'A'});

// Failure
FluentAssert.that(LATIN_ALPHABET).containsSubsequence(new List<String>{'Y', 'U', 'O', 'I', 'E', 'A'});
FluentAssert.that(LATIN_ALPHABET).doesNotContainSubsequence(new List<String>{'A', 'E', 'I', 'O', 'U', 'Y'});
```

#### isSorted (`List` only)
This method will pass if the list is sorted. Implementation will create a new list, sort it and use that against actual.
Be aware that sorting is done acording to [Apex Developer guide](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/langCon_apex_collections_lists_sorting.htm).
```
// Pass
FluentAssert.that(LATIN_ALPHABET).isSorted();

// Failure
FluentAssert.that(new List<String>{'Z', 'A'}).isSorted();
```

#### containsOnly
This method will pass if the collection contains only the given elements. Ordering is not taken into account and elements can be in both collections more than once.
```
// Pass
FluentAssert.that(ABC).containsOnly(new List<String>{'A', 'B', 'C'})
                      .containsOnly(new List<String>{'A', 'A', 'B', 'C'})
                      .containsOnly(new List<String>{'C', 'B', 'A', 'C'});

// Failure
FluentAssert.that(LATIN_ALPHABET).containsOnly(new List<String>{'A', 'B'});
```

#### containsOnlyOnce (`List` only)
This method will pass if the collection contains only the given elements only once in any given order.
```
// Pass
FluentAssert.that(ABC).containsOnly(new List<String>{'A', 'B'})
                      .containsOnly(new List<String>{'C', 'B'});

// Failure
FluentAssert.that(ABC).containsOnly(new List<String>{'D'});
FluentAssert.that(new List<Object>{'C', 'C'}).containsOnly(new List<String>{'C'});
```
#### containsOnlyNulls
This method will pass if actual has values that are `null` only.
```
// Pass
FluentAssert.that(new List<String>{null, null}).containsOnlyNulls();

// Failure
FluentAssert.that(EMPTY_LIST).containsOnlyNulls();
FluentAssert.that(LATIN_ALPHABET).containsOnlyNulls();
```

### Date / Datetime / Time
Snippet below works for `Date`, `Datetime`, and `Time`. Also supports `isEqualTo`, `isNotEqualTo`, `isNull`, `isNotNull`, `isSame`, `isNotSame`, and `IsIn`.

#### isBetween​ / isStrictlyBetween​
This methods will pass (or not) if actual is between (start/end included) or stricly between (start/end excluded) a range.
```
// Pass
FluentAssert.that(Date.newInstance(2020, 5, 12)).isBetween​(Date.newInstance(2020, 5, 1), Date.newInstance(2020, 5, 12));
FluentAssert.that(Date.newInstance(2020, 5, 12)).isStrictlyBetween​(Date.newInstance(2020, 5, 1), Date.newInstance(2020, 5, 13));

// Failure
FluentAssert.that(Date.newInstance(2020, 5, 12)).isBetween​(Date.newInstance(2020, 5, 1), Date.newInstance(2020, 5, 10));
FluentAssert.that(Date.newInstance(2020, 5, 12)).isStrictlyBetween​(Date.newInstance(2020, 5, 1), Date.newInstance(2020, 5, 12));
```

#### isAfter / isAfterOrEqualTo
This methods will pass (or not) if actual is after (or equal to) an expected Date.
```
// Pass
FluentAssert.that(Date.newInstance(2020, 5, 12)).isAfter(Date.newInstance(2020, 5, 11));

FluentAssert.that(Date.newInstance(2020, 5, 12)).isAfterOrEqualTo(Date.newInstance(2020, 5, 12));

// Failure
FluentAssert.that(Date.newInstance(2020, 5, 12)).isAfter(Date.newInstance(2020, 5, 10));

FluentAssert.that(Date.newInstance(2020, 5, 12)).isAfterOrEqualTo(Date.newInstance(2020, 5, 11));
```

#### isBefore / isBeforeOrEqualTo
This methods will pass (or not) if actual is before (or equal to) an expected Date.
```
// Pass
FluentAssert.that(Date.newInstance(2020, 5, 12)).isBefore(Date.newInstance(2020, 5, 13));

FluentAssert.that(Date.newInstance(2020, 5, 12)).isBeforeOrEqualTo(Date.newInstance(2020, 5, 12));

// Failure
FluentAssert.that(Date.newInstance(2020, 5, 12)).isBefore(Date.newInstance(2020, 5, 12));

FluentAssert.that(Date.newInstance(2020, 5, 12)).isBeforeOrEqualTo(Date.newInstance(2020, 5, 13));
```

#### isToday
This methods will pass (or not) if actual is today.
```
// Pass
FluentAssert.that(Date.today()).isToday();

// Failure
FluentAssert.that(Date.today().addDays(-1)).isToday();
```

### String
Most support for `String` delegates to methods already on `String` (see table below) but is here to support a fluent programming style. Also supports `isEqualTo`, `isNotEqualTo`, `isNull`, `isNotNull`, `isSame`, `isNotSame`, and `IsIn`.

Method                                                                                                                                                                  | Description
----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------
[`contains`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_contains)                         | contains the specified sequence of characters in substring
[`containsAny`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_containsAny)                   | contains any of the characters in expected
[`containsIgnoreCase`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_containsIgnoreCase)     | contains the specified sequence of characters without regard to case
[`containsNone`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_containsNone)                 | doesn’t contain any of the characters in notExpected
[`containsOnly`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_containsOnly)                 | contains characters only from the specified sequence of characters and not any other characters
[`containsWhitespace`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_containsWhitespace)     | contains any white space characters
[`endsWith`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_endsWith)                         | ends with the specified suffix
[`endsWithIgnoreCase`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_endsWithIgnoreCase)     | ends with the specified suffix, case ignored
[`equalsIgnoreCase`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_equalsIgnoreCase)         | is not null and represents the same sequence of characters as actual
[`isAllLowerCase`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isAllLowerCase)             | all characters are lowercase
[`isAllUpperCase`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isAllUpperCase)             | all characters are uppercase
[`isAlpha`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isAlpha)                           | all characters are Unicode letters only
[`isAlphaSpace`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isAlphaSpace)                 | all characters are Unicode letters or spaces only
[`isAlphanumeric`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isAlphanumeric)             | all characters are Unicode letters or numbers only
[`isAlphanumericSpace`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isAlphanumericSpace)   | all characters are Unicode letters, numbers, or spaces only
[`isAsciiPrintable`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isAsciiPrintable)         | contains only ASCII printable characters
[`isBlank`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isBlank)                           | the specified String is white space, empty (''), or null
[`isEmpty`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isEmpty)                           | the specified String is empty ('') or null
[`isNotBlank`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isNotBlank)                     | the specified String is not whitespace, not empty (''), and not null
[`isNotEmpty`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isNotEmpty)                     | the specified String is not empty ('') and not null
[`isNumeric`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isNumeric)                       | contains only Unicode digits
[`isNumericSpace`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isNumericSpace)             | only Unicode digits or spaces
[`isWhitespace`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_isWhitespace)                 | contains only white space characters or is empty
[`startsWith`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_startsWith)                     | begins with the specified prefix
[`startsWithIgnoreCase`](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_string.htm#apex_System_String_startsWithIgnoreCase) | begins with the specified prefix, case ignored

#### hasLength
This method will pass if the String has a length as expected.
```
// Pass
FluentAssert.that('').hasLength(0);
FluentAssert.that('ABC').hasLength(3);

// Failure
FluentAssert.that('ABC').hasLength(4);
```

### Map
Snippets below works for `Map`. All examples below uses the following constants:

```
private static final Map<Object, Object> EMPTY = new Map<Object, Object>();
private static final Map<Object, Object> ABC = new Map<Object, Object>{
    'A' => 'a',
    'B' => 'b',
    'C' => 'c'
};
```
Also supports `isEqualTo`, `isNotEqualTo`, `isNull`, `isNotNull`, `isSame`, and `isNotSame`.

#### isEmpty / isNotEmpty
```
// Pass
FluentAssert.that(EMPTY).isEmpty();
FluentAssert.that(ABC).isNotEmpty();

// Failure
FluentAssert.that(ABC).isEmpty();
FluentAssert.that(EMPTY).isNotEmpty();
```
#### containsEntry
This method will pass if the Map contains the entry.
```
// Pass
FluentAssert.that(ABC).containsEntry('A', 'a');

// Failure
FluentAssert.that(EMPTY).containsEntry('A', 'a');
FluentAssert.that(ABC).containsEntry('A', 'b');
FluentAssert.that(ABC).containsEntry('B', 'a');
```

#### doesNotContainEntry
This method will pass if the Map contains the entry.
```
// Pass
FluentAssert.that(EMPTY).doesNotContainEntry('A', 'a');
FluentAssert.that(ABC).doesNotContainEntry('A', 'b')
                      .doesNotContainEntry('B', 'a');

// Failure
FluentAssert.that(ABC).doesNotContainEntry('A', 'a');
```

### Id
For now support for `Id` is pretty straitforward. Also supports `isEqualTo`, `isNotEqualTo`, `isNull`, `isNotNull`, `isSame`, `isNotSame`, and `IsIn`.

#### isSObjectType
```
// Pass
FluentAssert.that(UserInfo.getUserId()).isSObjectType(User.SObjectType);

// Failure
FluentAssert.that(UserInfo.getUserId()).isSObjectType(Account.SObjectType);
```

### Blob
Support for `Blob`. Also supports `isEqualTo`, `isNotEqualTo`, `isNull`, `isNotNull`, `isSame`, `isNotSame`, and `IsIn`.

#### hasSize / hasSameSizeAs
```
// Pass
FluentAssert.that(someBlob).hasSize(25);
FluentAssert.that(someBlob).hasSameSizeAs(someOtherBlob);
```

## Generating and building
Apex is not the best language to write generic frameworks in. To compensate the classes in `force-app/main/generated` is generated from templates in `templates` using [fmpp](http://fmpp.sourceforge.net/).