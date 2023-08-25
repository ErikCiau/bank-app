//
//  ReseumenViewProtocols.swift
//  Bankapp
//
//  Created by Erik Ciau on 22/08/23.
//
protocol ResumenViewProtocol: AnyObject {
    func onGetLastConnection()
    func onGetTransactions()
    func startLoader()
    func stopLoader()
}
protocol ResumenViewPresenterProtocol: AnyObject {
    var lastConnection: [ConnectionDTO]? { get set }
    var generalInformation: [GeneralInfoDTO]? { get set }
    var cards: [CardDTO]? { get set }
    var transactions: [TransactionDTO]? { get set }
    func getInformationResume()
}
protocol ResumenViewInteractorInputProtocol: AnyObject {
    func getLastConnection() async throws
    func getGeneralInformation() async throws
    func getAllAccounts() async throws
    func getAllTransactions() async throws
}
protocol ResumenViewInteractorOutputProtocol: AnyObject {
    func didGetLastConnectionResponse(_ data: AccountResponse)
    func didGetGeneralInformation(_ data: GeneralResponse)
    func didGetCards(_ data: CardResponse)
    func didGetTransactions(_ data: TransactionResponse)
}
protocol ResumenViewRouterProtocol: AnyObject { }
