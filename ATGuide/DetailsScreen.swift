//
//  DetailsScreen.swift
//  ATGuide
//
//  Created by Michaelyoussef on 05/12/2023.
//

import SwiftUI
//struct HotelDetails {
//    let name: String
//    let image: String
//    let location: String
//}


struct DetailsScreen: View {
    
    let TripType: String
    let budget: Double
    var selectedDaysList: [[String: Any]]
    var PlanNumber: Int
    var HotelStars: Int
    let userID: String
    let planId: String
    let Image2: String
    let selectNumberOfPersons: Int
    @Binding var favStatus: Bool
    @State private var hotelsDetails: [HotelDetails] = []
//    var tripPlan: TripPlan
//      @State private var isFavorite = false
    @State private var hasError = false
    @State private var reservation = false
    @State private var isFavorite = false
    
    @State private var recommendationsPlan1: [Recommendation] = []
    @State private var recommendationsPlan2: [Recommendation] = []
    @State private var recommendationsPlan3: [Recommendation] = []
    @State private var tripHotelsNames1: [String] = []
    @State private var showDetailsSheet = false
   
    @StateObject var viewModel = firebaseViewModel()
    @State private var isLoading = true
    var body: some View {
        
        VStack() {
            HStack {
                //Spacer()
                Text("Plan Details")
                    .font(Font.custom("Charter-Black", size: 32))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                    .padding(.leading, 10)
                    .padding(.bottom,5)
                
                //
                
                
                Spacer()
                
                
                
                
                Button(action: {
                 favStatus.toggle()
                    
                    if favStatus {
                        // Add to favorites
                        if let selectedDaysListString = convertSelectedDaysListToString(selectedDaysList) {
                            viewModel.pushObject(
                                TripType: TripType,
                                HotelStars: HotelStars,
                                PlanNumber: PlanNumber,
                                budget: budget,
                                selectedDaysList: selectedDaysListString,
                                userID: userID,
                                planId: planId, 
                                Image: Image2,
                                selectNumberOfPersons: selectNumberOfPersons,
                                favStatus: favStatus
                                
                            )
                            
                        }
                    } else {
                        // Remove from favorites
                        viewModel.deletObject(TripType: TripType, userID: userID, planId: planId)
                    }
                }) {
                   // if favStatus == true{
                        Image(systemName: favStatus ? "heart.fill" : "heart")
                            .foregroundColor(favStatus ? .red : .gray)
                            .font(.title)
                        
                      
//                    }
//                    else {
//                        Image(systemName: !favStatus ? "heart" : "heart.fill")
//                            .foregroundColor(!isFavorite ? .gray : .red)
//                            .font(.title)
//                    }
                }
                .padding()
            }
            //            .onAppear(){
            //                fetchData()
            //            }
            
            
            .frame(height:25)
            
            
            
            ScrollView{
                
                //                Text("\(budget)")
                //                    .font(Font.custom("Charter-BlackItalic", size: 32))
                //                    .fontWeight(.bold)
                //                    .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                //                    .padding(.leading, 60)
                
                VStack(spacing: 20) {
                    
                    if hasError {
                        // Show redacted content while data is being fetched
                        ForEach(0..<3, id: \.self) { _ in // Displaying 3 redacted placeholders
                            RedactedPlaceholderView()
                                .id(UUID()) // Force view update
                                .padding(.top,10)
                            //                                                  .onLongPressGesture {
                            //                                                      showDetailsSheet.toggle()
                            //                                                  }
                            
                        }
                    } else   {
                        ForEach(selectedRecommendationPlan(), id: \.self) { recommendation in
                            RecommendationView(tripType: TripType, recommendation: recommendation)
                                .id(UUID()) // Force view update
                            //                                      .onLongPressGesture {
                            //                                          showDetailsSheet.toggle()
                            //                                      }
                        }
                    }
                    
                    
                }
                
                
            }
            .navigationTitle("")
            .onAppear(){
                print(TripType,budget, selectedDaysList)
            }
            
//            NavigationLink(destination: HotelReservation(hotelsDetails: hotelsDetails), isActive: $signUp ) {
//                EmptyView()
//            }
            
            Button(action: {
                reservation = true
                let details = tripHotelsDetails()
                hotelsDetails = details // Store hotel details in the state
//                print(hotelsDetails)
                
                print(hotelsDetails)
                print(selectNumberOfPersons)
                print(TripType)
                print(budget)
                print(selectedDaysList)
                print(PlanNumber)
                print(HotelStars)
                print(userID)
                print(Image2)
                print(selectNumberOfPersons)
                print(planId)
                
                
//            hotelsDetails: hotelsDetails,
//                             numberOfUser: selectNumberOfPersons,
//                             TripType:TripType,
//                             budget:budget,
//                             selectedDaysList: selectedDaysList,
//                             PlanNumber:PlanNumber,
//                             HotelStars:HotelStars,
//                             userID:userID,
//                             planId:planId,
//                             Image2:Image2,
//                             selectNumberOfPersons:selectNumberOfPersons
            }) {
                Text("Confirm")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .padding(.bottom,10)
                    .foregroundColor(.white)
                    .background(Color(red: 0.192, green: 0.259, blue: 0.333) )
                //   #c65b25
                //  .cornerRadius(10)
                
            }
            .padding(.top,7)
            .navigationDestination(
                 isPresented:$reservation) {
                     HotelReservation( hotelsDetails: hotelsDetails,
                                      numberOfUser: selectNumberOfPersons,
                                      TripType:TripType,
                                      budget:budget,
                                      selectedDaysList: selectedDaysList,
                                      PlanNumber:PlanNumber,
                                      HotelStars:HotelStars,
                                      userID:userID,
                                      planId:planId,
                                      Image2:Image2,
                                      selectNumberOfPersons:selectNumberOfPersons
                     )
                    
                 }
            //            .padding(.leading, 170)
        }
        
        .background(Image("IMG_20240104_181119 (2)").resizable().scaledToFill().clipped().edgesIgnoringSafeArea([.all]).opacity(0.5))
        .ignoresSafeArea()
        .padding(.top,10)
        .onAppear {
            fetchData()
        }
        .onDisappear(perform: {
            
        })
        
    }
  
    
    
    func tripHotelsDetails() -> [HotelDetails] {
         var uniqueHotels: [String: HotelDetails] = [:]

         let recommendations = selectedRecommendationPlan()

         for recommendation in recommendations {
             let hotelName = recommendation.hotel
//           
             if uniqueHotels[hotelName] == nil {
                 let hotelDetail = HotelDetails(name: recommendation.hotel,
                                                image: recommendation.Hotel_Image,
                                                location: recommendation.location,
                                                hotelCost: Double(recommendation.Hotel_Price)
                 )
                 uniqueHotels[hotelName] = hotelDetail
             }
         }

         let uniqueHotelDetails = Array(uniqueHotels.values)
         return uniqueHotelDetails
     }
    
    
//    func tripHotelsNames() -> [String] {
//        var uniqueHotelNamesSet = Set<String>()
//        
//        let recommendations = selectedRecommendationPlan()
//        
//        for recommendation in recommendations {
//            uniqueHotelNamesSet.insert(recommendation.hotel)
//        }
//        
//        let uniqueHotelNamesArray = Array(uniqueHotelNamesSet)
//        print(uniqueHotelNamesArray)
//        return uniqueHotelNamesArray
//    }

    
    
    func convertSelectedDaysListToString(_ list: [[String: Any]]) -> String? {
            do {
                let data = try JSONSerialization.data(withJSONObject: list, options: [])
                return String(data: data, encoding: .utf8)
            } catch {
                print("Error converting selectedDaysList to string: \(error.localizedDescription)")
                return nil
            }
        }
    
    
    func selectedRecommendationPlan() -> [Recommendation] {
        if PlanNumber == 0 {
            return recommendationsPlan1
        } else if PlanNumber == 1  {
            return recommendationsPlan2
        } else {
            return recommendationsPlan3
        }
    }
    func fetchData() {
        guard let url = URL(string: "https://ecff-156-210-173-85.ngrok-free.app/recommendations") else {
            return
        }
     
        
    
        
        let body: [String: Any] = [
            "place_type": TripType,
            "budget": budget,
             "rating":HotelStars,
            "city_day":selectedDaysList
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }

            print("HTTP Status Code: \(httpResponse.statusCode)")

            if let data = data {
                print("\(data) mivhael j")
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        for plan in jsonResponse {
                            if let recommendations = plan["best_recommendations_plan_1"] as? [[String: Any]] {
                                for recommendationData in recommendations {
                                    if let recommendation = createRecommendation(from: recommendationData) {
                                        DispatchQueue.main.async {
                                            self.recommendationsPlan1.append(recommendation)
                                            print(recommendationsPlan1)
                                        }
                                    }
                                }
                            } else if let recommendations = plan["best_recommendations_plan_2"] as? [[String: Any]] {
                                for recommendationData in recommendations {
                                    if let recommendation = createRecommendation(from: recommendationData) {
                                        DispatchQueue.main.async {
                                            self.recommendationsPlan2.append(recommendation)
                                        }
                                    } 
                                }
                            } else if let recommendations = plan["best_recommendations_plan_3"] as? [[String: Any]] {
                                for recommendationData in recommendations {
                                    if let recommendation = createRecommendation(from: recommendationData) {
                                        DispatchQueue.main.async {
                                            self.recommendationsPlan3.append(recommendation)
                                        }
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    self.hasError = true
                    print("JSON serialization error: \(error.localizedDescription)")
                }
            }else{
                print("JSON serialization error: ")
            }
        }.resume()
    }
    
//    "Hotel": "Marsa Alam Beach Resort",
//    "Hotel_Image": "marsa_alam_beach_resort_image.jpg",
//    "Hotel_Price": 280,
//    "Image": "https://drive.google.com/file/d/1newURLgoesHere/view?usp=drive_link",
//    "Location": "Marsa Alam",
//    "Place": "Marsa Alam Convention Reef",
//    "Rating": 4,
//    "Restaurant": "Marsa Alam Fish Shack - Marsa Alam",
//    "Restaurant_Image": "marsa_alam_fish_shack_image.jpg",
//    "Total Cost": 1190

    func createRecommendation(from data: [String: Any]) -> Recommendation? {
        
        guard let hotel = data["Hotel"] as? String,
              let image = data["Image"] as? String,
              let location = data["Location"] as? String,
              let place = data["Place"] as? String,
              let restaurant = data["Restaurant"] as? String,
              let hotel_Image = data["Hotel_Image"] as? String,
              let restaurant_Image = data["Restaurant_Image"] as? String,
              let totalCost = data["Total Cost"] as? Int,
              let Hotel_Price = data["Hotel_Price"] as? Int
        else {
            
            return nil
        }
        

       
        return Recommendation(hotel: hotel, Image: image, location: location, place: place, Restaurant: restaurant, TotalCost: totalCost, Hotel_Image: hotel_Image, Restaurant_Image: restaurant_Image,Hotel_Price: Hotel_Price)
    }
    
   
    
  
    
}


func convertGoogleDriveLinkToDirectImageURL(googleDriveLink: String) -> String? {
    // Extract the file ID from the Google Drive link
    guard let fileID = extractFileID(from: googleDriveLink) else {
        return nil
        
        
    }

    // Construct the direct link to the image file (assuming it's a JPEG image)
    let directImageURL = "https://drive.google.com/uc?id=\(fileID)"

    return directImageURL
}

func extractFileID(from googleDriveLink: String) -> String? {
    // Example Google Drive link format: https://drive.google.com/file/d/1cnuiVDyu5-ZqoVB2ReOXfVuJF1X6Cp05/view?usp=drive_link
    // Extract the file ID between "/d/" and "/view"
    if let startIndex = googleDriveLink.range(of: "/d/")?.upperBound,
       let endIndex = googleDriveLink.range(of: "/view")?.lowerBound {
        let fileID = String(googleDriveLink[startIndex..<endIndex])
        return fileID
    }

    return nil
}


struct Recommendation: Codable, Hashable {
    let hotel: String
    let Image: String
    let location: String
    let place: String
    let Restaurant: String
    let TotalCost: Int
    let Hotel_Image: String
    let Restaurant_Image: String
    let Hotel_Price: Int
}

struct RecommendationView: View {
    let tripType: String
    let recommendation: Recommendation
    @State private var selectedIndex = 0
    @State private var showDetailsSheet = false
    @State private var isSheetPresented = false // Separate state for sheet presentation
      private let totalImages = 3
   
    var body: some View {
       
        ZStack(alignment: .center) {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill().foregroundColor(Color.gray.opacity(0.01))
            
            Image("Modern and Minimal Company Profile Presentation (7)") // Replace "your_background_image" with your image name
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(maxWidth: .infinity, maxHeight: .infinity)
                   .edgesIgnoringSafeArea(.all)
                   .opacity(0.8)
                   .frame(maxWidth: 175)
            
            VStack{
                HStack{
                    
                    
                    
                    
                    VStack{
                        Text("Day " )
                            .font(Font.custom("Charter-BlackItalic", size: 20))
                            .foregroundColor(.black)
                            .padding(.top, 10)
                            .padding(.leading, 10) // Align to the left
                            
                        
                        Spacer()
                        Text(recommendation.location)
                            .font(Font.custom("Verdana-Bold", size: 16))
                            .foregroundColor(Color(red: 0.722, green: 0.278, blue: 0.118))
                            .padding(.top, 10)
                            .padding(.leading, 10) // Align to the left
                        Spacer()
                        
                      
                    }
                    .frame(minWidth: 100)
                    Spacer()
//                    HStack{
//                    AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: recommendation.Image) ?? ""))
//                          {
//                        phase in
//                                 switch phase {
//                                 case.empty:
//                                     ProgressView()
//                                 case.success(let image):
//                                     image
//                                         .resizable()
//                                         .aspectRatio(contentMode: .fit)
//                                 case.failure:
//                                     Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
//                                         .resizable()
//                                         .aspectRatio(contentMode: .fit)
////                                 @unknown default:
////                                     EmptyView()
//                                 @unknown default:
//                                     fatalError()
//                                 }
//                      
//                             }
//                        .cornerRadius(20)
//                        .frame(minWidth: 150,maxHeight: 150)
//                       
//                        .padding(.horizontal, 10)
//                        .padding(.vertical, 5)
//                       
                    
                  
                    
                    
                    TabView(selection: $selectedIndex) {
                               ForEach(0..<totalImages, id: \.self) { index in
                                   getImage(forIndex: index)
                                       .tag(index)
                               }
                           }
                           .tabViewStyle(PageTabViewStyle())
                           .frame(width: 210, height: 150)
                           .background(Color.white)
                           .cornerRadius(20)
                           .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 0)
                           .padding(.horizontal, 10)
                           .padding(.top, 5)
                           
                    
//                    }
//
               
                    
                }
                
                HStack(alignment: .top){
                    
                    HStack(alignment: .center){
                        
                        
                        VStack(alignment: .leading) {
                            Text(recommendation.place)
                                .font(Font.custom("Charter-BlackItalic", size: 17))
                                .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                .padding(.bottom,6)
                                .lineLimit(1)
                            Text("Hotel: \(recommendation.hotel)") // Replace with your card number Replace with your card number
                                .font(Font.custom("Charter-BlackItalic", size: 13))
                                .lineLimit(1)
                             
                            Text("Restaurant:\(recommendation.Restaurant)")// Replace with your card number
                                .font(Font.custom("Charter-BlackItalic", size: 13))
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .padding(.bottom,2)
                            
                        }.frame(maxWidth: 260, minHeight:80)
                            .padding(.top, 1)
                          
                            .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                            
                        Spacer()
                        ZStack{
                            
                            let shape = RoundedRectangle(cornerRadius: 8)
                            shape.fill().foregroundColor(Color.gray.opacity(0.01))
                            shape.stroke(Color.gray, lineWidth: 1)
                            
                            
                            Text(" \(recommendation.TotalCost) $")
                                .font(Font.custom("Cochin-Bold", size: 20))
                                .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                               // Align to the left
                        }
                        .frame(maxWidth: 70, maxHeight:30)
                        .padding(.trailing,5)
                    }
                    .padding(.horizontal,5)
                }
              
            }.cornerRadius(20)
             
            
        }
//        .onLongPressGesture {
//                                                 showDetailsSheet.toggle()
//                                             }
        .frame(height: 240) // Adjust the height as needed
        
        .background(Color.white) // Add a white background to the entire card
        .cornerRadius(20) // Round corners of the card
        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 0) // Add a shadow effect
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        
        .onTapGesture {showDetailsSheet.toggle();isSheetPresented .toggle() }
        .sheet(isPresented: $isSheetPresented) {
            // Your details sheet view
            FloatingDetailsView(hotelName: recommendation.hotel, restaurantName: recommendation.Restaurant, placeName: recommendation.place, tripType:tripType )
                .presentationDetents([.medium, .large])
           
        }
        .onLongPressGesture{showDetailsSheet.toggle();isSheetPresented .toggle()}
                   
                  
                  
       }
    
    
    
    
    
    
    
    func getImage(forIndex index: Int) -> some View {
        switch index {
        case 0:
            return AnyView(
            
                
                AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: recommendation.Image) ?? ""))
                      {
                    phase in
                             switch phase {
                             case.empty:
                                 ProgressView()
                             case.success(let image):
                                 image
                                     .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 250, height: 150)
                                     .cornerRadius(20)
                             case.failure:
                                 Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
                                     .resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(width: 250, height: 150)
                                     .cornerRadius(20)
//                                 @unknown default:
//                                     EmptyView()
                             @unknown default:
                                 fatalError()
                             }
                  
                         }
                    .cornerRadius(20)
                    .frame(width: 250, height: 150)
                    .cornerRadius(20)
            )
        case 1:
            return AnyView(
                AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: recommendation.Hotel_Image) ?? ""))
                      {
                    phase in
                             switch phase {
                             case.empty:
                                 ProgressView()
                             case.success(let image):
                                 image
                                     .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 250, height: 150)
                                     .cornerRadius(20)
                             case.failure:
                                 Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
                                     .resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(width: 250, height: 150)
                                     .cornerRadius(20)
//                                 @unknown default:
//                                     EmptyView()
                             @unknown default:
                                 fatalError()
                             }
                  
                         }
                    .cornerRadius(20)
                    .frame(width: 250, height: 150)
                    .cornerRadius(20)
            )
        case 2:
            return AnyView(
                AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: recommendation.Restaurant_Image) ?? ""))
                      {
                    phase in
                             switch phase {
                             case.empty:
                                 ProgressView()
                             case.success(let image):
                                 image
                                     .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 250, height: 150)
                                     .cornerRadius(20)
                             case.failure:
                                 Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
                                     .resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(width: 250, height: 150)
                                     .cornerRadius(20)
//                                 @unknown default:
//                                     EmptyView()
                             @unknown default:
                                 fatalError()
                             }
                  
                         }
                    .cornerRadius(20)
                    .frame(width: 250, height: 150)
                    .cornerRadius(20)
            )
        default:
            return AnyView(EmptyView())
        }
    }
    
   
}








struct RedactedPlaceholderView: View {
    @State private var selectedIndex = 0
    @State private var showDetailsSheet = false
    @State private var isSheetPresented = false // Separate state for sheet presentation
      private let totalImages = 3
    var body: some View {
        ZStack(alignment: .center) {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill().foregroundColor(Color.gray.opacity(0.01))
            
            Image("Modern and Minimal Company Profile Presentation (7)") // Replace "your_background_image" with your image name
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(maxWidth: .infinity, maxHeight: .infinity)
                   .edgesIgnoringSafeArea(.all)
                   .opacity(0.8)
                   .frame(maxWidth: 175)
            
            VStack{
                HStack{
                    
                    
                    
                    
                    VStack{
                        Text("Day " )
                            .font(Font.custom("Charter-BlackItalic", size: 20))
                            .foregroundColor(.black)
                            .padding(.top, 10)
                            .padding(.leading, 10) // Align to the left
                            
                        
                        Spacer()
                        Text("recommendation.location")
                            .font(Font.custom("Verdana-Bold", size: 16))
                            .foregroundColor(Color(red: 0.722, green: 0.278, blue: 0.118))
                            .padding(.top, 10)
                            .padding(.leading, 10) // Align to the left
                        Spacer()
                        
                      
                    }
                    .frame(minWidth: 100)
                    Spacer()
//                    HStack{
                 
                       
                    
                  
                    
                    
                   ProgressView()
                           .frame(width: 210, height: 150)
                         //  .background(Color.white)
                           .cornerRadius(20)
                           .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 0)
                           .padding(.horizontal, 10)
                           .padding(.top, 5)
                          
                           .onAppear {
                               // startTimer()
                           }
                           .onChange(of: 3) { 
                             //  startTimer()
                           }
                    
//                    }
//
               
                    
                }
                
                HStack(alignment: .top){
                    
                    HStack(alignment: .center){
                        
                        
                        VStack(alignment: .leading) {
                            Text("recommendation.place")
                                .font(Font.custom("Charter-BlackItalic", size: 19))
                                .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                .padding(.bottom,6)
                            
                            Text("Hotel: \("recommendation.hotel")") // Replace with your card number Replace with your card number
                                .font(Font.custom("Charter-BlackItalic", size: 13))
                               
                             
                            Text("Restaurant:\("recommendation.Restaurant")")// Replace with your card number
                                .font(Font.custom("Charter-BlackItalic", size: 13))
                                .multilineTextAlignment(.center)
                                .padding(.bottom,2)
                            
                        }.frame(minWidth: 270, minHeight:80)
                            .padding(.top, 1)
                          
                            .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                            
                        Spacer()
                        ZStack{
                            
                            let shape = RoundedRectangle(cornerRadius: 8)
                            shape.fill().foregroundColor(Color.gray.opacity(0.01))
                            shape.stroke(Color.gray, lineWidth: 1)
                            
                            
                            Text(" \("recommendation.TotalCost") $")
                                .font(Font.custom("Cochin-Bold", size: 20))
                                .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                               // Align to the left
                        }
                        .frame(maxWidth: 120, maxHeight:30)
                        .padding(.trailing,5)
                    }
                    .padding(.horizontal,5)
                }
              
            }.cornerRadius(20)
             
            
        }
        .frame(height: 240) // Adjust the height as needed
        
        .background(Color.white) // Add a white background to the entire card
        .cornerRadius(20) // Round corners of the card
        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 0) // Add a shadow effect
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .redacted(reason: .placeholder)
        .onTapGesture {  }
        .onLongPressGesture{showDetailsSheet.toggle();isSheetPresented .toggle()}
                   
                   .sheet(isPresented: $isSheetPresented) {
                       // Your details sheet view
                       FloatingDetailsView(hotelName: "", restaurantName: "", placeName: "" ,tripType: "" )
                           .presentationDetents([.medium, .large])
                   }
    }
}


struct FloatingDetailsView: View {
    let hotelName: String
    let restaurantName: String
    let placeName: String
    let tripType: String
    
    @State private var hotelData: HotelData?
    @State private var placeData: PlaceData?
    @State private var restaurantData: RestaurantData?
    var body: some View {
        
        ScrollView{
            
            VStack(alignment: .leading, spacing: 1) {
                
                if let hotelData = hotelData {
                    HStack{
                        AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: hotelData.image) ?? ""))
                        {
                            phase in
                            switch phase {
                            case.empty:
                                ProgressView()
                            case.success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 150)
                                    .cornerRadius(10)
                            case.failure:
                                Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 250, height: 150)
                                    .cornerRadius(10)
                                //                                 @unknown default:
                                //                                     EmptyView()
                            @unknown default:
                                fatalError()
                            }
                            
                        }
                        
                        .frame( height: 150)
                        .cornerRadius(10)
                    }
                    HStack{
                        HStack{
                            VStack(alignment:.leading){
                                
                                
                                
                                //                    HotelDetailsView(data: hotelData)
                                Text("\(hotelData.name)")
                                
                                    .font(Font.custom("Charter-Black", size: 22))
                                    .fontWeight(.bold)
                                    .padding(.bottom,5)
                                    .bold()
                                    .lineLimit(1)
                                
                                
                                
                                Text("Price Range: $ \(hotelData.price_range)")
                                    .foregroundColor(.green)
                                    .padding(.bottom,5)
                                    .font(Font.custom("Charter-Black", size: 14))
                                Text("Location: \(hotelData.location)")
                                    .foregroundColor(.gray)
                                    .font(Font.custom("", size: 14))
                                
                                HStack{
                                    Text("Rate: \(hotelData.rate)")
                                        .foregroundColor(.black).opacity(0.8)
                                        .font(Font.custom("", size: 14))
                                    
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.yellow)
                                }
                            }
                        }
                        Spacer()
                        VStack{
                            
                            Image("hotel-3d-icon-illustrations")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 100)
                            //  .opacity(0.7)
                        }
                        
                    }
                    
                    
                    Text("\(hotelData.description)")
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 5)
                        .font(Font.custom("", size: 12))
                }
                    }
            .padding()
                    .background(Color.white)
            
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
            
            
            
            
            VStack(alignment: .leading, spacing: 1) {
                if let restaurantData = restaurantData{
                HStack{
                    AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: restaurantData.image_source) ?? ""))
                    {
                        phase in
                        switch phase {
                        case.empty:
                            ProgressView()
                        case.success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: .infinity, height: 150)
                                .cornerRadius(10)
                        case.failure:
                            Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, height: 150)
                                .cornerRadius(10)
                            //                                 @unknown default:
                            //                                     EmptyView()
                        @unknown default:
                            fatalError()
                        }
                        
                    }
                    
                    .frame(width: .infinity, height: 150)
                    .cornerRadius(10)
                }
                HStack{
                    HStack{
                        VStack(alignment:.leading){
                            Text("\(restaurantData.name)")
                                .font(Font.custom("Charter-Black", size: 22))
                                .fontWeight(.bold)
                                .padding(.bottom,5)
                                .bold()
                                .lineLimit(1)
                            
                            Text("Ticket Price: $\(restaurantData.price_range)")
                                .foregroundColor(.green)
                                .padding(.bottom,5)
                                .font(Font.custom("Charter-Black", size: 14))
                            Text("Location: \(restaurantData.location)")
                                .foregroundColor(.gray)
                                .font(Font.custom("", size: 14))
                         
                        }
                        Spacer()
                        VStack{
                            
                            Image("vecteezy_3d-rendering-of-a-restaurant-building-illustration_23523075")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 100)
                            //  .opacity(0.7)
                        }
                        
                    }
                    
                }
                    Text("\(restaurantData.description)")
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 5)
                    .font(Font.custom("", size: 12))
            }
                    }
            .padding()
                    .background(Color.white)
            
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
            
     
            
            
            VStack(alignment: .leading, spacing: 1) {
                
                if let placeData = placeData {
                    HStack{
                        AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: placeData.image_source) ?? ""))
                        {
                            phase in
                            switch phase {
                            case.empty:
                                ProgressView()
                            case.success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 150)
                                    .cornerRadius(10)
                            case.failure:
                                Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame( height: 150)
                                    .cornerRadius(10)
                                //                                 @unknown default:
                                //                                     EmptyView()
                            @unknown default:
                                fatalError()
                            }
                            
                        }
                        
                        .frame( height: 150)
                        .cornerRadius(10)
                    }
                    HStack{
                        HStack{
                            VStack(alignment:.leading){
                                
                                
                                
                                //                    HotelDetailsView(data: hotelData)
                                Text("\(placeData.name)")
                                
                                    .font(Font.custom("Charter-Black", size: 22))
                                    .fontWeight(.bold)
                                    .padding(.bottom,5)
                                    .bold()
                                    .lineLimit(1)
                                
                                
                                
                                Text("Price Range: $ \(placeData.ticket_price)")
                                    .foregroundColor(.green)
                                    .padding(.bottom,5)
                                    .font(Font.custom("Charter-Black", size: 14))
                                Text("Location: \(placeData.location)")
                                    .foregroundColor(.gray)
                                    .font(Font.custom("", size: 14))
                                
                              
                            }
                        }
                        Spacer()
                        VStack{
                            
                            Image("hotel-3d-icon-illustrations")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 100)
                            //  .opacity(0.7)
                        }
                        
                    }
                    
                    
                    Text("\(placeData.description)")
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 5)
                        .font(Font.custom("", size: 12))
                }
                    }
            .padding()
                    .background(Color.white)
            
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
        }
        .onAppear(perform: {
            fetchDataDetails()
        })
    }
    
    
    
    func fetchDataDetails() {
           guard let url = URL(string: "https://ecff-156-210-173-85.ngrok-free.app/get_details") else {
               return
           }
           
           let body: [String: Any] = [
               "place_name": placeName,
               "hotel_name": hotelName,
               "restaurant_name": restaurantName,
               "place_type": tripType
           ]
           
           do {
               let jsonData = try JSONSerialization.data(withJSONObject: body)
               
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               request.httpBody = jsonData
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               
               URLSession.shared.dataTask(with: request) { data, response, error in
                   guard let data = data, error == nil else {
                       return
                   }
                   
                   do {
                       let decodedData = try JSONDecoder().decode(APIResponse.self, from: data)
                       
                       DispatchQueue.main.async {
                           self.hotelData = decodedData.hotel
                           self.placeData = decodedData.place
                           self.restaurantData = decodedData.restaurant
                       }
                   } catch {
                       print(error.localizedDescription)
                   }
               }.resume()
           } catch {
               print(error.localizedDescription)
           }
       }
}



struct APIResponse: Decodable {
    let hotel: HotelData?
    let place: PlaceData?
    let restaurant: RestaurantData?
}

struct HotelData: Decodable {
    let description: String
    let image: String
    let location: String
    let name: String
    let price_range: Int
    let rate: Int
}

struct PlaceData: Decodable {
    let description: String
    let image_source: String
    let location: String
    let name: String
    let other: String
    let ticket_price: Int
}

struct RestaurantData: Decodable {
    let cuisine: String
    let description: String
    let image_source: String
    let location: String
    let name: String
    let price_range: Int
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen(TripType: "conference_places", budget: 89898, selectedDaysList:[
            [
            
            "days":2,
            "city":"Marsa Alam"
            ],
            [
                "days":2,
            "city":"Alexandria"
            
            ],
             [
            "city":"Luxor",
            "days":2
            ]

        ] , PlanNumber: 0, HotelStars: 4, userID: "87987",planId: "mm", Image2: "", selectNumberOfPersons: 2 ,favStatus: Binding.constant(false) )
    }
}
 
 
 
