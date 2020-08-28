// Copyright (c) 2016 Johannes Schriewer.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Always UTF-8
class FastString {
	var buffer: UnsafeMutableBufferPointer<UInt8>
	
	init() {
		let memory = UnsafeMutablePointer<UInt8>.allocate(capacity: 1)
		memory[0] = 0
		self.buffer = UnsafeMutableBufferPointer(start: memory, count: 0)
	}
	
	internal init(capacity: Int) {
		let memory = UnsafeMutablePointer<UInt8>.allocate(capacity: capacity + 1)
		memory[capacity] = 0
		self.buffer = UnsafeMutableBufferPointer(start: memory, count: capacity)
	}
	
	init(_ string: String) {
		// FIXME: use utf16 on osx
		let count = string.utf8.count
		let memory = UnsafeMutablePointer<UInt8>.allocate(capacity: count + 1)
		var index = 0
		for c in string.utf8 {
			memory[index] = c
			index += 1
		}
		memory[count] = 0
		self.buffer = UnsafeMutableBufferPointer(start: memory, count: count)
	}
	
	convenience init?(nullTerminatedCString: UnsafePointer<Int8>) {
		if let s = String(validatingUTF8: nullTerminatedCString) {
			self.init(s)
			return
		}
		return nil
	}
	
	init(array: [Int8]) {
		let count = array.count
		let memory = UnsafeMutablePointer<UInt8>.allocate(capacity: count + 1)
		var index = 0
		for c in array {
			memory[index] = UInt8(bitPattern: c)
			index += 1
		}
		memory[count] = 0
		self.buffer = UnsafeMutableBufferPointer(start: memory, count: count)
	}
	
	init(array: [UInt8]) {
		let count = array.count
		let memory = UnsafeMutablePointer<UInt8>.allocate(capacity: count + 1)
		var index = 0
		for c in array {
			memory[index] = c
			index += 1
		}
		memory[count] = 0
		self.buffer = UnsafeMutableBufferPointer(start: memory, count: count)
	}
	
	init(buffer: UnsafeBufferPointer<UInt8>) {
		let count = buffer.count
		let memory = UnsafeMutablePointer<UInt8>.allocate(capacity: count + 1)
		var index = 0
		for c in buffer {
			memory[index] = c
			index += 1
		}
		memory[count] = 0
		self.buffer = UnsafeMutableBufferPointer(start: memory, count: count)
	}
	
	internal init(slice: Slice<UnsafeMutableBufferPointer<UInt8>>) {
		let count = slice.count
		let memory = UnsafeMutablePointer<UInt8>.allocate(capacity: count + 1)
		var index = slice.startIndex
		for c in slice {
			memory[index] = c
			index = slice.index(index, offsetBy: 1)
		}
		memory[count] = 0
		self.buffer = UnsafeMutableBufferPointer(start: memory, count: count)
	}
	
	init(fastString: FastString) {
		let count = fastString.buffer.count
		let memory = UnsafeMutablePointer<UInt8>.allocate(capacity: count + 1)
		var index = 0
		for c in fastString.buffer {
			memory[index] = c
			index += 1
		}
		memory[count] = 0
		self.buffer = UnsafeMutableBufferPointer(start: memory, count: count)
	}
	
	deinit {
		self.buffer.baseAddress!.deallocate()
	}

	func toString() -> String? {
		String(cString: buffer.baseAddress!)
	}
	
	func toArray() -> [UInt8] {
		return [UInt8](self.buffer)
	}
	
	var byteCount: Int {
		return self.buffer.count
	}
	
	var characterCount: Int {
		// TODO: cache last result
		var result: Int = 0
		for _ in self.makeCharacterIterator(replaceInvalid: "?") {
			result += 1
		}
		return result
	}
	
	func makeByteIterator() -> AnyIterator<UInt8> {
		var position = 0
		
		return AnyIterator {
			if position < self.buffer.count {
				let result = self.buffer[position]
				position += 1
				return result
			}
			return nil
		}
	}
	
	subscript(_ index: Int) -> UInt8? {
		if index < self.buffer.count {
			return self.buffer[index]
		}
		return nil
	}
	
	func makeCharacterIterator(replaceInvalid: Character? = nil) -> AnyIterator<Character> {
		var position = 0
		
		return AnyIterator {
			if position < self.buffer.count {
				// Check if we have an UTF8 sequence here
				let c0 = self.buffer[position]
				if c0 & 0x80 == 0 {
					// ASCII character
					position += 1
					return Character(UnicodeScalar(c0))
				} else if c0 & 0xe0 == 0xc0 {
					// Sequence of two
					if position + 1 < self.buffer.count {
						let c1 = self.buffer[position + 1]
						if c1 & 0xc0 == 0x80 {
							// byte 2 is valid, combine
							position += 2
							var value = UInt16(c1 & 0x3f)
							value += UInt16(c0 & 0x1f) << 6
							return Character(UnicodeScalar(value)!)
						}
					}
				} else if c0 & 0xf0 == 0xe0 {
					// Sequence of three
					if position + 2 < self.buffer.count {
						let c1 = self.buffer[position + 1]
						let c2 = self.buffer[position + 2]
						if c1 & 0xc0 == 0x80 && c2 & 0xc0 == 0x80 {
							// byte 2 and 3 are valid, combine
							position += 3
							var value = UInt32(c2 & 0x3f)
							value += UInt32(c1 & 0x3f) << 6
							value += UInt32(c0 & 0x1f) << 12
							return Character(UnicodeScalar(value)!)
						}
					}
				} else if c0 & 0xf8 == 0xf0 {
					// Sequence of four
					if position + 3 < self.buffer.count {
						let c1 = self.buffer[position + 1]
						let c2 = self.buffer[position + 2]
						let c3 = self.buffer[position + 3]
						if c1 & 0xc0 == 0x80 && c2 & 0xc0 == 0x80 && c3 & 0xc0 == 0x80 {
							// byte 2, 3 and 4 are valid, combine
							position += 4
							var value = UInt32(c3 & 0x3f)
							value += UInt32(c2 & 0x3f) << 6
							value += UInt32(c1 & 0x3f) << 12
							value += UInt32(c0 & 0x1f) << 18
							return Character(UnicodeScalar(value)!)
						}
					}
				}
				
				// Invalid
				if let replacement = replaceInvalid {
					return replacement
				}
				return nil // this ends the iterator
			}
			return nil
		}
	}
}

