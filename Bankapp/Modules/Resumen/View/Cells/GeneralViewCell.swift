//
//  GeneralViewCell.swift
//  Bankapp
//
//  Created by Erik Ciau on 23/08/23.
//

import UIKit
final class GeneralHeaderViewCell: UICollectionReusableView, ClassIdentifier {
    private var btnShowMyAccounts: UIButton = {
        let button = UIButton()
        button.setTitle("Mis cuentas", for: .normal)
        button.titleLabel?.font = .setFont(size: .l, weight: .semibold)
        button.setTitleColor(.setColorFont(.primaryBackground), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var btnSendMoney: UIButton = {
        let button = UIButton()
        button.setTitle("Enviar dinero", for: .normal)
        button.titleLabel?.font = .setFont(size: .l, weight: .semibold)
        button.setTitleColor(.setColorFont(.primaryBackground), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        addSubview(btnShowMyAccounts)
        addSubview(btnSendMoney)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            btnShowMyAccounts.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            btnShowMyAccounts.centerYAnchor.constraint(equalTo: centerYAnchor),
            btnSendMoney.leadingAnchor.constraint(equalTo: btnShowMyAccounts.trailingAnchor, constant: 16),
            btnSendMoney.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
final class GeneralViewCell: UICollectionViewCell, ClassIdentifier {
    private var lblPrincipalName: UILabel = {
        let label = UILabel()
        label.font = .setFont(size: .custom(size: 24), weight: .bold)
        label.numberOfLines = 0
        label.textColor = .setColorFont(.primaryText)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var lblAmount: UILabel = {
        let label = UILabel()
        label.font = .setFont(size: .custom(size: 24), weight: .bold)
        label.textColor = .setColorFont(.secondaryBackground)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        addSubview(lblPrincipalName)
        addSubview(lblAmount)
        backgroundColor = .setColorFont(.primaryBackground)
        clipsToBounds = false
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            lblPrincipalName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            lblPrincipalName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lblPrincipalName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            lblAmount.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            lblAmount.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    func configView(_ data: GeneralInfoDTO) {
        lblPrincipalName.text = data.label.title
        lblAmount.text = data.amount
    }
}
