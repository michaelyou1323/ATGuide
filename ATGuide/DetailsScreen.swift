//
//  DetailsScreen.swift
//  ATGuide
//
//  Created by Michaelyoussef on 05/12/2023.
//

import SwiftUI

struct DetailsScreen: View {
//    var tripPlan: TripPlan
      @State private var isFavorite = false
    var body: some View {
        VStack() {
            HStack {
                Spacer()
                Text("Plan Details")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                    .padding(.leading, 60)
                
                
                Spacer()
                Button(action: {
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                        .font(.title)
                }
                .padding()
            }
            .frame(height:25)
         
            
            
            ScrollView{
                
                VStack(spacing: 20) {
                    
                    
                    
                    ZStack(alignment: .center) {
                        let shape = RoundedRectangle(cornerRadius: 20)
                        shape.fill().foregroundColor(Color.gray.opacity(0.01))
                        
                        
                        VStack {
                            HStack {
                                Text("Day 1")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.top, 10)
                                    .padding(.leading, 10) // Align to the left
                                Spacer()// Pushes text to the left
                                
                                Text("Cairo")
                                    .font(.headline)
                                    .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                    .padding(.top, 10)
                                    .padding(.trailing, 10) // Align to the left
                            }
                            
                            VStack {
                                Image("1024 1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity) // Stretches horizontally
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5) // Add padding to the image
                            }
                            .background(Color.white) // Add a white background for the image container
                            .cornerRadius(10) // Round corners of the image container
                            
                            
                            HStack{
                                Text("       ")
                                Spacer()
                                VStack {
                                    
                                    Text("Hotel: .....") // Replace with your card number
                                        .font(.callout)
                                    
                                    Text("Restorant: ......") // Replace with your card number
                                        .font(.callout)
                                    
                                }.frame(height:30)
                                    .padding(.top, 5)
                                    .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                                Spacer()
                                Text("90 $")
                                    .font(.headline)
                                    .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                    .padding(.top, 10)
                                    .padding(.trailing, 10) // Align to the left
                            }
                            
                            
                        }
                        .padding(10) // Add padding for the whole content
                        
                    }
                    .frame(height: 170) // Adjust the height as needed
                    
                    .background(Color.white) // Add a white background to the entire card
                    .cornerRadius(20) // Round corners of the card
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 0) // Add a shadow effect
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    
                    
                    
                    
                    ZStack(alignment: .center) {
                        let shape = RoundedRectangle(cornerRadius: 20)
                        shape.fill().foregroundColor(Color.gray.opacity(0.01))
                        
                        
                        VStack {
                            HStack {
                                Text("Day 2")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.top, 10)
                                    .padding(.leading, 10) // Align to the left
                                Spacer()// Pushes text to the left
                                
                                Text("Cairo")
                                    .font(.headline)
                                    .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                    .padding(.top, 10)
                                    .padding(.trailing, 10) // Align to the left
                            }
                            
                            VStack {
                                Image("1024 1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity) // Stretches horizontally
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5) // Add padding to the image
                            }
                            .background(Color.white) // Add a white background for the image container
                            .cornerRadius(10) // Round corners of the image container
                            
                            
                            HStack{
                                Text("       ")
                                Spacer()
                                VStack {
                                    
                                    Text("Hotel: .....") // Replace with your card number
                                        .font(.callout)
                                    
                                    Text("Restorant: ......") // Replace with your card number
                                        .font(.callout)
                                    
                                }.frame(height:30)
                                    .padding(.top, 5)
                                    .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                                Spacer()
                                Text("90 $")
                                    .font(.headline)
                                    .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                    .padding(.top, 10)
                                    .padding(.trailing, 10) // Align to the left
                            }
                        }
                        .padding(10) // Add padding for the whole content
                        
                    }
                    .frame(height: 170) // Adjust the height as needed
                    
                    
                    .background(Color.white) // Add a white background to the entire card
                    .cornerRadius(20) // Round corners of the card
                    .shadow(color: Color.gray.opacity(0.9), radius: 5, x: 0, y: 0) // Add a shadow effect
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    
                    
                    ZStack(alignment: .center) {
                        let shape = RoundedRectangle(cornerRadius: 20)
                        shape.fill().foregroundColor(Color.gray.opacity(0.01))
                        
                        
                        VStack {
                            HStack {
                                Text("Day 3")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.top, 10)
                                    .padding(.leading, 10) // Align to the left
                                Spacer()// Pushes text to the left
                                
                                Text("Siwa")
                                    .font(.headline)
                                
                                    .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                    .padding(.top, 10)
                                    .padding(.trailing, 10) // Align to the left
                            }
                            
                            VStack {
                                Image("1024 1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity) // Stretches horizontally
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5) // Add padding to the image
                            }
                            .background(Color.white) // Add a white background for the image container
                            .cornerRadius(10) // Round corners of the image container
                            //
                            VStack {
                                
                                Text("Hotel: .....") // Replace with your card number
                                    .font(.callout)
                                
                                Text("Restorant: ......") // Replace with your card number
                                    .font(.callout)
                                
                            }.frame(height:30)
                                .padding(.top, 5)
                                .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                        }
                        .padding(10) // Add padding for the whole content
                        
                    }
                    .frame(height: 170) // Adjust the height as needed
                    
                    
                    .background(Color.white) // Add a white background to the entire card
                    .cornerRadius(20) // Round corners of the card
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 0) // Add a shadow effect
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    
                    ZStack(alignment: .center) {
                        let shape = RoundedRectangle(cornerRadius: 20)
                        shape.fill().foregroundColor(Color.gray.opacity(0.01))
                        
                        
                        VStack {
                            HStack {
                                Text("Day 4")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.top, 10)
                                    .padding(.leading, 10) // Align to the left
                                Spacer()// Pushes text to the left
                                
                                Text("Alex")
                                    .font(.headline)
                                    .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                    .padding(.top, 10)
                                    .padding(.trailing, 10) // Align to the left
                            }
                            
                            VStack {
                                Image("1024 1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity) // Stretches horizontally
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5) // Add padding to the image
                            }
                            .background(Color.white) // Add a white background for the image container
                            .cornerRadius(10) // Round corners of the image container
                            
                            //
                            VStack {
                                
                                Text("Hotel: .....") // Replace with your card number
                                    .font(.callout)
                                
                                Text("Restorant: ......") // Replace with your card number
                                    .font(.callout)
                                
                            }.frame(height:30)
                                .padding(.top, 5)
                                .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                        }
                        .padding(10) // Add padding for the whole content
                        
                    }
                    .frame(height: 170) // Adjust the height as needed
                    
                    
                    .background(Color.white) // Add a white background to the entire card
                    .cornerRadius(20) // Round corners of the card
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 0) // Add a shadow effect
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    // Displaying activities - assuming it's a dictionary
//                    ForEach(sorted(by: { $0.key < $1.key }), id: \.key) { activity in
//                        
//                        
//                        Text("\(activity.key): \(activity.value)")
//                        
//                        ZStack(alignment: .center) {
//                            let shape = RoundedRectangle(cornerRadius: 20)
//                            shape.fill().foregroundColor(Color.gray.opacity(0.01))
//                            
//                            
//                            VStack {
//                                HStack {
//                                    Text("Your Headline Text")
//                                        .font(.headline)
//                                        .foregroundColor(.black)
//                                        .padding(.top, 10)
//                                        .padding(.leading, 10) // Align to the left
//                                    Spacer() // Pushes text to the left
//                                }
//                                
//                                VStack {
//                                    Image("1024 1")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(maxWidth: .infinity) // Stretches horizontally
//                                        .padding(.horizontal, 10)
//                                        .padding(.vertical, 5) // Add padding to the image
//                                }
//                                .background(Color.white) // Add a white background for the image container
//                                .cornerRadius(10) // Round corners of the image container
//                                
//                                HStack {
//                                    Spacer() // Pushes text to the right
//                                    Text("#1") // Replace with your card number
//                                        .font(.headline)
//                                        .foregroundColor(.black)
//                                        .padding(.trailing, 20)
//                                }
//                            }
//                            .padding(10) // Add padding for the whole content
//                            
//                        }
//                        .frame(height: 160) // Adjust the height as needed
//                        .padding(.vertical, 10)
//                        
//                        .background(Color.white) // Add a white background to the entire card
//                        .cornerRadius(20) // Round corners of the card
//                        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 4) // Add a shadow effect
//                        .padding(.horizontal, 40)
//                    }
                    
                    
                }
            }
            .navigationTitle("")
         
            
        }
       
        
    }
       
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen()
    }
}
