//
//  ConnectionDTO.swift
//  Bankapp
//
//  Created by Erik Ciau on 22/08/23.
//

import Foundation

struct ConnectionDTO {
    var client: String
    var lastConnection: String
    init(client: String, lastConnection: String) {
        self.client = client
        if let date = lastConnection.split(separator: " ").first {
            self.lastConnection = String(date)
        } else {
            self.lastConnection = ""
        }
    }
}
enum GeneralInfoHeadlines {
    case general, incomes, expenses
    var title: String {
        switch self {
        case .general: return "Saldo general en cuentas"
        case .expenses: return "Total de egresos"
        case .incomes: return "Total de ingresos"
        }
    }
}
struct GeneralInfoDTO {
    let label: GeneralInfoHeadlines
    let amount: String
    init(label: GeneralInfoHeadlines, amount: Double) {
        self.label = label
        self.amount = "$\(amount)"
    }
}

struct CardDTO {
    let cardNumber: String
    let balance: String
    let name: String
    let type: String
    let status: String
    init(cardNumber: String, balance: Double, name: String, type: String, status: Bool) {
        self.cardNumber = cardNumber
        self.balance = "$\(balance)"
        self.name = name
        self.type = type.capitalized
        self.status = status ? "Activa" : "Inactiva"
    }
}

struct TransactionDTO {
    let name: String
    let date: String
    let amount: String
    
    init(name: String, date: String, amount: String, type: Bool) {
        self.name = name
        self.date = date
        self.amount = type ? "$\(amount)" : "- $\(amount)"
    }
}
