//
//  ContentView.swift
//  group2 final
//
//  Created by snlcom on 2023/05/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HStack {
                NavigationLink(destination: OwnerView()) {
                    Text("Owner")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 150.0, height: 80.0)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                NavigationLink(destination: ContractorView()) {
                    Text("Contractor")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 200.0, height: 80.0)
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Role Selection")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

