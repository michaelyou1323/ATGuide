//
//  YourPlans.swift
//  ATGuide
//
//  Created by Michaelyoussef on 14/01/2024.
//

import SwiftUI


struct YourPlans: View {
    let userID: String
    var body: some View {
        YourPlans2(userId: userID) // Pass the user ID here
    }
}

struct YourPlans2: View {
    //    var recommendation: Recommendation // Assuming Recommendation is your model
    @State private var cardNumber = ""
        @State private var cardName = ""
        @State private var expiryDate = ""
        @State private var cvv = ""
        @State private var roomCount = 0
        @State private var bedsCount = "Single"
        @State private var singleBedSelected = false
        @State private var isValid: Bool?
        @State private var errorMessage: String?
        @State private var isLoading = false
        @State private var isShowingResult = false
        @State private var isShowingPopup = false
        @State private var isPaymentDone = false
        @ObservedObject var planViewModel: PlanViewModel
        @State private var selectedPlan: Plan? = nil
        @State private var favStatus = true
        @State private var isExpanded = false

    
    init(userId: String) {
        self.planViewModel = PlanViewModel(userId: userId)
       
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 12) {
                //  Image("\(hotelDetail.image)")
                VStack{
                    VStack{
                        AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: "hotelDetail.image") ?? ""))
                        {
                            phase in
                            switch phase {
                            case.empty:
                                Image("a-hero-image")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 150)
                                    .clipped()
                                    .cornerRadius(12)
                            case.success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 150)
                                    .clipped()
                                    .cornerRadius(12)
                            case.failure:
                                Image("a-hero-image")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 150)
                                    .clipped()
                                    .cornerRadius(12)
                                //                                 @unknown default:
                                //                                     EmptyView()
                            @unknown default:
                                fatalError()
                            }
                            
                        }
                        
                    }
                    
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(12)
                    // recommendation.
                    
                }
                .onTapGesture {
                    isExpanded.toggle()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.6), radius: 4, x: 0, y: 2)
                
                // Additional data to be shown when expanded
                DisclosureGroup("Additional Details", isExpanded: $isExpanded) {
                    // Add your additional content here
                    // For example, you can display more details or controls
                    // when the user clicks on the expand button
                    Text("\("hotelDetail.name")")
                        .font(Font.custom("Charter-Black", size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                    
                    Text("\("hotelDetail.location")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    HStack {
                        Text("Total Cost: ")
                            .font(.subheadline)
                        
                        Text("30 $")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Room")
                        Spacer()
                        
                        Button(action: {
                            // Increment room count
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(Color(red: 0.192, green: 0.259, blue: 0.333))
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
                        Text("\("roomCount")")
                            .padding(.horizontal, 10)
                        
                        Button(action: {
                            // Decrement room count
                        }) {
                            Image(systemName: "minus.circle")
                                .foregroundColor(Color(red: 0.192, green: 0.259, blue: 0.333))
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .listRowBackground(Color.clear)
                    .contentShape(RoundedRectangle(cornerRadius: 20))
                    
                    HStack {
                        Text("Beds")
                        Spacer()
                        
                        Button(action: {
                            // Handle single bed selection
                        }) {
                            Text("Single")
                                .padding(.horizontal, 10)
                        }
                        .buttonStyle(BorderedButtonStyle())
                        
                        Button(action: {
                            // Handle double bed selection
                        }) {
                            Text("Double")
                                .padding(.horizontal, 10)
                        }
                        .buttonStyle(BorderedButtonStyle())
                    }
                    .listRowBackground(Color.clear)
                    .contentShape(RoundedRectangle(cornerRadius: 20))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        //                             Text("Payment Information")
                        //                                 .font(.headline)
                        //                                 .fontWeight(.bold)
                        //                                 .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114))
                        
                        TextField("Card Number", text: $cardNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        HStack {
                            TextField("Expiry Date", text: $expiryDate)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Spacer()
                            
                            TextField("CVV", text: $cvv)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        TextField("Card Holder Name", text: $cardName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.vertical)
                    .padding(.bottom, isExpanded ? 0 : 0)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            isExpanded.toggle()
                        }) {
                            Text(isExpanded ? "Collapse" : "Expand")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color(red: 0.192, green: 0.259, blue: 0.333))
                                .cornerRadius(10)
                        }
                        .padding(.leading, 170)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
                .opacity(isPaymentDone ? 0.4 : 1)
                .disabled(isPaymentDone ? true : false)
            }
            
            
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
            .opacity(isPaymentDone ? 0.4 : 1)
            .disabled(isPaymentDone ? true : false)
            .padding()
        }
        
             }
         }

#Preview {
    YourPlans(userID: "t17QMgg7C0QoRNr401O9Z93zTMl1")
}






//        VStack{
//            HStack {
//                //Spacer()
//                Text("Your Plans")
//                    .font(Font.custom("Charter-Black", size: 32))
//                    .fontWeight(.bold)
//                    .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
//                    .padding(.leading, 10)
//                    .padding(.bottom,5)
//
//
//            }
//            .frame(height:25)
//
//
//            ScrollView {
//                VStack(spacing: 10) {
//                    ForEach(planViewModel.plans) { plan in
//
//
//                            ZStack(alignment: .leading) {
//
//
//                                RoundedRectangle(cornerRadius: 20)
//                                    .fill(Color.gray.opacity(0.01))
//                                    .padding(.horizontal, 30)
//                                    .background(Color.white) // Add a white background to the entire card
//                                    .cornerRadius(10) // Round corners of the card
//                                    .shadow(color: Color.gray.opacity(0.7), radius: 5, x: 0, y: 2) // Add a shadow effect
//
//                                ZStack{
////                                    Image("Modern and Minimal Company Profile Presentation") // Replace "your_background_image" with your image name
////                                           .resizable()
////                                           .aspectRatio(contentMode: .fill)
////                                           .frame(maxWidth: .infinity, maxHeight: .infinity)
////                                           .edgesIgnoringSafeArea(.all)
////                                           .opacity(0.8)
////                                           .cornerRadius(20)
//                                HStack{
//
//
//                                    VStack(alignment: .leading, spacing: 5) {
//                                        HStack() {
//                                            Text("Plan ID:")
//                                                .font(Font.custom("Baskerville-Bold", size: 17))
//                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
//                                                .fontWeight(.bold)
//                                            Text("\(plan.planId)")
//                                                .font(Font.custom("Arial-BoldMT", size: 14))
//                                                .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
//                                                .fontWeight(.bold)
//                                            //
//                                            // Cochin-BoldItalic
//                                        }
//
//                                        HStack {
//                                            Text("Total budget:")
//                                                .font(Font.custom("Baskerville-Bold", size: 17))
//                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
//                                                .fontWeight(.bold)
//                                            Text("\(plan.budget)")
//                                                .font(Font.custom("Arial-BoldMT", size: 14))                                               .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
//                                                .fontWeight(.bold)
//                                            Image(systemName: "dollarsign.circle").foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114))
//                                                .font(.system(size: 19))
//                                        }
//
//                                        HStack {
//                                            Text("Trip Type:")
//                                                .font(Font.custom("Baskerville-Bold", size: 17))
//                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
//                                                .fontWeight(.bold)
//                                            Text(extractTextBeforeUnderscore(plan.tripType))
//                                                .font(Font.custom("Arial-BoldMT", size: 14))                                              .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
//
//                                        }
//
//                                        HStack {
//                                            Text("Hotel Stars:")
//                                                .font(Font.custom("Baskerville-Bold", size: 17))
//                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
//                                                .fontWeight(.bold)
//
//                                            Text("\(plan.hotelStars)")
//                                                .font(Font.custom("Arial-BoldMT", size: 14))                                               .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
//                                                .fontWeight(.bold)
//                                            Image(systemName: "star.fill").foregroundColor(.yellow)
//                                                .font(.system(size: 17))
//                                        }
//
//                                        HStack {
//                                            Text("Person:")
//                                                .font(Font.custom("Baskerville-Bold", size: 17))
//                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
//                                                .fontWeight(.bold)
//
//                                            if plan.selectNumberOfPersons == 1{
//                                                Image(systemName: "person.circle")
//                                                                                               .font(.system(size: 24))
//                                                                                               .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114)) // Customize the color as needed
//                                                                                               .opacity(0.85)
//                                            } else if plan.selectNumberOfPersons == 2{
//
//                                                Image(systemName: "person.2.fill")
//                                                                                               .font(.system(size: 24))
//                                                                                               .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114)) // Customize the color as needed
//                                                                                               .opacity(0.85)
//                                            }
//                                            else{
//                                                Image(systemName: "  ")
//                                                                                               .font(.system(size: 24))
//                                                                                               .foregroundColor(Color(red: 0.722, green: 0.275, blue: 0.114)) // Customize the color as needed
//                                                                                               .opacity(0.85)
//                                            }
//
//                                        }
//
//
//                                    }
//                                    .padding(.leading,10)
//
//                                    Spacer()
//                                    VStack{
//                                        AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: plan.Image) ?? ""))
//                                              {
//                                            phase in
//                                                     switch phase {
//                                                     case.empty:
//                                                         Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
//                                                             .resizable()
//                                                             .aspectRatio(contentMode: .fit)
////                                                             .frame(width: 250, height: 150)
//                                                             .cornerRadius(20)
//                                                     case.success(let image):
//                                                         image
//                                                             .resizable()
//                                                             .aspectRatio(contentMode: .fill)
////                                                             .frame(width: 250, height: 150)
//                                                             .cornerRadius(20)
//                                                     case.failure:
//                                                         Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
//                                                             .resizable()
//                                                             .aspectRatio(contentMode: .fit)
////                                                             .frame(width: 250, height: 150)
//                                                             .cornerRadius(20)
//                        //                                 @unknown default:
//                        //                                     EmptyView()
//                                                     @unknown default:
//                                                         fatalError()
//                                                     }
//
//                                                 }
//                                            .cornerRadius(20)
//                                            .frame(width: 100)
//                                            .cornerRadius(20)
//                                            .padding(.trailing,5)
//
//
////                                        VStack{
////
////
////                                        }
////                                        .frame(width: 4)
////                                        .padding(.trailing,5)
////                                        .padding(.leading,105)
//                                    }
//                                }
//
//                            }
//                                .padding(.vertical,10)
//                            }
//                            .padding(.bottom, 10)
//                        }
//                                                                  .padding(.horizontal,22)
//                    }
//                }
//                .padding(.top, 10)
//                .padding(.bottom, 10)
//            }
////            .navigationBarTitle("Fav Plans")
//            .font(Font.custom("Charter-BlackItalic", size: 32))
