//
//  SpinnerView.swift
//  Pods-UIViewKit_Example
//
//  Created by Artem Kufaev on 03.03.2020.
//

open class SpinnerView: UIView {
    
    // MARK: - Subviews
    
    public private(set) lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            indicator.style = .large
        } else {
            indicator.style = .gray
        }
        return indicator
    }()
    
    public private(set) lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    // MARK: - Configure
    
    private func setupLayout() {
        self.addSubview(blurView)
        self.addSubview(indicatorView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.blurView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.blurView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.blurView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            self.blurView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            self.indicatorView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.indicatorView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
    
}
