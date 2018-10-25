Extension { #name : #RPackage }

{ #category : #'*DesignInfo' }
RPackage >> testMethods [
	^ self methods select: [ : each | each realClass inheritsFrom: TestCase ]
]
