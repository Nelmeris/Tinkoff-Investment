//
//  PincodeView.swift
//  Pods-UIViewKit_Example
//
//  Created by Artem Kufaev on 03.03.2020.
//

@IBDesignable
open class PincodeView: UIStackView {
    
    // MARK: - IBInspectable properties
    
    typealias Dot = UIView
    
    @IBInspectable
    public var dotCount: Int = 4 {
        didSet {
            if oldValue != dotCount { setupDots() }
        }
    }
    
    @IBInspectable
    public var filledDotColor: UIColor = .systemYellow {
        didSet { recolorDots() }
    }
    
    @IBInspectable
    public var emptyDotColor: UIColor = .lightGray {
        didSet { recolorDots() }
    }
    
    // MARK: - Subviews
    
    /// Reversed list
    private(set) var emptyDots: [Dot] = []
    private(set) var filledDots: [Dot] = []
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        setupDefaults()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupDefaults()
    }
    
    // MARK: - Configure
    
    private func setupDefaults() {
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.alignment = .center
        setupDots()
    }
    
    private func setupDots() {
        emptyDots.forEach { $0.removeFromSuperview() }
        emptyDots.removeAll()
        filledDots.forEach { $0.removeFromSuperview() }
        filledDots.removeAll()
        guard dotCount >= 1 else { return }
        for _ in 1...dotCount {
            let dot = Dot()
            self.addArrangedSubview(dot)
            configureDot(dot)
            self.emptyDots.append(dot)
        }
        self.emptyDots.reverse()
    }

}

// MARK: - Private
extension PincodeView {
    
    private func configureDot(_ dot: Dot) {
        dot.backgroundColor = emptyDotColor
        dot.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dot.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            dot.widthAnchor.constraint(equalTo: dot.heightAnchor)
        ])
        dot.layer.cornerRadius = self.bounds.height / 2
    }
    
    private func recolorDots() {
        emptyDots.forEach { $0.backgroundColor = emptyDotColor }
        filledDots.forEach { $0.backgroundColor = filledDotColor }
    }
    
    private func recolorDot(_ dot: Dot, color: UIColor,
                            animated: Bool,
                            duration: TimeInterval = 0.1,
                            completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, animations: {
                dot.backgroundColor = color
            }) { _ in completion?() }
        } else {
            dot.backgroundColor = color
            completion?()
        }
    }
    
}

// MARK: - Public
extension PincodeView {
    
    public func fillNextDot(animated: Bool = false) {
        guard let dot = emptyDots.popLast() else { return }
        recolorDot(dot, color: filledDotColor, animated: animated)
        filledDots.append(dot)
    }
    
    public func emptyLastDot(animated: Bool = false) {
        guard let dot = filledDots.popLast() else { return }
        recolorDot(dot, color: emptyDotColor, animated: animated)
        emptyDots.append(dot)
    }
    
    public func emptyAllDots(animated: Bool = false) {
        guard let dot = filledDots.popLast() else { return }
        emptyDots.append(dot)
        recolorDot(dot, color: emptyDotColor, animated: animated, duration: 0.05) {
            self.emptyAllDots(animated: animated)
        }
    }
    
}
