//
//  AuthLoginView.swift
//  AuthLoginScreen
//
//  Created by Artem Kufaev on 23.02.2020.
//

import DesignKit

public class AuthLoginView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Авторизуйтесь"
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var loginField: TextField = {
        let field = TextField()
        field.placeholder = "Login"
        field.textContentType = .username
        field.tag = 0
        field.returnKeyType = .next
        return field
    }()
    
    private(set) lazy var passwordField: TextField = {
        let field = TextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.textContentType = .password
        field.tag = 1
        field.returnKeyType = .done
        return field
    }()
    
    private(set) lazy var loginButton: Button = {
        let button = Button(type: .system)
        button.setTitle("Войти", for: .normal)
        button.isEnabled = false
        return button
    }()
    
    private(set) lazy var isSetPinCheckbox = Checkbox()
    
    private(set) lazy var isSetPinLabel: UILabel = {
        let label = UILabel()
        label.text = "Задать PIN"
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(isSetPinLabelTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(gestureRecognizer)
        return label
    }()
    
    private(set) lazy var scrollView = VerticalScrollView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    // MARK: - Actions
    
    @objc
    private func isSetPinLabelTapped() {
        isSetPinCheckbox.isChecked = !isSetPinCheckbox.isChecked
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        self.backgroundColor = .white
    }
    
    private func setupLayout() {
        self.addSubview(scrollView)
        scrollView.addContentSubview(titleLabel)
        scrollView.addContentSubview(loginField)
        scrollView.addContentSubview(passwordField)
        scrollView.addContentSubview(loginButton)
        scrollView.addContentSubview(isSetPinCheckbox)
        scrollView.addContentSubview(isSetPinLabel)
        configureUI()
        setupConstraints()
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 20.0
        let safeArea = self.safeAreaLayoutGuide
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        loginField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        isSetPinCheckbox.translatesAutoresizingMaskIntoConstraints = false
        isSetPinLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.contentView.topAnchor, constant: padding),
            titleLabel.leftAnchor.constraint(equalTo: scrollView.contentView.leftAnchor, constant: padding),
            titleLabel.rightAnchor.constraint(equalTo: scrollView.contentView.rightAnchor, constant: padding * 2),
            
            loginField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            loginField.leftAnchor.constraint(equalTo: scrollView.contentView.leftAnchor, constant: padding),
            loginField.centerXAnchor.constraint(equalTo: scrollView.contentView.centerXAnchor),
            loginField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: padding),
            passwordField.leftAnchor.constraint(equalTo: loginField.leftAnchor),
            passwordField.centerXAnchor.constraint(equalTo: scrollView.contentView.centerXAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            isSetPinCheckbox.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: padding),
            isSetPinCheckbox.leftAnchor.constraint(equalTo: passwordField.leftAnchor),
            isSetPinCheckbox.heightAnchor.constraint(equalToConstant: 25),
            isSetPinCheckbox.widthAnchor.constraint(equalToConstant: 25),
            
            isSetPinLabel.centerYAnchor.constraint(equalTo: isSetPinCheckbox.centerYAnchor),
            isSetPinLabel.leftAnchor.constraint(equalTo: isSetPinCheckbox.rightAnchor, constant: 10),
            isSetPinLabel.rightAnchor.constraint(equalTo: scrollView.contentView.rightAnchor, constant: -padding),
            
            loginButton.topAnchor.constraint(equalTo: isSetPinCheckbox.bottomAnchor, constant: padding),
            loginButton.centerXAnchor.constraint(equalTo: scrollView.contentView.centerXAnchor),
            loginButton.leftAnchor.constraint(equalTo: scrollView.contentView.leftAnchor, constant: padding),
            loginButton.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.contentView.bottomAnchor, constant: -padding),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
