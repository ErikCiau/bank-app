//
//  ClassIndentifier.swift
//  Bankapp
//
//  Created by Erik Ciau on 22/08/23.
//

import Foundation

protocol ClassIdentifier { }
extension ClassIdentifier {
    static var identifier: String {
        String(describing: self)
    }
}
