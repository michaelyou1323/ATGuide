//
//  SplashScreenView.swift
//  ATGuide
//
//  Created by mario on 15/10/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        if isActive {
            ContentView()
        }else {
            
            VStack {
                VStack{
                    Image (.photoRoom20231015170058)
                        .resizable()
                        .scaledToFill()
                        .frame (width: 240, height: 240)
                    
                    Text ("ATGuide")
                        .font (Font.custom("Baskerville-Bold", size: 40))
                        .foregroundColor(.black.opacity(0.80))
                }
                .scaleEffect (size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.1)){
                        self.size = 0.9
                        self.opacity = 1.00
                        
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline:.now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

    struct SplashScreenView_Previews: PreviewProvider {
        static var previews: some View {
            SplashScreenView()
        }
    }

