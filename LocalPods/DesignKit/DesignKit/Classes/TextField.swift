//
//  TextField.swift
//  Pods-UIViewKit_Example
//
//  Created by Artem Kufaev on 03.03.2020.
//

@IBDesignable
open class TextField: UITextField {
    
    // MARK: - Properties
    
    @IBInspectable
    public var underLineWidth: CGFloat = 0.5 {
        didSet {
            updateUnderLineFrame()
        }
    }
    
    @IBInspectable
    public var underLineColor: UIColor = .lightGray {
        didSet {
            updateUnderLineUI()
        }
    }
    
    private lazy var underLine = CALayer()
    
    /// Sets left margin
    @IBInspectable
    public var leftMargin: CGFloat = 5.0 {
        didSet {
            setLeftMargin()
            updateAccessoryViewFrame()
        }
    }
    
    /// Sets right margin
    @IBInspectable
    public var rightMargin: CGFloat = 5.0 {
        didSet {
            setRightMargin()
            updateAccessoryViewFrame()
        }
    }
    
    // MARK: - Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureUI()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        applyUnderLine()
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        self.borderStyle = .none
        applyUnderLine()
        setMargins()
    }
    
    private func applyUnderLine() {
        underLine.removeFromSuperlayer()
        updateUnderLineFrame()
        updateUnderLineUI()
        layer.addSublayer(underLine)
        layer.masksToBounds = true
    }
    
    private func updateUnderLineFrame() {
        var rect = bounds
        rect.origin.y = bounds.height - underLineWidth
        rect.size.height = underLineWidth
        underLine.frame = rect
    }
    
    private func updateUnderLineUI() {
        underLine.backgroundColor = underLineColor.cgColor
    }
    
    // MARK: - Margins
    private var leftAcessoryView = UIView()
    private var rightAcessoryView = UIView()
    
    private func setMargins() {
        setLeftMargin()
        setRightMargin()
        updateAccessoryViewFrame()
    }
    
    private func setLeftMargin() {
        leftView = nil
        leftViewMode = .never
        guard leftMargin > 0 else { return }
        leftAcessoryView.backgroundColor = .clear
        leftView = leftAcessoryView
        leftViewMode = .always
    }
    
    private func setRightMargin() {
        rightView = nil
        rightViewMode = .never
        guard rightMargin > 0 else { return }
        rightAcessoryView.backgroundColor = .clear
        rightView = rightAcessoryView
        rightViewMode = .always
    }
    
    private func updateAccessoryViewFrame() {
        // Left View Frame
        var leftRect = bounds
        leftRect.size.width = leftMargin
        leftAcessoryView.frame = leftRect
        // Right View Frame
        var rightRect = bounds
        rightRect.size.width = rightMargin
        rightAcessoryView.frame = rightRect
    }
    
}
