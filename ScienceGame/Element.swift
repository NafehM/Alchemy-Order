//
//  Element.swift
//  ScienceGame
//
//  Created by NMM on 11/04/2024.
//

//Datasource class
class Element: Equatable {
    
    // MARK: - Properties
//    var symbol: String
    private var elementName: String
    private var atomicNumber: Int
    
    // MARK: - Initializer
    
    
    init(elementName: String, atomicNumber: Int) {
        self.elementName = elementName
        self.atomicNumber = atomicNumber
    }
    
    // MARK: - Accessors
    
    public func getElementName()->String {
        return elementName
    }
    
    public func getAtomicNumber()->Int {
        return atomicNumber
    }
    
    // MARK: - Equatable Protocol
    
    /*
     Determines if two `Element` instances are considered equal.
     They are equal if they have the same atomic number and element name
     - Parameters:
        - lhs: The left-hand side `Element` to compare
        - rhs: The right-hand side `Element` to compare
        - Returns: A Boolean value indicating whether the two elements are equal.
     */
    static func == (lhs: Element, rhs: Element) -> Bool {
        return lhs.atomicNumber == rhs.atomicNumber && lhs.elementName == rhs.elementName
    }
    
}

