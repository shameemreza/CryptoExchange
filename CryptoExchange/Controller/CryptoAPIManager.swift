//
//  CryptoAPIManager.swift
//  CryptoExchange
//
//  Created by Shameem Reza on 1/4/22.
//

import SwiftUI

class CryptoAPI {
    let API_KEY = "C7CDFCB8-D517-4FE9-9D96-FAD2FA0B90EF"
    
    func getCryptoData(currency: String, previewMode: Bool, _ completion:@escaping ([Rate]) -> ()) {
        if previewMode {
            completion(Rate.sampleRates)
            return
        }
        
        let urlString = "https://rest.coinapi.io/v1/exchangerate/\(currency)?invert=false&apikey=\(API_KEY)"
        
        guard let url = URL(string: urlString) else {
            print("CryptoAPI: Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("CryptoAPI: Could not retrieve data")
                return
            }
            
            do {
                let ratesData = try JSONDecoder().decode(Crypto.self, from: data)
                completion(ratesData.rates)
            } catch {
                print("CryptoAPI: \(error)")
                completion(Rate.sampleRates)
            }
        }
        .resume()
    }
}

