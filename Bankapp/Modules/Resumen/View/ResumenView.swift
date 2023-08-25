//
//  ResumenView.swift
//  Bankapp
//
//  Created by Erik Ciau on 22/08/23.
//
import UIKit
final class ResumenView: ViewController {
    var presenter: ResumenViewPresenterProtocol?
    private var clLayout: UICollectionView!
    private var vwLoader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        let blurEffect = UIBlurEffect(style: .prominent)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        visualEffect.frame = indicator.frame
        visualEffect.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        indicator.insertSubview(visualEffect, at: 0)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    override func setTitle() -> String? { "BankApp" }
    /// View Components
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getInformationResume()
        clLayout = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        clLayout.translatesAutoresizingMaskIntoConstraints = false
        clLayout.dataSource = self
        clLayout.delegate = self
        clLayout.register(ConnectionViewCell.self, forCellWithReuseIdentifier: ConnectionViewCell.identifier)
        clLayout.register(GeneralHeaderViewCell.self, forSupplementaryViewOfKind: GeneralHeaderViewCell.identifier, withReuseIdentifier: GeneralHeaderViewCell.identifier)
        clLayout.register(GeneralViewCell.self, forCellWithReuseIdentifier: GeneralViewCell.identifier)
        clLayout.register(AccountHeaderViewCell.self, forSupplementaryViewOfKind: AccountHeaderViewCell.identifier, withReuseIdentifier: AccountHeaderViewCell.identifier)
        clLayout.register(AccountViewCell.self, forCellWithReuseIdentifier: AccountViewCell.identifier)
        clLayout.register(TransactionsViewCell.self, forCellWithReuseIdentifier: TransactionsViewCell.identifier)
        view.addSubview(clLayout)
        view.addSubview(vwLoader)
    }
    override func setContraints() -> [NSLayoutConstraint]? {[
        clLayout.topAnchor.constraint(equalTo: view.topAnchor),
        clLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        clLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        clLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        // Blur effect
        vwLoader.topAnchor.constraint(equalTo: view.topAnchor),
        vwLoader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        vwLoader.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        vwLoader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    ]}
    
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(sectionProvider: { section, _ in
            ResumenCollectionSection(rawValue: section)?.makeLayout()
        })
    }
}
extension ResumenView: ResumenViewProtocol {
    func startLoader() {
        vwLoader.startAnimating()
    }
    
    func stopLoader() {
        vwLoader.stopAnimating()
        vwLoader.isHidden = true
    }
    
    func onGetLastConnection() {
        clLayout.reloadData()
    }
    func onGetTransactions() {
        clLayout.reloadData()
    }
}
extension ResumenView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int { ResumenCollectionSection.allCases.count }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = ResumenCollectionSection(rawValue: section)
        switch section {
        case .connection:
            return presenter?.lastConnection?.count ?? 0
        case .general:
            return presenter?.generalInformation?.count ?? 0
        case .accounts:
            return presenter?.cards?.count ?? 0
        default: return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = ResumenCollectionSection(rawValue: indexPath.section)
        if let connectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ConnectionViewCell.identifier, for: indexPath) as? ConnectionViewCell, section == .connection {
            if let connection = presenter?.lastConnection?[indexPath.row] {
                connectionCell.configureView(connection)
            }
            return connectionCell
        }
        if let generalCell = collectionView.dequeueReusableCell(withReuseIdentifier: GeneralViewCell.identifier, for: indexPath) as? GeneralViewCell, section == .general {
            if let general = presenter?.generalInformation?[indexPath.row] {
                generalCell.configView(general)
            }
            return generalCell
        }
        if let accountCell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountViewCell.identifier, for: indexPath) as? AccountViewCell, section == .accounts {
            if let card = presenter?.cards?[indexPath.row] {
                accountCell.configView(card)
            }
            return accountCell
        }
        if let transactionsCell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionsViewCell.identifier, for: indexPath) as? TransactionsViewCell, section == .transactions {
            transactionsCell.delegate = self
            if let transactions = presenter?.transactions {
                transactionsCell.configView(transactions)
            }
            return transactionsCell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = ResumenCollectionSection(rawValue: indexPath.section)
        if section == .general {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GeneralHeaderViewCell.identifier, for: indexPath)
        }
        if section == .accounts {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AccountHeaderViewCell.identifier, for: indexPath)
        }
        return .init()
    }
}

extension ResumenView: TransactionsViewCellAction {
    func onSelect(transaction: TransactionDTO) {
        dump(transaction)
    }
}
