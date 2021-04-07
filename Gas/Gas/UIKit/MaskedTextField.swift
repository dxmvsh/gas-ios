//
//  MaskedTextField.swift
//  Gas
//
//  Created by Strong on 4/1/21.
//

import UIKit

protocol MaskedTextFieldDelegate: class {
    func textFieldShouldBeginEditing(_ textField: MaskedTextfield) -> Bool
    func textFieldDidBeginEditing(_ textField: MaskedTextfield)
    func textFieldShouldEndEditing(_ textField: MaskedTextfield) -> Bool
    func textFieldDidEndEditing(_ textField: MaskedTextfield)
    func textFieldDidEndEditing(_ textField: MaskedTextfield, reason: UITextField.DidEndEditingReason)
    func textFieldDidChangeSelection(_ textField: MaskedTextfield)
    func textFieldShouldClear(_ textField: MaskedTextfield) -> Bool
    func textFieldShouldReturn(_ textField: MaskedTextfield) -> Bool
    func textFieldDidChange(_ textField: MaskedTextfield)
}

extension MaskedTextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: MaskedTextfield) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: MaskedTextfield) {}
    func textFieldShouldEndEditing(_ textField: MaskedTextfield) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: MaskedTextfield) {}
    func textFieldDidEndEditing(_ textField: MaskedTextfield, reason: UITextField.DidEndEditingReason) {}
    func textFieldDidChangeSelection(_ textField: MaskedTextfield) {}
    func textFieldShouldClear(_ textField: MaskedTextfield) -> Bool { return true }
    func textFieldShouldReturn(_ textField: MaskedTextfield) -> Bool { return true }
    func textFieldDidChange(_ textField: MaskedTextfield) {}
}

class MaskedTextfield: UITextField {
    
// MARK: - Properties
    
    private let lettersAndDigitsReplacementChar: String = "*"
    private let anyLetterReplacementChar: String = "@"
    private let lowerCaseLetterReplacementChar: String = "a"
    private let upperCaseLetterReplacementChar: String = "A"
    private let digitsReplacementChar: String = "#"
    private var allReplacements: [String] = []
    
    /**
     Var that holds the format pattern that you wish to apply
     to some text
     
     If the pattern is set to "" no mask would be applied and
     the textfield would behave like a normal one
     */
    private var formatPattern: String = ""
    
    /**
     Var that holds the prefix to be added to the textfield
     
     If the prefix is set to "" no string will be added to the beggining
     of the text
     */
    private var prefix: String = ""
    
    /**
     Var that holds the suffix to be added to the textfield
     
     If the suffix is set to "" no string will be added to the end
     of the text
     */
    private var suffix: String = ""
    
    /**
     var that holds character for filler placeholder
        
     Default value is as provided
     */
    private var placeholderChar: String = "_"
    /**
     Var that have the maximum length, based on the mask set
     */
    open var maxLength: Int {
        get {
            let string = formatPattern + prefix + suffix
            return string.whitespaceless.count
        }
    }
    
    public var customMaxLength: Int?
    
    /**
     Var that have the filler placeholder, based on the mask set
     */
    private var fillerPlaceholder: String {
        get {
            var string = "\(prefix)\(formatPattern)\(suffix)"
            allReplacements.forEach {
                string = string.replacingOccurrences(of: $0, with: placeholderChar)
            }
            return string
        }
    }
    /**
     Regular expression which defines enabled symbols to use
     */
    public var allowedSymbolsRegex: String?
    
    /**
     var that have real string, based on the mask set
     */
    private var realString: String = ""
    
    /**
     var to access real text to export
     */
    public var publicRealString: String {
        get {
            return realString
        }
    }
    
    /**
     The receiver’s delegate
     */
    open weak var maskedDelegate: MaskedTextFieldDelegate?
    
// MARK: - Constructors
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    init(prefix: String,
         suffix: String,
         formatPattern: String,
         placeholderChar: String = "",
         allowedSymbolsRegex: String? = nil) {
        super.init(frame: .zero)
        allReplacements = [lettersAndDigitsReplacementChar, anyLetterReplacementChar,
        lowerCaseLetterReplacementChar, upperCaseLetterReplacementChar, digitsReplacementChar]
        self.prefix = prefix
        self.suffix = suffix
        self.formatPattern = formatPattern
        self.placeholderChar = placeholderChar == "" ? self.placeholderChar : placeholderChar
        self.allowedSymbolsRegex = allowedSymbolsRegex
        setAttributedText()
        self.setup()
    }
    
// MARK: - Private Methods
    
    fileprivate func setup() {
        delegate = self
    }
    
    private func getOnlyDigitsString(_ string: String) -> String {
        let charactersArray = string.components(separatedBy: CharacterSet.decimalDigits.inverted)
        return charactersArray.joined(separator: "")
    }
    
    private func getOnlyLettersString(_ string: String) -> String {
        let charactersArray = string.components(separatedBy: CharacterSet.letters.inverted)
        return charactersArray.joined(separator: "")
    }
    
    private func getUppercaseLettersString(_ string: String) -> String {
        let charactersArray = string.components(separatedBy: CharacterSet.uppercaseLetters.inverted)
        return charactersArray.joined(separator: "")
    }
    
    private func getLowercaseLettersString(_ string: String) -> String {
        let charactersArray = string.components(separatedBy: CharacterSet.lowercaseLetters.inverted)
        return charactersArray.joined(separator: "")
    }
    
    private func getFilteredString(_ string: String) -> String {
        let charactersArray = string.components(separatedBy: CharacterSet.alphanumerics.inverted)
        return charactersArray.joined(separator: "")
    }
    
    private func getStringWithoutPrefixAndSuffix(_ string: String) -> String {
        var resultString = string
        var prefixIndex: String.Index?
        var suffixIndex: String.Index?
        if string.range(of: self.prefix) != nil {
            prefixIndex = string.index(
                string.startIndex,
                offsetBy: self.prefix.count
            )
        }
        if let prefixIndex = prefixIndex {
            resultString = String(resultString[prefixIndex...])
        }
        if resultString.range(of: self.suffix) != nil {
            suffixIndex = resultString.index(
                resultString.endIndex,
                offsetBy: (self.suffix.count) * -1
            )
        }
        if let suffixIndex = suffixIndex {
            resultString = String(resultString[...suffixIndex])
        }
        return resultString
    }
    
// MARK: - Self Public Methods
    
    /**
     Func that formats the text based on formatPattern
     
     Override this function if you want to customize the behaviour of
     the class
     */
    // swiftlint:disable cyclomatic_complexity
    private func formatText(string: String) {
        var currentTextForFormatting = ""
        if string.count > 0 {
            currentTextForFormatting = self.getStringWithoutPrefixAndSuffix(string)
        }
        
        let length = self.customMaxLength ?? self.maxLength
        
        if length > 0, !self.formatPattern.isEmpty {
            var formatterIndex = self.formatPattern.startIndex, currentTextForFormattingIndex = currentTextForFormatting.startIndex
            var finalText = ""
            
            currentTextForFormatting = self.getFilteredString(currentTextForFormatting)
            
            if currentTextForFormatting.count > 0 {
                while true {
                    let formatPatternRange = formatterIndex ..< formatPattern.index(after: formatterIndex)
                    let currentFormatCharacter = String(self.formatPattern[formatPatternRange])
                    
                    let currentTextForFormattingPatterRange = currentTextForFormattingIndex ..< currentTextForFormatting.index(after: currentTextForFormattingIndex)
                    let currentTextForFormattingCharacter = String(currentTextForFormatting[currentTextForFormattingPatterRange])
                    
                    switch currentFormatCharacter {
                        case lettersAndDigitsReplacementChar:
                            finalText += currentTextForFormattingCharacter
                            currentTextForFormattingIndex = currentTextForFormatting.index(after: currentTextForFormattingIndex)
                            formatterIndex = formatPattern.index(after: formatterIndex)
                        case anyLetterReplacementChar:
                            let filteredChar = self.getOnlyLettersString(currentTextForFormattingCharacter)
                            if !filteredChar.isEmpty {
                                finalText += filteredChar
                                formatterIndex = formatPattern.index(after: formatterIndex)
                            }
                            currentTextForFormattingIndex = currentTextForFormatting.index(after: currentTextForFormattingIndex)
                        case lowerCaseLetterReplacementChar:
                            let filteredChar = self.getLowercaseLettersString(currentTextForFormattingCharacter)
                            if !filteredChar.isEmpty {
                                finalText += filteredChar
                                formatterIndex = formatPattern.index(after: formatterIndex)
                            }
                            currentTextForFormattingIndex = currentTextForFormatting.index(after: currentTextForFormattingIndex)
                        case upperCaseLetterReplacementChar:
                            let filteredChar = self.getUppercaseLettersString(currentTextForFormattingCharacter)
                            if !filteredChar.isEmpty {
                                finalText += filteredChar
                                formatterIndex = formatPattern.index(after: formatterIndex)
                            }
                            currentTextForFormattingIndex = currentTextForFormatting.index(after: currentTextForFormattingIndex)
                        case digitsReplacementChar:
                            let filteredChar = self.getOnlyDigitsString(currentTextForFormattingCharacter)
                            if !filteredChar.isEmpty {
                                finalText += filteredChar
                                formatterIndex = formatPattern.index(after: formatterIndex)
                            }
                            currentTextForFormattingIndex = currentTextForFormatting.index(after: currentTextForFormattingIndex)
                        default:
                            finalText += currentFormatCharacter
                            formatterIndex = formatPattern.index(after: formatterIndex)
                    }
                    
                    if formatterIndex >= self.formatPattern.endIndex ||
                        currentTextForFormattingIndex >= currentTextForFormatting.endIndex {
                        break
                    }
                }
            }
            
            if finalText.count > 0 {
                realString = "\(self.prefix)\(finalText)"
            } else {
                realString = finalText
            }
        } else if length > 0 {
            realString = string.substr(0, length)
        } else {
            realString = string
        }
        if let allowedSymbolsRegex = allowedSymbolsRegex {
            let disabledSymbolsRegex = "[^\(allowedSymbolsRegex)]"
            realString = realString.replacingOccurrences(
                of: disabledSymbolsRegex, with: "", options: .regularExpression)
        }
        setAttributedText()
        setCurrentCursorPosition()
    }
    
    private func setAttributedText() {
        let prefixString = realString.count == 0 ? prefix : realString
        let attributedRealString = NSAttributedString(string: prefixString,
                                                      attributes: [NSAttributedString.Key.kern: -0.41,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.black])
        let attributedResultString = NSMutableAttributedString(attributedString: attributedRealString)
        if fillerPlaceholder.count - prefixString.count >= 0 {
            var placeholderString = String(fillerPlaceholder.suffix(fillerPlaceholder.count - prefixString.count))
            // TODO: - remove when fixed
            if placeholderString.count >= suffix.count {
                placeholderString = String(placeholderString.prefix(placeholderString.count - suffix.count))
            }
            
            let attributedFillerPlaceholderString = NSAttributedString(
                string: placeholderString,
                attributes: [NSAttributedString.Key.kern: 1.4,
                            NSAttributedString.Key.foregroundColor: Color.gray])
            attributedResultString.append(attributedFillerPlaceholderString)
            
        }
        let suffixAttributedString = NSAttributedString(
            string: suffix,
            attributes: [NSAttributedString.Key.kern: -0.41,
                         NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedResultString.append(suffixAttributedString)
        attributedText = attributedResultString
    }
    
    open override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        let res = super.becomeFirstResponder()
        setAttributedText()
        setCurrentCursorPosition()
        return res
    }
    
    open override func resignFirstResponder() -> Bool {
        let res = super.resignFirstResponder()
        if isEmpty() {
            self.attributedText = NSAttributedString(string: "")
        }
        return res
    }
    
    // method to get if real value is empty
    public func isEmpty() -> Bool {
        return realString.count == 0
    }
    
    // method for setting cursor based on mask
    private func setCurrentCursorPosition() {
        let arbitraryValue: Int = realString.count < prefix.count ? prefix.count : realString.count
        if let newPosition = position(from: beginningOfDocument,
                                      offset: arbitraryValue) {
            selectedTextRange = textRange(from: newPosition,
                                          to: newPosition)
        }
    }
    
    public func clear() {
        realString = ""
        setAttributedText()
        setCurrentCursorPosition()
        textChanged()
        maskedDelegate?.textFieldDidChange(self)
    }
    
    func setText(_ text: String) {
        realString = text
        formatText(string: realString)
        self.text = realString
        textChanged()
        maskedDelegate?.textFieldDidChange(self)
    }
    /**
     method must be overrided by subclasses
     */
    func textChanged() {}
}

// MARK: - UITextFieldDelegate methods

extension MaskedTextfield: UITextFieldDelegate {
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return maskedDelegate?.textFieldShouldBeginEditing(self) ?? true
    }
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        maskedDelegate?.textFieldDidBeginEditing(self)
    }
    
    open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return maskedDelegate?.textFieldShouldEndEditing(self) ?? true
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
        maskedDelegate?.textFieldDidEndEditing(self)
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        maskedDelegate?.textFieldDidEndEditing(self, reason: reason)
    }
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count == 0 && range.length > 0 && realString.count > 0 {
            realString.removeLast()
        } else {
            realString += string
        }
        formatText(string: realString)
        textChanged()
        maskedDelegate?.textFieldDidChange(self)
        return false
    }
    
    open func textFieldDidChangeSelection(_ textField: UITextField) {
        maskedDelegate?.textFieldDidChangeSelection(self)
    }
    
    open func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return maskedDelegate?.textFieldShouldClear(self) ?? true
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return maskedDelegate?.textFieldShouldReturn(self) ?? true
    }
}
