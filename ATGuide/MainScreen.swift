//
//  MainScreen.swift
//  ATGuide
//
//  Created by Michaelyoussef on 11/10/2023.
//

import SwiftUI

struct MainScreen: View {
    let email: String
    let username: String
    @State private var isShowingNewView = false
    @State private var presentSideMenu = false
    var body: some View {
        ZStack {
            
        NavigationView {
            
            VStack {
               
        
                TabView {
                    
                    
                    Group{
                        
                        FirstScreen()
                            .tabItem {
                                Image(systemName: "house.fill")
                                
                                Text("Home")
                            }
                        //   .toolbar(.visible, for: .tabBar)
                        //   .toolbarBackground(Color.yellow, for: .tabBar)
                        
                        SecoundScreen()
                            .tabItem {
                                Image(systemName: "video.fill")
                                Text("hieroglyphics")
                            }
                        
                        
                        ThirdScreen()
                            .tabItem {
                                Image(systemName: "ellipsis.rectangle")
                                Text("More")
                            }
                        
                    }
                    .toolbarBackground(.indigo, for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(Color.blue, for: .tabBar)
                    .toolbarColorScheme(.dark, for: .tabBar)
                    
                    
                }
                
            }
            
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(leading: Button(action: {
                // Toggle side menu visibility
                withAnimation(.easeInOut) {
                    presentSideMenu.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
            })
        }
        
        .navigationBarHidden(true)
        if presentSideMenu {
            SideMenu(username: username, email: email, presentSideMenu: $presentSideMenu)
        }
    }
        
    .background(Color.black.opacity(0.05))

        }
        
       
    }


struct SideMenu: View {
    let username: String
    let email: String
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack(alignment: .leading ) {
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all).onTapGesture { withAnimation { presentSideMenu = false } }
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading){
                    
                    HStack(alignment: .center){
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        
                        
                        Text(username).font(.headline)
                          // .padding(.bottom,20)
                       //    .frame( alignment:.centerFirstTextBaseline)
                          // .padding(.trailing,5)
                       
                        
                                         
                    }
                    .padding(.leading, 5)
                     
                    Text(email).padding(.leading,5).font(.system(size: 10))
                    
                }.padding(.top, 1).padding(.leading, 10).padding(.bottom, 120)
                 
                Text("Setting").font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.leading, 8)

                Text("Planning").font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.leading, 8)
                
                
                Text("about").font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.leading, 8)
                
                Text("Privacy").font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.leading, 8)
                
                Text("Contact Us").font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                    .padding(.leading, 8)
                                
            }.frame(maxWidth:195, maxHeight:.infinity ,alignment:.topLeading).background(Color.white.ignoresSafeArea(.all)).offset(x:self.presentSideMenu ? 0 : -UIScreen.main.bounds.width/4)
                
                
        }
    }
}

#Preview {
    MainScreen( email: "", username: "")
}
