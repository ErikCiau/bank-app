//
//  ResumenViewPresenter.swift
//  Bankapp
//
//  Created by Erik Ciau on 22/08/23.
//

import Foundation

final class ResumenViewPresenter: ResumenViewPresenterProtocol {
    weak var view: ResumenViewProtocol?
    var lastConnection: [ConnectionDTO]?
    var generalInformation: [GeneralInfoDTO]? = []
    var cards: [CardDTO]?
    var transactions: [TransactionDTO]?
    var interacator: ResumenViewInteractorInputProtocol?
    var router: ResumenViewRouterProtocol?
    func getInformationResume() {
        view?.startLoader()
        Task {
            try await interacator?.getLastConnection()
            try await interacator?.getGeneralInformation()
            try await interacator?.getAllAccounts()
            try await interacator?.getAllTransactions()
        }
    }
}
extension ResumenViewPresenter: ResumenViewInteractorOutputProtocol {
    func didGetLastConnectionResponse(_ data: AccountResponse) {
        lastConnection = data.response.map {
            ConnectionDTO(client: $0.name, lastConnection: $0.lastSession)
        }
        view?.onGetLastConnection()
    }
    func didGetGeneralInformation(_ data: GeneralResponse) {
        if let response = data.response.first {
            generalInformation?.append(GeneralInfoDTO(label: .general, amount: response.balance))
            generalInformation?.append(GeneralInfoDTO(label: .incomes, amount: response.incomes))
            generalInformation?.append(GeneralInfoDTO(label: .expenses, amount: response.expenses))
        }
        view?.onGetLastConnection()
    }
    func didGetCards(_ data: CardResponse) {
        cards = data.response.map {
            CardDTO(cardNumber: $0.account, balance: $0.balance, name: $0.name, type: $0.type, status: $0.status)
        }
        view?.onGetLastConnection()
    }
    func didGetTransactions(_ data: TransactionResponse) {
        transactions = data.response.map {
            TransactionDTO(name: $0.description, date: $0.date, amount: $0.amount, type: $0.type)
        }
        view?.onGetTransactions()
        view?.stopLoader()
    }
}
