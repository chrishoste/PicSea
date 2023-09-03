import Foundation

extension Sequence {
    /// Returns a new array containing the elements of the sequence sorted based on a key path.
    ///
    /// - Parameters:
    ///   - keyPath: A key path that specifies the property to be used as the sorting key.
    /// - Returns: A new array containing the sorted elements.
    ///
    /// - Complexity: The sorting is performed in O(n log n) time, where n is the length of the sequence.
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}
