//
//  ContentViewModel.swift
//  CryptoExchange
//
//  Created by Shameem Reza on 1/4/22.
//

import SwiftUI

extension Home {
    class ViewModel: ObservableObject {
        @Published var rates = [Rate]()
        @Published var searchText = ""
        @Published var amount: Double = 100
        
        // MARK: - CURRENCY FILTER
        var filterRates: [Rate] {
            return searchText == "" ? rates : rates.filter { $0.asset_id_quote.contains(searchText.uppercased()) }
        }
        
        // MARK: CALCULATE RATE
        
        func calcRate(rate: Rate) -> Double {
            return amount * rate.rate
        }
        
        // MARK: - FETCH CURRENCY DATA
        func fetchData() {
            CryptoAPI().getCryptoData(currency: "USD", previewMode: false) {newRates in
                DispatchQueue.main.async {
                    withAnimation {
                        self.rates = newRates
                    }
                    print("Successfully got new Rates: \(self.rates.count)")
                }
            }
        } // END FETCH DATA
        
    }
}
