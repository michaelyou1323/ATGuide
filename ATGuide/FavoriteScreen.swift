//
//  FavoriteScreen.swift
//  ATGuide
//
//  Created by Michaelyoussef on 10/12/2023.
//

import SwiftUI

struct FavoriteScreen: View {
        let days = ["Plan 1", "Plan 2", "Plan 3"] // Replace this with your list of days or data

        var body: some View {
            VStack{
               
                ScrollView {
                    
                    
                    
                    VStack(spacing: 20) {
                        ForEach(days, id: \.self) { day in
                            NavigationLink( destination: FavoriteScreenDetails()) {
                                CardView(day: day)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }

    struct CardView: View {
        let day: String // Pass the day information here
        
        var body: some View {
            
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.01))
                
                VStack {
                    HStack {
                        Text(day)
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.top, 10)
                            .padding(.leading, 10)
                     
                        
                    }
                    
                    VStack {
                        Image("1024 1") // Replace with your image name or URL
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                      
                        VStack(alignment:.leading) {
                            Text("Date: 15/5/2023") // Replace with your card number
                                .font(.callout)
                            
                            Text("Trip Type: ......") // Replace with your card number
                                .font(.callout)
                            
                        }
                        .frame(height: 30)
                        .padding(.top, 5)
                        .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                        Spacer()
//                        Text("90 $")
//                            .font(.headline)
//                            .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
//                            .padding(.top, 10)
//                            .padding(.trailing, 10)
                    }
                }
                .padding(10)
            }
            .frame(height: 170)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 0)
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
        }
    }


#Preview {
    FavoriteScreen()
}
