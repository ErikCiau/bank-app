//
//  AccountViewCell.swift
//  Bankapp
//
//  Created by Erik Ciau on 23/08/23.
//

import UIKit

final class AccountHeaderViewCell: UICollectionReusableView, ClassIdentifier {
    private var btnAddCard: UIButton = {
        let button = UIButton()
        button.setTitle("Agregar una tarjeta de debito y credito", for: .normal)
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
        addSubview(btnAddCard)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            btnAddCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            btnAddCard.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

final class AccountViewCell: UICollectionViewCell, ClassIdentifier {
    private var imgCard: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "creditcard.fill")
        image.tintColor = UIColor(named: "SecondaryColor")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private var vwStackContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private var lblAmount: UILabel = {
        let label = UILabel()
        label.textColor = .setColorFont(.primaryBackground)
        label.font = .setFont(size: .l, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // Stack content
    private var lblStatus: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .setColorFont(.secondaryBackground)
        label.font = .setFont(size: .l, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var lblNumberCard: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .setColorFont(.primaryBackground)
        label.font = .setFont(size: .l, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var lblUser: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .setColorFont(.primaryBackground)
        label.font = .setFont(size: .m, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var lblHeadline: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .setColorFont(.primaryBackground)
        label.font = .setFont(size: .m, weight: .light)
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
        addSubview(imgCard)
        addSubview(vwStackContainer)
        addSubview(lblAmount)
        // Stack content
        vwStackContainer.addArrangedSubview(lblStatus)
        vwStackContainer.addArrangedSubview(lblNumberCard)
        vwStackContainer.addArrangedSubview(lblUser)
        vwStackContainer.addArrangedSubview(lblHeadline)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        vwStackContainer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        lblAmount.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        NSLayoutConstraint.activate([
            /// IMG
            imgCard.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            imgCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imgCard.widthAnchor.constraint(equalToConstant: 40),
            imgCard.heightAnchor.constraint(equalToConstant: 30),
            /// Amout label
            lblAmount.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            lblAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            /// Stack container
            vwStackContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            vwStackContainer.trailingAnchor.constraint(equalTo: lblAmount.leadingAnchor, constant: -16),
            vwStackContainer.leadingAnchor.constraint(equalTo: imgCard.trailingAnchor, constant: 16),
            vwStackContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    func configView(_ data: CardDTO) {
        lblUser.text = data.name
        lblAmount.text = data.balance
        lblStatus.text = data.status
        lblNumberCard.text = data.cardNumber
        lblHeadline.text = data.type
    }
}
