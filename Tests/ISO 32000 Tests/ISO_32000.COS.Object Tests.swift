// ISO_32000.COS.Object Tests.swift

import Testing

@testable import ISO_32000

@Suite
struct `ISO_32000.COS.Object Tests` {

    // MARK: - Null

    @Test
    func `Null object`() {
        let object = ISO_32000.COS.Object.null
        if case .null = object {
            // pass
        } else {
            Issue.record("Expected null object")
        }
    }

    // MARK: - Boolean

    @Test
    func `Boolean true`() {
        let object = ISO_32000.COS.Object.boolean(true)
        if case .boolean(let value) = object {
            #expect(value == true)
        } else {
            Issue.record("Expected boolean object")
        }
    }

    @Test
    func `Boolean false`() {
        let object = ISO_32000.COS.Object.boolean(false)
        if case .boolean(let value) = object {
            #expect(value == false)
        } else {
            Issue.record("Expected boolean object")
        }
    }

    @Test
    func `Boolean via literal`() {
        let object: ISO_32000.COS.Object = true
        #expect(object == .boolean(true))
    }

    // MARK: - Integer

    @Test
    func `Integer positive`() {
        let object = ISO_32000.COS.Object.integer(42)
        if case .integer(let value) = object {
            #expect(value == 42)
        } else {
            Issue.record("Expected integer object")
        }
    }

    @Test
    func `Integer negative`() {
        let object = ISO_32000.COS.Object.integer(-100)
        if case .integer(let value) = object {
            #expect(value == -100)
        } else {
            Issue.record("Expected integer object")
        }
    }

    @Test
    func `Integer via literal`() {
        let object: ISO_32000.COS.Object = 42
        #expect(object == .integer(42))
    }

    @Test
    func `Integer from Int`() {
        let object = ISO_32000.COS.Object.integer(100)
        #expect(object == .integer(100))
    }

    // MARK: - Real

    @Test
    func `Real positive`() {
        let object = ISO_32000.COS.Object.real(3.14159)
        if case .real(let value) = object {
            #expect(abs(value - 3.14159) < 0.0001)
        } else {
            Issue.record("Expected real object")
        }
    }

    @Test
    func `Real negative`() {
        let object = ISO_32000.COS.Object.real(-2.5)
        if case .real(let value) = object {
            #expect(value == -2.5)
        } else {
            Issue.record("Expected real object")
        }
    }

    @Test
    func `Real via literal`() {
        let object: ISO_32000.COS.Object = 3.14
        if case .real(let value) = object {
            #expect(abs(value - 3.14) < 0.001)
        } else {
            Issue.record("Expected real object")
        }
    }

    // MARK: - Name

    @Test
    func `Name object`() {
        let object = ISO_32000.COS.Object.name(.type)
        if case .name(let name) = object {
            #expect(name == .type)
        } else {
            Issue.record("Expected name object")
        }
    }

    @Test
    func `Name from string convenience`() {
        let object = ISO_32000.COS.Object.name("Custom")
        #expect(object != nil)
        if case .name(let name) = object {
            #expect(name.rawValue == "Custom")
        }
    }

    @Test
    func `Name from invalid string returns nil`() {
        let object = ISO_32000.COS.Object.name("Has Space")
        #expect(object == nil)
    }

    // MARK: - String

    @Test
    func `String object`() {
        let object = ISO_32000.COS.Object.string(ISO_32000.COS.StringValue("Hello"))
        if case .string(let str) = object {
            #expect(str.value == "Hello")
        } else {
            Issue.record("Expected string object")
        }
    }

    @Test
    func `String from string convenience`() {
        let object = ISO_32000.COS.Object.string("World")
        if case .string(let str) = object {
            #expect(str.value == "World")
        } else {
            Issue.record("Expected string object")
        }
    }

    // MARK: - Array

    @Test
    func `Array object`() {
        let object = ISO_32000.COS.Object.array([.integer(1), .integer(2), .integer(3)])
        if case .array(let elements) = object {
            #expect(elements.count == 3)
        } else {
            Issue.record("Expected array object")
        }
    }

    @Test
    func `Array via literal`() {
        let object: ISO_32000.COS.Object = [1, 2, 3]
        if case .array(let elements) = object {
            #expect(elements.count == 3)
            #expect(elements[0] == .integer(1))
        } else {
            Issue.record("Expected array object")
        }
    }

    @Test
    func `Mixed array`() {
        let object: ISO_32000.COS.Object = [1, 2.5, true]
        if case .array(let elements) = object {
            #expect(elements.count == 3)
            #expect(elements[0] == .integer(1))
            if case .real = elements[1] {
                // pass
            } else {
                Issue.record("Expected real at index 1")
            }
            #expect(elements[2] == .boolean(true))
        } else {
            Issue.record("Expected array object")
        }
    }

    // MARK: - Dictionary

    @Test
    func `Dictionary object`() {
        let dict: ISO_32000.COS.Dictionary = [.type: .name(.page)]
        let object = ISO_32000.COS.Object.dictionary(dict)
        if case .dictionary(let d) = object {
            #expect(d[.type] == .name(.page))
        } else {
            Issue.record("Expected dictionary object")
        }
    }

    // MARK: - Reference

    @Test
    func `Indirect reference`() {
        let ref = ISO_32000.COS.IndirectReference(objectNumber: 5, generation: 0)
        let object = ISO_32000.COS.Object.reference(ref)
        if case .reference(let r) = object {
            #expect(r.objectNumber == 5)
            #expect(r.generation == 0)
        } else {
            Issue.record("Expected reference object")
        }
    }

    // MARK: - Equality

    @Test
    func `Objects of same type and value are equal`() {
        #expect(ISO_32000.COS.Object.integer(42) == .integer(42))
        #expect(ISO_32000.COS.Object.boolean(true) == .boolean(true))
        #expect(ISO_32000.COS.Object.null == .null)
    }

    @Test
    func `Objects of different types are not equal`() {
        #expect(ISO_32000.COS.Object.integer(1) != .real(1.0))
        #expect(ISO_32000.COS.Object.boolean(true) != .integer(1))
    }
}
