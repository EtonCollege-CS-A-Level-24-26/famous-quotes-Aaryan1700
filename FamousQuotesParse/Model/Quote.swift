//
//  Quote.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import Foundation

struct Quote: Identifiable {
    var author: String
    var content: String
    
    var id: String {
        "\(author)\(content)"
    }
}
