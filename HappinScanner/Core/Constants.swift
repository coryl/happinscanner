//
//  Constants.swift
//  HappinScanner
//
//  Created by Cory on 2021-05-12.
//

import Foundation

struct Constants {
    struct API {
        private static let baseURL = "http://product.com"
        private static let apiURL = baseURL + "/api"
        
        struct Endpoints {
            static let checkTicketStatus = API.apiURL + "/checkTicketStatus"
        }
    }
}
