//
//  AlertItem.swift
//  CommonListExp
//
//  Created by Ahmet Utlu on 2.04.2024.
//

import Foundation

struct AlertItem: Identifiable {
    var id = UUID()
    var title: String
    var message: String
}
