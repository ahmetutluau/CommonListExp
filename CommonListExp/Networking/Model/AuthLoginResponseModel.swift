//
//  AuthLoginResponseModel.swift
//  CommonListExp
//
//  Created by Ahmet Utlu on 1.04.2024.
//

import Foundation

struct AuthLoginResponseModel: Codable {
    let success: Bool?
    let data: AuthLoginModel?
    let message, internalMessage: String?
}

struct AuthLoginModel: Codable {
    let token, fullName, emailAddress, phoneNumber: String?
    let emailAddressVerified, phoneNumberVerified: Bool?
}
