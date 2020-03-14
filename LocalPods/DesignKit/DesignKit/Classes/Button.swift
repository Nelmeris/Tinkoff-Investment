//
//  Button.swift
//  Pods-UIViewKit_Example
//
//  Created by Artem Kufaev on 03.03.2020.
//

import UIUtils

@IBDesignable
open class Button: UIButton {
    
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
    
    private func configureUI() {
        self.layer.cornerRadius = 15
        self.titleLabel?.textColor = .black
        self.backgroundColor = .systemYellow
        self.setTitleColor(.black, for: .normal)
        self.setBackgroundColor(color: .systemYellow, forState: .normal)
        self.setBackgroundColor(color: .lightGray, forState: .disabled)
    }
    
}
