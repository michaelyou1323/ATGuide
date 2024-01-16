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
                ZStack{
                    
                    Image("IMG_20240104_181119 (2)").resizable().scaledToFill().clipped().edgesIgnoringSafeArea([.all]).opacity(0.5)
                    VStack{
                        Image(.photoRoom20231015170058) // Replace with your image name
                            .resizable()
                            .scaledToFill()
                            .frame(width: 240, height: 120)
                        
               
//                            
                            HStack(spacing: 0) {
    //                            Text("A")
    //                                .font(Font.custom("Zapfino", size: 30))
    //                                .foregroundColor(Color(UIColor(hex: 0x0bb9c0)))
                                
                                Image("PhotoRoom-20240106_090407")
                                    .resizable()
                                    .clipped()
                                    .frame(width: 110,height: 130)
                                    .padding(.trailing,-24)
                                    .padding(.bottom,15)
                                    .padding(.leading,-7)
                                    .offset(y: aOffsetY)
                                    .onAppear {
                                        withAnimation(.easeIn(duration: 1.5)) {
                                            self.aOffsetY = 0
                                        }
                                    }
                                
                                Image("PhotoRoom-20240106_092020")
                                    .resizable()
                                    .clipped()
                                    .frame(width: 75,height: 80)
                                    .padding(.trailing,-10)
                                    .padding(.leading,-12)
                                    .padding(.bottom,25)
                                    .offset(y: tOffsetY)
                                    .opacity(self.aOffsetY == 0 ? 1 : 0) // Show T after A appears
                                    .onAppear {
                                        withAnimation(.easeIn(duration: 1.5).delay(1)) {
                                            self.tOffsetY = 0
                                        }
                                    }
                                
                                
                                Image("PhotoRoom-20240106_092747")
                                    .resizable()
                                    .clipped()
                                    .frame(width: 140,height: 80)
                                    .padding(.trailing,-18)
                                    .padding(.bottom,25)
                                    .opacity(self.tOffsetY == 0 ? 1 : 0) // Show Guide after T appears
                                    .onAppear {
                                        withAnimation(.easeIn(duration: 1.5).delay(2.6)) {
                                            self.guideOpacity = 1.0
                                        }
                                    }
                                    .opacity(guideOpacity)
                                
    //                            Text("T")
    //                                .font(Font.custom("Baskerville-Bold", size: 40))
    //                                .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114))
    //                                .padding(.bottom,8)
    //                                .offset(y: tOffsetY)
    //                                .opacity(self.aOffsetY == 0 ? 1 : 0) // Show T after A appears
    //                                .onAppear {
    //                                    withAnimation(.easeIn(duration: 1.5).delay(1)) {
    //                                        self.tOffsetY = 0
    //                                    }
    //                                }
                                
    //                            Text("Guide")
    //                                .font(Font.custom("Baskerville-Bold", size: 40))
    //                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
    //                                .padding(.bottom,8)
    //                                .opacity(self.tOffsetY == 0 ? 1 : 0) // Show Guide after T appears
    //                                .onAppear {
    //                                    withAnimation(.easeIn(duration: 1.5).delay(2.6)) {
    //                                        self.guideOpacity = 1.0
    //                                    }
    //                                }
    //                                .opacity(guideOpacity)
                           // }
                        }
                       
                        .padding(.top, 30)
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
            }
            
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
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
