//
//  LabeledTextField.swift
//  Gas
//
//  Created by Strong on 4/11/21.
//

import UIKit

fileprivate enum Constants {
    enum UI {
        static let inputHeight: CGFloat = 22.0
        static let topPadding: CGFloat = 20.0
        static let interPadding: CGFloat = 4.0
        static let titleFadeInDuration: TimeInterval = 0.3
        static let errorPadding: CGFloat = 10.0
        static let rightViewSize: CGFloat = 24.0
        static let leftViewSize: CGFloat = 40.0
    }
}

protocol CommentShowing {
    func showComment(_ text: String, textColor: UIColor)
    func hideComment()
}

protocol ErrorShowing {
    func showError(_ errorMessage: String)
    func hideError()
}

class LabeledTextField: MaskedTextfield {
    public weak var clearableDelegate: ClearableDelegate?
    open var title: String? {
        didSet {
            titleLabel.text = title
            placeholderText = title
        }
    }
    private var titleHeight: CGFloat {
        return titleLabel.font.lineHeight
    }
    private var inputTextHeight: CGFloat {
        return self.font?.lineHeight ?? Constants.UI.inputHeight
    }
    private var additionalLeftPadding: CGFloat {
        guard let width = leftView?.frame.size.width else { return 0 }
        return width + LayoutGuidance.offset
    }
    private var additionalRightPadding: CGFloat {
        guard let width = rightView?.frame.size.width else { return 0 }
        return width + LayoutGuidance.offset
    }
    private var errorTextHeight: CGFloat {
        let height = self.errorMessageLabel.text?.height(
            withConstrainedWidth: self.bounds.width - 2 * LayoutGuidance.offset,
            font: .regular(ofSize: 13)
        ) ?? .zero
        return height
    }
    private var commentTextHeight: CGFloat {
        let height = self.commentMessageLabel.text?.height(
            withConstrainedWidth: self.bounds.width - 2 * LayoutGuidance.offset,
            font: .regular(ofSize: 13)
        ) ?? .zero
        return height + 4
    }
    private var isTitleVisible: Bool {
        return self.isFirstResponder || !(text?.isEmpty ?? true)
    }
    private var isErrorTextShown: Bool {
        return !(errorMessageLabel.text ?? "").isEmpty
    }
    private var isCommentTextShown: Bool {
        return !(commentMessageLabel.text ?? "").isEmpty
    }
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    private var placeholderText: String? {
        didSet {
            if let text = placeholderText {
                attributedPlaceholder = NSAttributedString(
                    string: text,
                    attributes: [NSAttributedString.Key.foregroundColor: Color.gray]
                )
            } else {
                attributedPlaceholder = nil
            }
        }
    }
    private var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.red
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    private(set) var commentMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.darkGray
        label.numberOfLines = 0
        label.font = UIFont.regular(ofSize: 13.0)
        return label
    }()
    
    private var indicator: UIView & IndicatorProtocol = UIActivityIndicatorView(style: .gray)
    fileprivate var isPastingAvailable = true
    private var editingActions: [EditingAction]?
    var isEditable: Bool = true
    var isErrorShown: Bool {
        return isErrorTextShown
    }
    var isErrorCommentShown: Bool {
        return isCommentShown && commentMessageLabel.textColor == Color.red
    }
    var isCommentShown: Bool {
        return isCommentTextShown
    }
    // TODO: - review using this value
    /// returns if a superview has a value to validate
    /// for ex: AccountPicker has LabeledTextfield as a property, but a value is in AccountPickableView
    /// by default is 'false'
    var hasValueInComposedView = false
    
    convenience init() {
        self.init(title: "")
        resignFirstResponder()
    }
    
    required init(title: String = "",
                  prefix: String = "",
                  suffix: String = "",
                  formatPattern: String = "",
                  placeholderChar: String = "",
                  allowedSymbolsRegex: String? = nil,
                  editingActions: [EditingAction]? = [.copy, .paste]) {
        self.title = title
        self.editingActions = editingActions
        super.init(prefix: prefix,
                   suffix: suffix,
                   formatPattern: formatPattern,
                   placeholderChar: placeholderChar,
                   allowedSymbolsRegex: allowedSymbolsRegex)
        titleLabel.text = title
        placeholderText = title
        attributedPlaceholder = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.foregroundColor: Color.darkGray])
        font = UIFont.systemFont(ofSize: 17)
        tintColor = Color.gray
        layer.cornerRadius = LayoutGuidance.cornerRadius
        [titleLabel, errorMessageLabel, commentMessageLabel, indicator].forEach {
            addSubview($0)
        }
        resignFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI functions
    
    open func getRectForText(_ bounds: CGRect) -> CGRect {
        let top = (LayoutGuidance.offsetHalf + titleHeight + Constants.UI.interPadding)
        let bottom = LayoutGuidance.offsetHalf +
            (isErrorTextShown ? errorTextHeight : 0.0) +
            (isCommentTextShown ? commentTextHeight : 0.0)
        return bounds.inset(by: UIEdgeInsets(top: top,
                                             left: additionalLeftPadding,
                                             bottom: bottom,
                                             right: LayoutGuidance.offset + additionalRightPadding))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var y = bounds.height - inputTextHeight
        y = isCommentTextShown ? y - commentTextHeight : y
        y = (isErrorTextShown ? y - errorTextHeight : y) / 2.0
        return CGRect(x: additionalLeftPadding,
                      y: y,
                      width: bounds.width - LayoutGuidance.offset * 2.0 - additionalRightPadding - additionalLeftPadding,
                      height: inputTextHeight)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return getRectForText(bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return getRectForText(bounds)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return getRectForRightView(bounds)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return getRectForLeftView(bounds)
    }
    
    private func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        let yPadding = editing ? LayoutGuidance.offsetHalf : Constants.UI.topPadding
        return CGRect(x: additionalLeftPadding,
                      y: yPadding,
                      width: bounds.size.width - LayoutGuidance.offsetDouble - additionalLeftPadding - additionalRightPadding,
                      height: titleHeight)
    }
    
    internal func errorRectForBounds(_ bounds: CGRect) -> CGRect {
        if isErrorTextShown {
            return CGRect(x: 0,
                          y: LayoutGuidance.offsetHalf + titleHeight + Constants.UI.interPadding + inputTextHeight + Constants.UI.errorPadding + LayoutGuidance.offsetQuarter,
                          width: bounds.width,
                          height: errorTextHeight)
        }
        return .zero
    }
    
    internal func commentRectForBounds(_ bounds: CGRect) -> CGRect {
        if isCommentTextShown {
            let commentLabelY = LayoutGuidance.offsetHalf + titleHeight + Constants.UI.interPadding + inputTextHeight + Constants.UI.errorPadding + LayoutGuidance.offsetQuarter
            let additionalY = isErrorTextShown ? errorTextHeight + LayoutGuidance.offsetQuarter : 0
            return CGRect(
                x: 0,
                y: commentLabelY + additionalY,
                width: bounds.width,
                height: commentTextHeight)
        }
        return .zero
    }
    
    private func getRectForLeftView(_ bounds: CGRect) -> CGRect {
        let x = LayoutGuidance.offset
        var height = isErrorTextShown ? bounds.height - errorTextHeight : bounds.height
        height = isCommentTextShown ? height - commentTextHeight : height
        let y = (height - Constants.UI.leftViewSize) / 2
        let leftViewBounds = CGRect(x: x,
                                     y: y,
                                     width: Constants.UI.leftViewSize,
                                     height: Constants.UI.leftViewSize)
        return leftViewBounds
    }

    private func getRectForRightView(_ bounds: CGRect) -> CGRect {
        let x = bounds.width - Constants.UI.rightViewSize - LayoutGuidance.offset
        var height = isErrorTextShown ? bounds.height - errorTextHeight : bounds.height
        height = isCommentTextShown ? height - commentTextHeight : height
        let y = (height - Constants.UI.rightViewSize) / 2
        let rightViewBounds = CGRect(x: x,
                                     y: y,
                                     width: Constants.UI.rightViewSize,
                                     height: Constants.UI.rightViewSize)
        return rightViewBounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateTitleVisibility(animated: false)
        errorMessageLabel.frame = errorRectForBounds(bounds)
        commentMessageLabel.frame = commentRectForBounds(bounds)
        indicator.frame = getRectForRightView(bounds)
    }
    
    private func updateTitleVisibility(animated: Bool = true) {
        let alpha: CGFloat = self.isTitleVisible ? 1.0 : 0.0
        let frame = self.titleLabelRectForBounds(self.bounds, editing: self.isTitleVisible)
        let errorLabelFrame = self.errorRectForBounds(self.bounds)
        let commentLabelFrame = self.commentRectForBounds(self.bounds)
        let updateBlock = { () -> Void in
            self.titleLabel.alpha = alpha
            self.titleLabel.frame = frame
            self.titleLabel.textColor = Color.gray
            self.errorMessageLabel.frame = errorLabelFrame
            self.commentMessageLabel.frame = commentLabelFrame
            if !self.isEnabled {
                self.textColor = Color.gray
            }
        }
        if !animated {
            updateBlock()
            return
        }
        let animationOptions: UIView.AnimationOptions = .curveEaseOut
        UIView.animate(
            withDuration: Constants.UI.titleFadeInDuration, delay: 0,
            options: animationOptions, animations: {
                updateBlock()
            }
        )
    }
   
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        if !isEditable {
            return false
        }
        let res = super.becomeFirstResponder()
        placeholderText = nil
        updateTitleVisibility()
        return res
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        let res = super.resignFirstResponder()
        placeholderText = title
        updateTitleVisibility()
        return res
    }
    
    override var intrinsicContentSize: CGSize {
        let width = super.intrinsicContentSize.width
        var height: CGFloat = LayoutGuidance.offsetHalf + titleHeight +
            Constants.UI.interPadding + inputTextHeight + Constants.UI.errorPadding
        if isErrorTextShown {
            height += errorTextHeight + LayoutGuidance.offsetQuarter
        }
        if isCommentTextShown {
            height += commentTextHeight + LayoutGuidance.offsetQuarter
        }
        return CGSize(width: width, height: height)
    }
    
    override func textChanged() {
        hideError()
    }
    
    private func addErrorBorder() {
        borderLayer.fillColor = Color.red.cgColor
        borderLayer.strokeColor = Color.red.cgColor
    }
   
    private func hideErrorBorder() {
        borderLayer.fillColor = Color.lineGray.cgColor
        borderLayer.strokeColor = UIColor.clear.cgColor
    }
    
    func startLoading() {
        rightView?.isHidden = true
        indicator.isHidden = false
        isUserInteractionEnabled = false
        indicator.startAnimating()
    }
    
    func stopLoading() {
        indicator.stopAnimating()
        indicator.isHidden = true
        rightView?.isHidden = false
        isUserInteractionEnabled = true
    }
    
    func showViewError(_ errorMessage: String) {
        showError(errorMessage)
    }
    
    func hideViewError() {
        hideError()
    }
    
}

extension LabeledTextField: ErrorShowing {
    func showError(_ errorMessage: String) {
        errorMessageLabel.text = errorMessage
        errorMessageLabel.frame = errorRectForBounds(bounds)
        addErrorBorder()
        invalidateIntrinsicContentSize()
    }
    
    func hideError() {
        errorMessageLabel.text = nil
        errorMessageLabel.frame = errorRectForBounds(bounds)
        hideErrorBorder()
        invalidateIntrinsicContentSize()
    }
}

extension LabeledTextField: CommentShowing {
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        guard let editingActions = editingActions else {
            return true
        }
        for editingAction in editingActions {
            if action == Selector(editingAction.selectorId) {
                return true
            }
        }
        return false
    }
    
    func showComment(_ text: String, textColor: UIColor = Color.darkGray) {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        attributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length))
        commentMessageLabel.attributedText = attributedString
        commentMessageLabel.frame = commentRectForBounds(bounds)
        commentMessageLabel.textColor = textColor
        invalidateIntrinsicContentSize()
    }
    
    func hideComment() {
        commentMessageLabel.text = nil
        commentMessageLabel.attributedText = nil
        commentMessageLabel.frame = commentRectForBounds(bounds)
        invalidateIntrinsicContentSize()
    }
}
