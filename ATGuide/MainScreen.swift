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
    let language: String
    let country: String
    
    @State private var tabIndex = 0 // Track the selected tab index
    @State private var presentSideMenu = false
    @State private var title = "Home" // Track the title
    
    var body: some View {
        ZStack {
            
        NavigationView {
            
            VStack(spacing: 0) {
                
                
                TabView(selection: $tabIndex){
                    
                    
                    Group{
                        
                        PlanningScreen()
                            .tabItem {
                                Image(systemName: "house.fill")
                                Text("Home")
                            }.tag(0)
                        //   .toolbar(.visible, for: .tabBar)
                        //   .toolbarBackground(Color.yellow, for: .tabBar)
                        
                        SecoundScreen()
                            .tabItem {
                                Image(systemName: "qrcode.viewfinder")
                                Text("QR")
                            }.tag(1)
                        
                        
                        ScannScreen()
                            .padding(.bottom,20)
                            .tabItem {
                                Image(systemName: "scroll")
                                Text("Hieroglyphics")
                            }.tag(2)
                        
                        FavoriteScreen()
                            .padding(.bottom,20)
                            .tabItem {
                                Image(systemName: "heart.fill")
                                Text("Fav")
                            }.tag(3)
                        
                    }
                  
                    
                

                    .toolbarBackground(.indigo, for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(Color(UIColor(hex: 0x0bb9c0)), for: .tabBar)
                    .toolbarColorScheme(.dark, for: .tabBar)
                    
                    
                }
               
                .onChange(of: tabIndex) { newValue in
                                       // Update the title based on the selected tab
                                       switch newValue {
                                           case 0:
                                               title = "Planning Section"
                                           case 1:
                                               title = "QR Code Scanner"
                                           case 2:
                                               title = "Hieroglyphics"
                                           case 3:
                                               title = "Fav"
                                           default:
                                               title = "Unknown"
                                       }
                                   }
            }
            
            .navigationBarTitleDisplayMode(.inline) // Display the title inline
                .navigationBarItems(leading:  HStack {
                    
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(hex: 0x313F54)))
                    
                    
                    
                    
                }
                .frame(height:35)
                .padding(.bottom,5)
                                    
                                    
                                    
                                    , trailing:
                                        HStack {
                        Button(action: {
                            // Toggle side menu visibility
                            withAnimation(.easeInOut) {
                                presentSideMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                        }
                        
                       
                    
//                        Text() // Display the changing title
//                            .font(.headline)
//                            .multilineTextAlignment(.center) // Align the text in the center
                   
                    }
              
              
            ).navigationBarHidden(false)
            if presentSideMenu {
                SideMenu(email: email, username: username, language: language, country: country, presentSideMenu: $presentSideMenu)
            }
            
        }
        
        .navigationBarHidden(true)
        if presentSideMenu {
            SideMenu(email: email, username: username,language:language,country: country, presentSideMenu: $presentSideMenu)
        }
    }
        .padding(0)
    .background(Color.black.opacity(0.05))

        }
        
        
       
    }


struct SideMenu: View {
    let email: String
    let username: String
    let language: String
    let country: String
    
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack(alignment: .trailing ) {
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
                 
         Text(language).font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.leading, 8)

                Text(country).font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.leading, 8)
                
                
//                Text().font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
//                    .padding(.leading, 8)
//
//                Text("Privacy").font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
//                    .padding(.leading, 8)
//
//                Text("Contact Us").font(.headline).padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
//                                    .padding(.leading, 8)
                                
            }.frame(maxWidth:270, maxHeight:.infinity ,alignment:.topLeading).background(Color.white.ignoresSafeArea(.all)).offset(x:self.presentSideMenu ? 0 : -UIScreen.main.bounds.width/4)
                
                
        }
    }
}

#Preview {
    MainScreen( email: "", username: "",language: "", country: "")
}
