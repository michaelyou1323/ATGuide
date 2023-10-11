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
              
                    Text("Go to New View")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                
                  
               
            }
        }
    }
}



#Preview {
    SecoundScreen()
}
