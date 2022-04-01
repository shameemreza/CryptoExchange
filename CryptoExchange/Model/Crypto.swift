//
//  Crypto.swift
//  CryptoExchange
//
//  Created by Shameem Reza on 1/4/22.
//

import SwiftUI

struct Crypto: Decodable {
    let asset_id_base: String
    let rates: [Rate]
}

struct Rate: Decodable, Identifiable {
    let id = UUID()
    let time: String
    let asset_id_quote: String
    let rate: Double
    
    static var sampleRates: [Rate] {
        var tempRates = [Rate]()
        
        for _ in 1...20 {
            let randomNumber = Double(Array(0...1000).randomElement()!)
            let randomCurrency = ["BTC","ETH","USDT","BNB","XRP","ADA","SOL"].randomElement()!
            let sampleRate = Rate(time: "34543", asset_id_quote: randomCurrency, rate: randomNumber)
            tempRates.insert(sampleRate, at: 0)
        }
        return tempRates
    }
}
