//
//  VerticalScrollView.swift
//  Pods-UIViewKit_Example
//
//  Created by Artem Kufaev on 25.02.2020.
//

import Foundation

@IBDesignable
open class VerticalScrollView: UIScrollView {
    
    // MARK: - Subviews
    
    public private(set) lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configureUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        configureUI()
    }
    
    // MARK: - Actions
    
    open func addContentSubview(_ view: UIView) {
        self.contentView.addSubview(view)
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        self.bounces = true
        self.alwaysBounceVertical = true
    }
    
    private func setupLayout() {
        super.addSubview(contentView)
        self.setConstraints()
    }
    
    private func setConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        let heightConstraint = self.contentView.heightAnchor.constraint(equalTo: safeArea.heightAnchor)
        heightConstraint.priority = .init(rawValue: 999)
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            heightConstraint
        ])
    }
    
}
