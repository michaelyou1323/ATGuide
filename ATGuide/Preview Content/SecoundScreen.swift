//
//  SecoundScreen.swift
//  ATGuide
//
//  Created by Michaelyoussef on 11/10/2023.
//

import SwiftUI

struct SecoundScreen: View {
    @State private var isShowingNewView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    isShowingNewView = true
                }) {
                    Text("Go to New View")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .navigationTitle("Main View")
                .navigationBarTitleDisplayMode(.inline)
                
                NavigationLink(destination: MainScreen(), isActive: $isShowingNewView) {
                 
                }
            }
        }
    }
}

struct NewView: View {
    var body: some View {
        VStack {
            Text("New View")
                .font(.largeTitle)
                .padding()
            
            Text("This is the new view.")
                .font(.title)
                .padding()
        }
    }
}

#Preview {
    SecoundScreen()
}
