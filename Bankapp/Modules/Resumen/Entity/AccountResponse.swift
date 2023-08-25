//
//  AccountResponse.swift
//  Bankapp
//
//  Created by Erik Ciau on 24/08/23.
//

import Foundation

struct AccountResponse: Codable {
    let response: [Account]
    enum CodingKeys: String, CodingKey {
        case response = "cuenta"
    }
}
struct Account: Codable {
    let account: Double
    let name: String
    let lastSession: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case account = "cuenta"
        case name = "nombre"
        case lastSession = "ultimaSesion"
        case id = "id"
    }
}
struct GeneralResponse: Codable {
    let response: [Balance]
    enum CodingKeys: String, CodingKey {
        case response = "saldos"
    }
}
struct Balance: Codable {
    let id: Int
    let account: Double
    let balance: Double
    let incomes: Double
    let expenses: Double
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case account = "cuenta"
        case balance = "saldoGeneral"
        case incomes = "ingresos"
        case expenses = "gastos"
    }
}

struct CardResponse: Codable {
    let response: [Card]
    enum CodingKeys: String, CodingKey {
        case response = "tarjetas"
    }
}
struct Card: Codable {
    let id: Int
    let account: String
    let name: String
    let balance: Double
    let status: Bool
    let type: String
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case account = "tarjeta"
        case name = "nombre"
        case balance = "saldo"
        case status = "estado"
        case type = "tipo"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.account = try container.decode(String.self, forKey: .account)
        self.name = try container.decode(String.self, forKey: .name)
        self.balance = try container.decode(Double.self, forKey: .balance)
        self.status = try container.decode(String.self, forKey: .status) == "activa"
        self.type = try container.decode(String.self, forKey: .type)
    }
}

struct TransactionResponse: Codable {
    let response: [Transaction]
    enum CodingKeys: String, CodingKey {
        case response = "movimientos"
    }
}
struct Transaction: Codable {
    let id: Int
    let date: String
    let description: String
    let amount: String
    let type: Bool
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "fecha"
        case description = "descripcion"
        case amount = "monto"
        case type = "tipo"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.date = try container.decode(String.self, forKey: .date)
        self.description = try container.decode(String.self, forKey: .description)
        self.amount = try container.decode(String.self, forKey: .amount)
        self.type = try container.decode(String.self, forKey: .type) == "abono"
    }
}
