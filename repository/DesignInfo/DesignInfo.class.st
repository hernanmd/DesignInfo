"
A DesignInfo collects the following information and metrics about the design of a package:
- lines of code
- lines of production code
- lines of test code
- percentage of production code
- percentage of test code

It can create morphs that show a bar chart of the lines of code of all Monticello packages, sorted either by package name or by lines of code. The bar chart also shows the percentage of production versus test code. Balloon help is used to show detailed information about a package.

Ideas for enhancement:
- Allow combining production and test packages into one DesignInfo, e.g. Kernel and KernelTests
- Support more metrics, e.g. public versus private methods, number of variables, package and class references
- Separate UI into separate class
- Allow changing the sort order in the lines of code morph
"
Class {
	#name : #DesignInfo,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'linesOfCode',
		'linesOfTestCode'
	],
	#category : #DesignInfo
}

{ #category : #examples }
DesignInfo class >> example [
	self linesOfCodeSortedMorph openInWindow setLabel: 'Sorted Comparison'.
	self linesOfCodeMorph openInWindow setLabel: 'Comparison'
]

{ #category : #'user interface' }
DesignInfo class >> linesOfCodeMorph [
	"self linesOfCodeMorph openInHand"
	| packageInfos designInfos |
	packageInfos := (MCWorkingCopy registry collect: #package)
		asSortedCollection: [:a :b | a name <= b name].
	designInfos := packageInfos collect: [:each | (self packageNamed: each name)].
	^self linesOfCodeMorph: designInfos
]

{ #category : #'user interface' }
DesignInfo class >> linesOfCodeMorph: designInfos [
	| maxLinesOfCode morph |
	maxLinesOfCode := (designInfos collect: #linesOfCode) max.
	morph := Morph new
		color: Color black;
		layoutPolicy: TableLayout new;
		listDirection: #topToBottom;
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap;
		layoutInset: 3;
		cellInset: 2;
		borderWidth: 1;
		wrapCentering: #left;
		cellPositioning: #leftCenter;
		setBalloonText: 'total lines of code: ' , (designInfos collect: #linesOfCode) sum printString.
	designInfos do: [:each | morph addMorphBack: (each asMorph width: (each linesOfCode / maxLinesOfCode) * 500)].
	^ morph
]

{ #category : #'user interface' }
DesignInfo class >> linesOfCodeSortedMorph [
	"self linesOfCodeSortedMorph openInHand"
	| packageInfos designInfos |
	packageInfos := MCWorkingCopy registry collect: #package.
	designInfos := (packageInfos collect: [:each | (self packageNamed: each name)])
		asSortedCollection: [:a :b | a linesOfCode >= b linesOfCode].
	^self linesOfCodeMorph: designInfos
]

{ #category : #'instance creation' }
DesignInfo class >> packageNamed: aString [
	^self new setPackageName: aString
]

{ #category : #'user interface' }
DesignInfo >> asMorph [
	| font morph |
	font := StrikeFont familyName: 'Bitmap DejaVu Sans' size: 10.
	morph := Morph new
		layoutPolicy: ProportionalLayout new;
		height: font height.
	morph
		addMorph: (Morph new color: Color red; borderWidth: 0; setBalloonText: self printString)
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: self percentageOfProductionCode @ 1.0)).
	morph
		addMorph: (Morph new color: Color blue; borderWidth: 0; setBalloonText: self printString)
		fullFrame: (LayoutFrame fractions: (self percentageOfProductionCode @ 0 corner: 1.0 @ 1.0)).
	morph 
		addMorph: ((StringMorph contents: self shortPrintString) font: font; setBalloonText: self printString).
	^ morph
]

{ #category : #'lines of code' }
DesignInfo >> linesOfCode [

	^linesOfCode ifNil: [linesOfCode := self packageInfo linesOfCode]
]

{ #category : #'lines of code' }
DesignInfo >> linesOfProductionCode [
	^self linesOfCode - self linesOfTestCode
]

{ #category : #'lines of code' }
DesignInfo >> linesOfTestCode [
	^linesOfTestCode ifNil: [
		linesOfTestCode := self packageInfo testMethods
			inject: 0 into: [:sum :each | sum + each compiledMethod linesOfCode]]
]

{ #category : #private }
DesignInfo >> packageInfo [
	^ RPackage organizer packageNamed: packageName
]

{ #category : #'lines of code' }
DesignInfo >> percentageOfProductionCode [
	self linesOfCode isZero ifTrue: [^0].
	^self linesOfProductionCode / self linesOfCode
]

{ #category : #printing }
DesignInfo >> percentageOfProductionCodeString [
	^self percentageString: self percentageOfProductionCode
]

{ #category : #'lines of code' }
DesignInfo >> percentageOfTestCode [
	self linesOfCode isZero ifTrue: [^0].
	^self linesOfTestCode / self linesOfCode
]

{ #category : #printing }
DesignInfo >> percentageOfTestCodeString [
	^self percentageString: self percentageOfTestCode
]

{ #category : #printing }
DesignInfo >> percentageString: aFraction [
	^((aFraction asFloat * 100) roundTo: 0.1) printString , '%'
]

{ #category : #printing }
DesignInfo >> printOn: stream [
	stream
		nextPutAll: packageName;
		nextPutAll: ' - lines of code: ';
		nextPutAll: self linesOfCode printString;
		nextPutAll: ' - production: ';
		nextPutAll: self productionCodeString;
		nextPutAll: ' - test: ';
		nextPutAll: self testCodeString
]

{ #category : #printing }
DesignInfo >> productionCodeString [
	^String streamContents: [:stream |
		stream
			nextPutAll: self linesOfProductionCode printString;
			nextPutAll: ' (';
			nextPutAll: self percentageOfProductionCodeString;
			nextPut: $)]
]

{ #category : #private }
DesignInfo >> setPackageName: aString [
	packageName := aString
]

{ #category : #printing }
DesignInfo >> shortPrintString [
	^String streamContents: [:stream |
		stream
			nextPutAll: packageName;
			nextPutAll: ' - ';
			nextPutAll: self linesOfCode printString]
]

{ #category : #printing }
DesignInfo >> testCodeString [
	^String streamContents: [:stream |
		stream
			nextPutAll: self linesOfTestCode printString;
			nextPutAll: ' (';
			nextPutAll: self percentageOfTestCodeString;
			nextPut: $)]
]
