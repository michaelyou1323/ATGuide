//
//  MainScreen.swift
//  ATGuide
//
//  Created by Michaelyoussef on 11/10/2023.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        
        NavigationView {
            
            VStack {
                Text("ATGuide").font(.system(size: 33))
                    .bold()
                    .padding(2)
                
                
                TabView {
                    
                    
                    Group{
                        
                        FirstScreen()
                            .tabItem {
                                Image(systemName: "house.fill")
                                
                                Text("الرئيسية")
                            }
                        //   .toolbar(.visible, for: .tabBar)
                        //   .toolbarBackground(Color.yellow, for: .tabBar)
                        
                        SecoundScreen()
                            .tabItem {
                                Image(systemName: "video.fill")
                                Text("الحلقات")
                            }
                        
                        
                        ThirdScreen()
                            .tabItem {
                                Image(systemName: "ellipsis.rectangle")
                                Text("المزيد")
                            }
                        
                    }
                    .toolbarBackground(.indigo, for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(Color.blue, for: .tabBar)
                    .toolbarColorScheme(.dark, for: .tabBar)
                    
                    
                }
            }
            
            // .foregroundColor(Color.red)
            
//            NavigationLink(destination: FormScreen()) {
//                
//            }
            
            
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    MainScreen()
}
