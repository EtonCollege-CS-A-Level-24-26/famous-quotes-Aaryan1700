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
                    HStack {
                        Text(quote.content)
                        
                        Spacer()
                        
                        Button("Edit") {
                            vm.editQuote()
                        }
                    }
                }
                .onDelete(perform: vm.deleteQuote)
                .onTapGesture(perform: vm.editQuote)
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
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
