//
//  Home.swift
//  CryptoExchange
//
//  Created by Shameem Reza on 1/4/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject private var vm = ViewModel()
   
    var body: some View {
        // MARK: NAV BAR
        NavigationView {
            ZStack {
                VStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 10)
                        .background(LinearGradient(colors: [.green.opacity(0.3), .blue.opacity(0.5)],startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                    // MARK: RANGE SLIDER
                    VStack {
                        Stepper("Amount: $\(Int(vm.amount))", value: $vm.amount, step: 100)
                        
                        Slider(value: $vm.amount, in: 1...10_000)
                    } // END RANGE SLIDER
                    .padding()
                    
                    // MARK: CURRENCY LIST
                    List(vm.filterRates) {item in
                        HStack {
                            Text(item.asset_id_quote)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Text("\(vm.calcRate(rate: item), specifier: "%.2f")")
                        } // END HSTACK
                    } //END CURRENCY LIST
                    .listStyle(.plain)
                    .searchable(text: $vm.searchText)
                } // END VSTACK
                .onAppear(perform: vm.fetchData)
                .navigationTitle("Crypto Exchange")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: vm.fetchData) {Label("Refresh", systemImage: "arrow.clockwise")}
                    }
                } // END TOOL BAR
            }
        } // END NAV BAR
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
