Class {
	#name : #DesignInfoTest,
	#superclass : #TestCase,
	#instVars : [
		'designInsight',
		'designInfo'
	],
	#category : #DesignInfo
}

{ #category : #tests }
DesignInfoTest >> setUp [
	designInfo := DesignInfo packageNamed: 'DesignInfo'
]

{ #category : #tests }
DesignInfoTest >> testCodeStrings [
	self assert: '25 (19.1%)' equals: designInfo testCodeString.
	self assert: '106 (80.9%)' equals: designInfo productionCodeString
]

{ #category : #tests }
DesignInfoTest >> testLinesOfCode [

	self assert: 131 equals: designInfo linesOfCode.
	self assert: 25 equals: designInfo linesOfTestCode.
	self assert: 106 equals: designInfo linesOfProductionCode
]

{ #category : #tests }
DesignInfoTest >> testPackageInfo [
	self assert: 8 equals: designInfo packageInfo testMethods size
]

{ #category : #tests }
DesignInfoTest >> testPercentage [
	self assert: (25/131) equals: designInfo percentageOfTestCode.
	self assert: '19.1%' equals: designInfo percentageOfTestCodeString.
	self assert: 106/131 equals: designInfo percentageOfProductionCode.
	self assert: '80.9%' equals: designInfo percentageOfProductionCodeString
]

{ #category : #tests }
DesignInfoTest >> testPrintString [
	self assert: 'DesignInfo - lines of code: 131 - production: 106 (80.9%) - test: 25 (19.1%)' equals: designInfo printString
]

{ #category : #tests }
DesignInfoTest >> testShortPrintString [
	self assert: 'DesignInfo - 131' equals: designInfo shortPrintString
]

{ #category : #tests }
DesignInfoTest >> testZeroLinesOfCode [
"	| flexibleVocabulariesDesignInfo |
	flexibleVocabulariesDesignInfo := DesignInfo packageNamed: 'FlexibleVocabularies'.
	self assert: 0 equals: flexibleVocabulariesDesignInfo percentageOfProductionCode.
	self assert: 0 equals: flexibleVocabulariesDesignInfo percentageOfTestCode"
]
