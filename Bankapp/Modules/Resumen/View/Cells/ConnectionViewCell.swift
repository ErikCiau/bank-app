//
//  ConnectionViewCell.swift
//  Bankapp
//
//  Created by Erik Ciau on 22/08/23.
//

import UIKit

final class ConnectionViewCell: UICollectionViewCell, ClassIdentifier {
    private var lblName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .setFont(size: .m, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var lblLastConnection: UILabel = {
        let label = UILabel()
        label.textColor = .setColorFont(.secondaryBackground)
        label.font = .setFont(size: .m, weight: .bold)
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
        addSubview(lblName)
        addSubview(lblLastConnection)
        backgroundColor = .setColorFont(.primaryBackground)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            lblName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            lblName.centerYAnchor.constraint(equalTo: centerYAnchor),
            lblLastConnection.leadingAnchor.constraint(equalTo: lblName.trailingAnchor, constant: 16),
            lblLastConnection.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    func configureView(_ data: ConnectionDTO) {
        lblName.text = data.client
        lblLastConnection.text = "último inicio \(data.lastConnection)"
    }
}
