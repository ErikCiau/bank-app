//
//  TransactionsViewCell.swift
//  Bankapp
//
//  Created by Erik Ciau on 24/08/23.
//

import UIKit

final class TransactionHeaderViewCell: UITableViewHeaderFooterView, ClassIdentifier {
    private var lblName: UILabel = {
        let label = UILabel()
        label.text = "Movimientos recientes"
        label.font = .setFont(size: .l, weight: .semibold)
        label.textColor = .setColorFont(.primaryBackground)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    private func commonInit() {
        addSubview(lblName)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            lblName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lblName.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

final class TransactionFooterViewCell: UITableViewHeaderFooterView, ClassIdentifier {
    private var btnShowTransactions: UIButton = {
        let button = UIButton()
        button.setTitle("Ver todos los movimientos", for: .normal)
        button.titleLabel?.font = .setFont(size: .l, weight: .semibold)
        button.setTitleColor(.setColorFont(.primaryBackground), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        addSubview(btnShowTransactions)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            btnShowTransactions.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            btnShowTransactions.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

final class TransactionViewCell: UITableViewCell, ClassIdentifier {
    private var lblTransactionName: UILabel = {
        let label = UILabel()
        label.font = .setFont(size: .m, weight: .semibold)
        label.textColor = .setColorFont(.primaryBackground)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var lblDate: UILabel = {
        let label = UILabel()
        label.font = .setFont(size: .s, weight: .regular)
        label.textColor = .setColorFont(.primaryBackground)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var lblPrice: UILabel = {
        let label = UILabel()
        label.font = .setFont(size: .m, weight: .semibold)
        label.textColor = .setColorFont(.primaryBackground)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        addSubview(lblTransactionName)
        addSubview(lblDate)
        addSubview(lblPrice)
    }
    func configView(_ data: TransactionDTO) {
        lblTransactionName.text = data.name
        lblPrice.text = data.amount
        lblDate.text = data.date
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        lblTransactionName.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lblDate.setContentHuggingPriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            lblTransactionName.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            lblTransactionName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            lblDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            lblDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            lblPrice.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            lblPrice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            lblTransactionName.widthAnchor.constraint(equalToConstant: frame.size.width / 1.7)
        ])
    }
}
protocol TransactionsViewCellAction: AnyObject {
    func onSelect(transaction: TransactionDTO)
}
final class TransactionsViewCell: UICollectionViewCell, ClassIdentifier {
    private var tvTransacations: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    private var transactions: [TransactionDTO]?
    weak var delegate: TransactionsViewCellAction?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func reloadView() {
        tvTransacations.reloadData()
    }
    func configView(_ data: [TransactionDTO]) {
        self.transactions = data
        tvTransacations.reloadData()
    }
    private func commonInit() {
        clipsToBounds = false
        layer.cornerRadius = 8
        layer.masksToBounds = true
        addSubview(tvTransacations)
        tvTransacations.delegate = self
        tvTransacations.dataSource = self
        tvTransacations.register(TransactionViewCell.self, forCellReuseIdentifier: TransactionViewCell.identifier)
        tvTransacations.register(TransactionHeaderViewCell.self, forHeaderFooterViewReuseIdentifier: TransactionHeaderViewCell.identifier)
        tvTransacations.register(TransactionFooterViewCell.self, forHeaderFooterViewReuseIdentifier: TransactionFooterViewCell.identifier)
        tvTransacations.showsVerticalScrollIndicator = false
        tvTransacations.tableHeaderView = UIView()
        tvTransacations.tableFooterView = UIView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            tvTransacations.topAnchor.constraint(equalTo: topAnchor),
            tvTransacations.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            tvTransacations.bottomAnchor.constraint(equalTo: bottomAnchor),
            tvTransacations.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        ])
    }
}
extension TransactionsViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 50 }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 66 }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 50 }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.dequeueReusableHeaderFooterView(withIdentifier: TransactionHeaderViewCell.identifier)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let transactionCell = tableView.dequeueReusableCell(withIdentifier: TransactionViewCell.identifier, for: indexPath) as? TransactionViewCell {
            if let transaction = transactions?[indexPath.row] {
                transactionCell.configView(transaction)
            }
            return transactionCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        tableView.dequeueReusableHeaderFooterView(withIdentifier: TransactionFooterViewCell.identifier)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let transaction = transactions?[indexPath.row] {
            delegate?.onSelect(transaction: transaction)
        }
    }
}

