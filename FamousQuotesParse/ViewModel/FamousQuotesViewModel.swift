//
//  FamousQuotesViewModel.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import Foundation
import ParseSwift

@Observable
class FamousQuotesViewModel {
    var quotes: [Quote]
    var isShowingAddQuote: Bool
    var newQuoteAuthor: String
    var newQuoteContent: String
    var isShowingEditQuote: Bool
    var quoteToEdit: Quote
    
    init() {
        self.quotes = []
        self.isShowingAddQuote = false
        self.newQuoteAuthor = ""
        self.newQuoteContent = ""
        self.isShowingEditQuote = false
        self.quoteToEdit = Quote(author: "Temp", content: "Temp")
    }
    
    func restoreQuotes() {
        QuoteRepository.shared.getAllQuotes(completion: { quotes in
            self.quotes = quotes
        })
    }
    
    func addNewQuote() {
        let quote = Quote(author: newQuoteAuthor, content: newQuoteContent)
        quotes.append(quote)
        QuoteRepository.shared.saveQuote(quote: quote)
        newQuoteAuthor = ""
        newQuoteContent = ""
        isShowingAddQuote = false
    }
    
    func deleteQuote(at offsets: IndexSet) {
        let index = offsets.first!
        let quote = self.quotes[index]

        QuoteRepository.shared.deleteQuote(quote: quote)
        self.quotes.remove(at: index)
    }
    
    func sortQuotes() {
        QuoteRepository.shared.getSortedQuotes { quotes in
            self.quotes = quotes
        }
    }
    
    func editQuote(quote: Quote, newAuthor: String, newContent: String) {
        QuoteRepository.shared.deleteQuote(quote: quote)
        QuoteRepository.shared.saveQuote(quote: Quote(author: newAuthor, content: newContent))
    }
}
