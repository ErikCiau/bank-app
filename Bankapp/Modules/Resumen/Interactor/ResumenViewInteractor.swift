//
//  ResumenViewInteractor.swift
//  Bankapp
//
//  Created by Erik Ciau on 22/08/23.
//
import Foundation
final class ResumenViewInteractor: ResumenViewInteractorInputProtocol {
    private let http: HttpClient
    init(http: HttpClient) {
        self.http = http
    }
    weak var presenter: ResumenViewInteractorOutputProtocol?
    func getLastConnection() async throws {
        do {
            let (data, _): (AccountResponse, URLResponse) = try await http.get(url: "http://bankapp.endcom.mx/api/bankappTest/cuenta")
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.didGetLastConnectionResponse(data)
            }
        } catch {
            print(error)
        }
    }
    func getGeneralInformation() async throws {
        do {
            let (data, _): (GeneralResponse, URLResponse) = try await http.get(url: "http://bankapp.endcom.mx/api/bankappTest/saldos")
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.didGetGeneralInformation(data)
            }
        } catch {
            print(error)
        }
    }
    func getAllAccounts() async throws {
        do {
            let (data, _): (CardResponse, URLResponse) = try await http.get(url: "http://bankapp.endcom.mx/api/bankappTest/tarjetas")
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.didGetCards(data)
            }
        } catch {
            print(error)
        }
    }
    func getAllTransactions() async throws {
        do {
            let (data, _): (TransactionResponse, URLResponse) = try await http.get(url: "http://bankapp.endcom.mx/api/bankappTest/movimientos")
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.didGetTransactions(data)
            }
        } catch {
            print(error)
        }
    }
}
