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
    @State private var aOffsetY: CGFloat = 1000
    @State private var tOffsetY: CGFloat = -1000
    @State private var guideOpacity = 0.0
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
             
            VStack {
                VStack{
                    Image(.photoRoom20231015170058) // Replace with your image name
                        .resizable()
                        .scaledToFill()
                        .frame(width: 240, height: 240)
                 
                    HStack(spacing: 0) {
                        Text("A")
                            .font(Font.custom("Baskerville-Bold", size: 40))
                            .foregroundColor(Color(UIColor(hex: 0x0bb9c0)))
                            .offset(y: aOffsetY)
                            .onAppear {
                                withAnimation(.easeIn(duration: 1.5)) {
                                    self.aOffsetY = 0
                                }
                            }
                        
                        
                        
                        Text("T")
                            .font(Font.custom("Baskerville-Bold", size: 40))
                            .foregroundColor(Color(UIColor(hex: 0x0bb9c0)))
                            .offset(y: tOffsetY)
                            .opacity(self.aOffsetY == 0 ? 1 : 0) // Show T after A appears
                            .onAppear {
                                withAnimation(.easeIn(duration: 1.5).delay(1)) {
                                    self.tOffsetY = 0
                                }
                            }
                         
                        Text("Guide")
                            .font(Font.custom("Baskerville-Bold", size: 40))
                            .foregroundColor(.black.opacity(0.80))
                            .opacity(self.tOffsetY == 0 ? 1 : 0) // Show Guide after T appears
                            .onAppear {
                                withAnimation(.easeIn(duration: 1.5).delay(2.6)) {
                                    self.guideOpacity = 1.0
                                }
                            }
                            .opacity(guideOpacity)
                    }
                     
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.1)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

    struct SplashScreenView_Previews: PreviewProvider {
        static var previews: some View {
            SplashScreenView()
        }
    }
