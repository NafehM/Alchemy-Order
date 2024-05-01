//
//  MyModel.swift
//  ScienceGame
//
//  Created by NMM on 11/04/2024.
//

/*
 This class responsible for managing a collection of elements
 along with tracking the score and remaining lives
 in a game or application context
 */
class MyModel {
    
    // MARK: - Properties
    
    // A dynamic array of Element instances representing elements
    var elements = [Element]()
    var score: Int = 0
    var lives: Int = 3
    
    // MARK: - Initialiser
    
    // Initialises the `MyModel` with a default set of elements
    init() {
        // Elements are added to the array upon initialisation
        elements.append(Element(elementName: "Hydrogen", atomicNumber: 1))
        elements.append(Element(elementName: "Lithium", atomicNumber: 3))
        elements.append(Element(elementName: "Sodium", atomicNumber: 11))
        elements.append(Element(elementName: "Potassium", atomicNumber: 19))
        elements.append(Element(elementName: "Rubidium", atomicNumber: 37))
        elements.append(Element(elementName: "Caesium", atomicNumber: 55))
        elements.append(Element(elementName: "Francium", atomicNumber: 87))
    }
    
    // MARK: - Functions
    
    /*
     Retrieves the current list of elements
     Returns: An array of Element
     */
    open func getElements()->[Element] {
        return elements
    }
    
    //Removes and returns an element at the specified index
    func removeElement(at index: Int) -> Element {
        return elements.remove(at: index)
    }
    
     //Inserts a new element at the specified index
    func insertElement(_ element: Element, at index: Int) {
        elements.insert(element, at: index)
    }
    
    //Moves an element from one index to another within the elements array
    func moveElement(from sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return } // No move needed if indices are the same
        let element = elements.remove(at: sourceIndex)
        elements.insert(element, at: destinationIndex)
    }
    
    // Shuffles the elements in a random order
    func shuffleElements() {
        elements.shuffle()
    }
    
    // Checks if the elements are in ascending order based on their atomic number
    func areElementsOrdered() -> Bool {
        let sortedElements = elements.sorted { $0.getAtomicNumber() < $1.getAtomicNumber() }
        
        // Debugging print statements
//        print("Current order: \(elements.map { $0.getAtomicNumber() })")
//        print("Sorted order should be: \(sortedElements.map { $0.getAtomicNumber() })")
        
        let isOrdered = elements == sortedElements
//        print("Elements are ordered: \(isOrdered)")
        return isOrdered
    }
    
    // Updates the current score by adding the given points
    func updateScore(with points: Int) {
        score += points
    }
    
    // Reset game to initial state
    func resetGame() {
        score = 0
        lives = 3
        shuffleElements()
    }
    
    //Decrements the life count by one, only if lives are still available
    func useLife() {
        if lives > 0 {
            lives -= 1
        }
    }
}

