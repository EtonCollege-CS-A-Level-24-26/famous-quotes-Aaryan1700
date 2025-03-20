//
//  ContentView.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State var vm: FamousQuotesViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.quotes) { quote in
                    Text(quote.content)
                        .onTapGesture {
                            vm.isShowingEditQuote = true
                            vm.quoteToEdit = quote
                            vm.newQuoteAuthor = quote.author
                            vm.newQuoteContent = quote.content
                        }
                }
                .onDelete(perform: vm.deleteQuote)
            }
            .onAppear {
                vm.restoreQuotes()
            }
            .sheet(isPresented: $vm.isShowingAddQuote) {
                Form {
                    TextField("Author", text: $vm.newQuoteAuthor)
                    TextField("Quote", text: $vm.newQuoteContent)
                    Button("Add") {
                        vm.addNewQuote()
                    }
                }
            }
            .sheet(isPresented: $vm.isShowingEditQuote) {
                Form {
                    TextField("Author", text: $vm.newQuoteAuthor)
                    TextField("Quote", text: $vm.newQuoteContent)
                    Button("Edit") {
                        vm.editQuote(quote: vm.quoteToEdit, newAuthor: vm.newQuoteAuthor, newContent: vm.newQuoteContent)
                        vm.newQuoteAuthor = ""
                        vm.newQuoteContent = ""
                        vm.isShowingEditQuote = false
                    }
                }
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        vm.newQuoteAuthor = ""
                        vm.newQuoteContent = ""
                        vm.isShowingAddQuote = true
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Sort") {
                        vm.sortQuotes()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(vm: FamousQuotesViewModel())
}
