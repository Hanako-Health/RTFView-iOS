/**
Characters.swift
RTFView

Created by Marco Seidel on 28.08.20.

Characters represents all the special characters used to detect formatting tags.
Sigh, wish public was the default visibility.
*/
public struct Characters {
	
	public let start: Character
	public let end: Character
	public let parameter: Character
	public let close: Character
	
	public init(
		start: Character = "[",
		end: Character = "]",
		parameter: Character = "=",
		close: Character = "/"
	) {
		self.start = start
		self.end = end
		self.parameter = parameter
		self.close = close
	}
	
}
