Visual Format String Grammar

The visual format string grammar is defined as follows (literals are shown in code font; e denotes the empty string).

Symbol
Replacement rule

<visualFormatString> 

(<orientation>:)?
(<superview><connection>)?
<view>(<connection><view>)*
(<connection><superview>)?


<orientation>
H|V


<superview>
|


<view>
[<viewName>(<predicateListWithParens>)?]


<connection>
e|-<predicateList>-|-


<predicateList>
<simplePredicate>|<predicateListWithParens>


<simplePredicate>
<metricName>|<positiveNumber>


<predicateListWithParens>
(<predicate>(,<predicate>)*)


<predicate>
(<relation>)?(<objectOfPredicate>)(@<priority>)?


<relation>
==|<=|>=


<objectOfPredicate>
<constant>|<viewName> (see note)


<priority>
<metricName>|<number>


<constant>
<metricName>|<number>


<viewName>
Parsed as a C identifier. This must be a key mapping to an instance of NSView in the passed views dictionary.


<metricName>
Parsed as a C identifier. This must be a key mapping to an instance of NSNumber in the passed metrics dictionary.


<number>
As parsed by strtod_l, with the C locale.