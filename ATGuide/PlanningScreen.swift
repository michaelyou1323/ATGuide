


    import SwiftUI
    import QuartzCore
    import SDWebImageSwiftUI
import UIKit
    struct TripPlan {
        var destination: String
        var activities: [String: Double]
        var totalCost: Double
    }

    struct ArrowShape: Shape {
        func path(in rect: CGRect) -> Path {
            Path { path in
                path.move(to: CGPoint(x: rect.midX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
                path.closeSubpath()
            }
        }
    }




    struct TripPlanDetails {
        var destination: String
        var totalCost: Double
        // Add other relevant properties from your TripPlan structure
    }

    struct tripPlan {
        var tripType: String
        var citiesInfo: [CityInfo]
        var hotelStars: Int
        var enteredBudget: Int
    }


    extension PlanningScreen {
        var totalNumberOfDays: Int {
            citiesInfo.reduce(0) { $0 + $1.numberOfDays }
        }
    }

    extension PlanningScreen {
        var convertedBudget: Int {
            guard let budget = Int(tripBudget) else {
                return 0 // Return a default value if conversion fails
            }
            return budget
        }
    }




extension AnyTransition {
    static var moveAndFade: AnyTransition {
        AnyTransition.slide
    }
}



struct CityInfo {
    let cityName: String
    var numberOfDays: Int
}



    struct PlanningScreen: View {
        let userID: String
        
        @State private var counts: [Int] = Array(repeating: 0, count: 6)
        
      
         @State private var citiesInfo: [CityInfo] = Array(repeating: CityInfo(cityName: "", numberOfDays: 0), count: 6)
        let cityInformation: [Int: [String]] = [
              1: ["Cairo", "Alexandria", "Aswan", "Luxor"], // culture_places
              2: ["Siwa", "Luxor", "Assiut"], // sports_places
              3: ["Fayoum", "Ras Sudr", "Nuweiba"], // desert_places
              4: ["Cairo", "Alexandria", "Aswan", "Luxor"], // medical_places
              5: ["Siwa", "Luxor", "Assiut"], // festival_places
              6: ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"], // conference_places
              7: ["Siwa", "Luxor", "Assiut"], // pleasure_places
              8: ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"], // religious_places
              
          ]
  
        
        @State private var tripBudget: String = ""
        @State private var duration: String = ""
        @State  var apiUrl: String = ""
        let tripTypes = ["Select trip type", "Culture", "Sports", "Desert", "Medical", "Festival", "Conference","Pleasure","Religious"]

        
       
//        let Religious = ["Cairo", "Alexandria", "Aswan", "Luxor"]
//        
//        let Sports = ["a", "Siwa", "b", "Luxor", "h", "Assiut"]
//        let Desert = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
//        let Medical = ["8787", "dddd", "jh", "jjhj", "Giza", "Assiut"]
//        let Festivals = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
//        let conference_places = ["Cairo", "Alexandria", "Marsa Alam", "Sharm El Sheikh"]
//        
        
        
//        let Cairo = ["A1", "A2", "A3", "A4", "A5", "A6"]
//        let Siwa = ["B1", "B2", "B3", "B4", "B5", "B6"]
//        let Aswan = ["c1", "c2", "c3", "c4", "c5", "c6"]
//        let Lucor = ["D1", "d2", "d3", "d4", "d5", "d6"] 
//        let Giza = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
//        let Assiut = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
        
        
        @State private var recommendationsPlan12: [Recommendation] = []
        @State private var recommendationsPlan22: [Recommendation] = []
        @State private var recommendationsPlan32: [Recommendation] = []
      
          
        let tripPrices = [0, 3000, 2000, 4500, 6000, 7000, 9000,1000,11111] as [Any]
        @State private var selectedTripType = 0
        @State private var selectedHotelRoom = 0
        @State private var showGeneratButton = 0
        @State private var showResetButton = 0
        
        @State private var showCities = true
        @State private var chosenTripType = ""
        @State private var generatedPlan: TripPlan? = nil
        @State private var religiousCityCounts = Array(repeating: 0, count: 6)
       
      //  private let tripPlanner = TripPlanner()
        
        @FocusState private var isBudgetFieldFocused: Bool
        @FocusState private var isDurationFieldFocused: Bool
        @State private var showAlert = false
        @State private var errorMessage = ""
        @State private var selectedReligiousCity = 0
        @State private var religiousCityText = "Select trip city"
       // @State private var religiousCityCount = Array(repeating: 0, count: 7)
        @State private var showCityList = false
        @State private var isMenuOpen: Bool = false
        @State private var generatePlan: Bool = false
        
        @State private var showPlann = 0
        @State private var navigateToNextView = false
        @State private var isBudgetFieldEnabled = false
        @State private var showBudgetField = false
        @State private var isPickerEnabled = true
     
         // @State private var religiousCityCount = Array(repeating: 0, count: 7)
        let Triptype = [
               "",
               "culture_places", // Religious
               "sports_places", // Sports
               "desert_places", // Desert
               "medical_places", // Religious 
               "festival_places", // Sports
               "conference_places", // Desert
               "pleasure_places", // Sports
               "religious_places", // Desert
          ]

           @State private var selectedStars = 1
        @State private var showPlannPlans: [TripPlan] = []
    //    @State private var currencies: [Currency] = []
     @State private var isShowingFavouriteScreen = false
        @State private var selectedDaysForCities: [Int] = Array(repeating: 0, count: 6)
      
        func fetchDataBasedOnChoices() {
               if !chosenTripType.isEmpty && convertedBudget > 0 && totalNumberOfDays > 0 {
                   // Call the fetchPlansData function here
    //               fetchPlansData(chosenTripType: chosenTripType, convertedBudget: convertedBudget, totalNumberOfDays: totalNumberOfDays)
                   
               } else {
                   // Handle incomplete data scenario, such as showing an error message to the user
                   print("Please select trip type, enter budget, and calculate total number of days.")
               }
           }
        
        
        func fetchData() {
            guard let url = URL(string: "https://468c-156-209-212-138.ngrok-free.app/recommendations") else {
                return
            }

            print(getSelectedTrip() + "-----------")
            let body: [String: Any] = [
                "place_type":getSelectedTrip(),
                "budget": Double(tripBudget) ??  0.0,
                 "rating":selectedStars,
                "city_day":reverseCityDaysPosition(getSelectedDaysForCities())
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
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                            for plan in jsonResponse {
                                if let recommendations = plan["best_recommendations_plan_1"] as? [[String: Any]] {
                                    for recommendationData in recommendations {
                                        if let recommendation = createRecommendation2(from: recommendationData) {
                                            DispatchQueue.main.async {
                                                self.recommendationsPlan12.append(recommendation)
//                                                print(recommendationsPlan1)
                                            }
                                        }
                                    }
                                } else if let recommendations = plan["best_recommendations_plan_2"] as? [[String: Any]] {
                                    for recommendationData in recommendations {
                                        if let recommendation = createRecommendation2(from: recommendationData) {
                                            DispatchQueue.main.async {
                                                self.recommendationsPlan22.append(recommendation)
                                            }
                                        }
                                    }
                                } else if let recommendations = plan["best_recommendations_plan_3"] as? [[String: Any]] {
                                    for recommendationData in recommendations {
                                        if let recommendation = createRecommendation2(from: recommendationData) {
                                            DispatchQueue.main.async {
                                                self.recommendationsPlan32.append(recommendation)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } catch {
                      //  print("JSON serialization error: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
        
        func createRecommendation2(from data: [String: Any]) -> Recommendation? {
            
            guard let hotel = data["Hotel"] as? String,
                  let image = data["Image"] as? String,
                  let location = data["Location"] as? String,
                  let place = data["Place"] as? String,
                  let restaurant = data["Restaurant"] as? String,
                  let totalCost = data["Total Cost"] as? Int else {
                
                return nil
            }
            

           
               return Recommendation(hotel: hotel, Image: image, location: location, place: place, Restaurant: restaurant, TotalCost: "\(totalCost)")
        }
        
        
   

        var body: some View {
            
            
          
            VStack( ){
    //
                
                    
                ZStack {
                    let shape = RoundedRectangle(cornerRadius: 20)
                    if isPickerEnabled {
                        shape.fill().foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                    }
                    else {
                        
                        shape.fill().foregroundColor(Color.gray)
                    }
                  
//                    shape.stroke(Color(red: 0, green: 0.243, blue: 0.502), lineWidth: 1)
    //
                    
                    
                        Picker(selection: $selectedTripType, label: Text("Select trip type").font(Font.custom("Zapfino", size: 20))) {
                            ForEach(tripTypes.indices, id: \.self) { index in
                                Text(self.tripTypes[index])
                                    .font(Font.custom("Zapfino", size: 20))
                            }
                        }
                    

                        .accentColor(.white)
                        .onChange(of: selectedTripType, initial: false){ initial, _ in
                                       updateCitiesInfo()
                                       updateCounts()
                                       getSelectedTrip()
                                   }
                    
                        .pickerStyle(MenuPickerStyle())
                    
                        .disabled(!isPickerEnabled)
               

                }
                .frame(height: 35)
                .padding(.top,10)
                .padding(.bottom, 10)
                .padding(.horizontal, 110)
//                .onChange(of: selectedTripType) { newValue in
//                            resetChoices() // Reset counts and days selected for cities
//                        }
//                
                
                if showBudgetField == true {
                    VStack(spacing: 0) {
                     
                   
                    TextField("Enter trip budget", text: $tripBudget)
                           
                        .keyboardType(.numberPad)
                        .textFieldStyle(CustomTextFieldStyle(isFocused: isBudgetFieldFocused, isEnabled: isBudgetFieldEnabled))
                        .textFieldStyle(PlainTextFieldStyle())
                        .disabled(selectedTripType == 0)
                        .lineLimit(5...10)
                        .onChange(of: tripBudget, initial: true){ initial, newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                tripBudget = filtered
                            }
                        }
                        
                        HStack(){
                            Spacer()
                            Text("Minimum: (\(getMinimumPrice())) for this type")
                                .font(Font.custom("Cochin-BoldItalic", size: 13))
                                .padding(.top,0)
                        }
                    
                    
                    
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 15)
                }
                
                
                    if selectedTripType != 0  && showCities == true {
                        ZStack{
                            let shape = RoundedRectangle(cornerRadius: 9)
                            shape.fill().foregroundColor(.white)
                            shape.stroke(Color(red: 0, green: 0.243, blue: 0.502), lineWidth: 1)
                            Text("Choose your preferred city:")
                            
                                .font(Font.custom("Cochin-BoldItalic", size: 28))
                                .padding(.bottom,2)
                            //  SnellRoundhand-Bold
                            //
                        }
                        
                        .frame(height: 45)
                        .padding(.top,10)
                        .padding(.bottom, 20)
                        .padding(.horizontal, 30)
                            HStack {
                                Text("City")
                                    .padding(.leading,7)
                                    .font(Font.custom("DINCondensed-Bold", size: 21))
                                Spacer()
                                Text("Days")
                                    .padding(.trailing,35)
                                    .font(Font.custom("DINCondensed-Bold", size: 21))
                                //
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal,33)
                            .padding(.bottom, 5)
                            
                            
                            
                        List {
                                       ForEach(getCitiesForTripType(), id: \.self) { city in
                                           let index = getCitiesForTripType().firstIndex(of: city) ?? 0
                                           HStack {
                                               Text(city)
                                               Spacer()

                                               Button(action: {
                                                   self.incrementCount(index)
                                               }) {
                                                   Image(systemName: "plus.circle")
                                                       .foregroundColor(Color(red: 0.192, green: 0.259, blue: 0.333))
                                               }
                                               .buttonStyle(BorderlessButtonStyle())

                                               Text("\(self.counts[index])")
                                                   .padding(.horizontal, 10)

                                               Button(action: {
                                                   self.decrementCount(index)
                                               }) {
                                                   Image(systemName: "minus.circle")
                                                       .foregroundColor(Color(red: 0.192, green: 0.259, blue: 0.333))
                                               }
                                               .buttonStyle(BorderlessButtonStyle())
                                           }
                                           .contentShape(Rectangle())
                                          
                                       }
                                       
                            
                            Button(action: {
                                nextButtonAction()
                                showBudgetField = true
                                isBudgetFieldEnabled = true
                            }) {
                                Text("Next")
                                    .foregroundColor(.white)
                                    .padding(.horizontal,110)
                                    .padding(.vertical, 5)
                                    .background(Color(red: 0.192, green: 0.259, blue: 0.333))
                                    .cornerRadius(8)
                                    .font(Font.custom("Baskerville-Bold", size: 16))
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
//                                   .padding(.trailing, 30)
                            .padding(.top,30)
                                   }
                        .accentColor(.blue)
                       // .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
    
                       

                                   
                               }
                    
                
                else if( selectedTripType == 0 && showPlann == 0 && selectedHotelRoom == 0) {
                        // Show an empty frame with a height of 400 when no trip type is selected
                        VStack {
                            Spacer()
//
//                            if let gifImage = UIImage(named: "image_processing20220708-21892-cye7ve.gif") {
//                                           Image(uiImage: gifImage)
//                                               .resizable()
//                                               .aspectRatio(contentMode: .fill)
//                                              
//                                             .frame(width: 500, height: 500)
//                                       }
                            
                            AnimatedImage(name: "image_processing20220708-21892-cye7ve.gif")
                                .resizable()
                                                                              .aspectRatio(contentMode: .fill)
                            
                                                                            .frame(width: 1, height: 470)
                                                                            .padding(.leading,80)
                            Spacer()
                        }
                    }
                    
                if selectedHotelRoom != 0 {
                  
                    Rectangle()
                        .fill(Color.gray.opacity(0.01))
                        .frame(height: 50)
           
                    Text("Select Hotel Stars")
                        
                       
                        .bold()
                        .padding(.bottom,10)
                        .font(Font.custom("Zapfino", size: 25))
                       
                 
                        
                            HStack {
                                ForEach(1..<6) { star in
                                    Image(systemName: selectedStars >= star ? "star.fill" : "star")
                                        .foregroundColor(selectedStars >= star ? .yellow : .yellow)
                                       
                                        .onTapGesture {
                                            selectedStars = star
                                        }
                                }
                            }
                            .font(Font.custom("Zapfino", size: 25))
                           
                    Rectangle()
                        .fill(.white)
                        .frame(height: 15)
                        
                 
                    
                        Button(action: {
                            withAnimation {
                                
                             
                               
                                //showGeneratButton = 1
                                let selectedDaysList = getSelectedDaysForCities()
                               // print(selectedDaysList) // This list is in the format you requested
                               // ensureCityBeforeDays(selectedDaysList)
                                let selectedDaysList2 =  ensureCityBeforeDays(selectedDaysList)
                                reverseCityDaysPosition(selectedDaysList2)
                                
                               
                                    validateBudget()
                                    fetchData()
                                
                            }
                        }) {
                            Text("Generat Plan")
                                .foregroundColor(.white)
                                .padding(.horizontal,110)
                                .padding(.vertical, 10)
                                .background(Color(red: 0.192, green: 0.259, blue: 0.333))
                                .cornerRadius(8)
                                .font(Font.custom("Baskerville-Bold", size: 16))
                        }
                        .frame(maxWidth: .infinity, alignment: .center)

                        .padding(.top,30)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Note"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                        }
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 50)
                }
                  
                if showPlann == 1 {
    
                    ZStack{
                        let shape = RoundedRectangle(cornerRadius: 9)
                        shape.fill().foregroundColor(.white)
                        shape.stroke(Color(red: 0, green: 0.243, blue: 0.502), lineWidth: 1)
                        HStack{
                            Text("We plan... ")
                                .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                                .font(Font.custom("Cochin-BoldItalic", size: 28))
                                .padding(.bottom,2)
                            //  SnellRoundhand-Bold
                            Text("You choose")
                                .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                .font(Font.custom("SnellRoundhand-Bold", size: 28))
                                .padding(.bottom,2)
                        }
                        
                    }
                    
                    .frame(height: 45)
                    .padding(.top,5)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 40)
                    .onAppear{
                        withAnimation {
                            
                        }
                    }
                    
                        
                    ScrollView{
                        
                    
                        NavigationLink( destination: DetailsScreen(TripType: getSelectedTrip() , budget: Double(tripBudget) ??  0.0, selectedDaysList: reverseCityDaysPosition(getSelectedDaysForCities()), PlanNumber: 0, HotelStars: selectedStars, userID:userID ,planId:generateRandomPlanID() )) {
                            ZStack(alignment: .center) {
                                
                                
                                Image("Modern and Minimal Company Profile Presentation (2)") // Replace "your_background_image" with your image name
                                       .resizable()
                                       .aspectRatio(contentMode: .fill)
                                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                                       .edgesIgnoringSafeArea(.all)
                                       .opacity(0.8)
                                       .frame(maxWidth: 175)
            //                                   RoundedRectangle(cornerRadius: 20)
            //                                       .fill(Color.white) // Background color of the card
            //                                       .shadow(color: Color.gray.opacity(0.7), radius: 5, x: 0, y: 3) // Shadow effect

                                let shape = RoundedRectangle(cornerRadius: 20)
                                shape.fill().foregroundColor(Color.gray.opacity(0.01))
                                
                                  
                                VStack {
                                  
                                    
                                 
                                    
                                    
                                    HStack {
                                        if let firstLocation = recommendationsPlan12.first?.location {
                                            Text(firstLocation)
                                                .font(Font.custom("Charter-BlackItalic", size: 20))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .padding(.top, 5)
                                                .fontWeight(.bold)
                                                .padding(.leading, 10) // Align to the left
                                            Spacer() // Pushes text to the left
                                            // Cochin-Bold
                                            Text("Plan 1")
                                            .font(Font.custom("Cochin-Bold", size: 20))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .padding(.top, 5)
                                                .fontWeight(.bold)
                                                .padding(.trailing, 5) // Al
                                            
                                          }
            //
            //
                                    }
                                    Spacer()
                                    VStack {
                                       if let firstImage = recommendationsPlan12.first?.Image {
                                            AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: firstImage) ?? "")) { phase in
                                                switch phase {
                                                    case .empty:
                                                    ProgressView()
                                                    case .success(let image):
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill) // Maintain the aspect ratio by filling the frame
                                                            .frame(maxWidth: 185, maxHeight: 110) // Set the fixed size of the image
                                                    case .failure:
                                                        Image("1024 1")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit) // Maintain the aspect ratio by filling the frame
                                                        .frame(maxWidth: 185, maxHeight: 110)
                                                @unknown default:
                                                    fatalError()
                                                }
                                            }
                                            .cornerRadius(20)
                                        }
            //
                                    }
                                    .frame(minWidth: 185, minHeight: 120)
                                    .background(Color.white) // Add a white background for the image container
                                    .cornerRadius(10) // Round corners of the image container
                          
                                    Spacer()
                                    HStack {
                                      
                                       if let firstplace = recommendationsPlan12.first?.place {// Pushes text to the right
                                            Text(firstplace) // Replace with your card number
                                            .font(Font.custom("Charter-BlackItalic", size: 20))
                                                .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                                
                                                .padding(.bottom,5)
                                       }
                                    }
                                }
                                
                                
                           
                            }
                            .frame(maxHeight: 175) // Adjust the height as needed
                                                       .padding(.vertical, 10)
                                                       
                                                       .background(Color.white) // Add a white background to the entire card
                                                       .cornerRadius(20) // Round corners of the card
                                                       .shadow(color: Color.gray.opacity(0.7), radius: 5, x: 0, y: 3) // Add a shadow effect
                                                       .padding(.horizontal, 40)
                            
                            
                    }
                    .padding(.bottom, 5) 
                    
                    
                        NavigationLink( destination: DetailsScreen(TripType: Triptype[selectedTripType], budget: Double(tripBudget) ??  0.0, selectedDaysList: reverseCityDaysPosition(getSelectedDaysForCities()), PlanNumber: 1, HotelStars: selectedStars, userID:userID ,planId:generateRandomPlanID() )) {
                            ZStack(alignment: .center) {
                                
                                
                                Image("Modern and Minimal Company Profile Presentation (2)") // Replace "your_background_image" with your image name
                                       .resizable()
                                       .aspectRatio(contentMode: .fill)
                                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                                       .edgesIgnoringSafeArea(.all)
                                       .opacity(0.8)
                                       .frame(maxWidth: 175)
            //                                   RoundedRectangle(cornerRadius: 20)
            //                                       .fill(Color.white) // Background color of the card
            //                                       .shadow(color: Color.gray.opacity(0.7), radius: 5, x: 0, y: 3) // Shadow effect

                                let shape = RoundedRectangle(cornerRadius: 20)
                                shape.fill().foregroundColor(Color.gray.opacity(0.01))
                                
                                  
                                VStack {
                                  
                                    
                                 
                                    
                                    
                                    HStack {
                                        if let firstLocation = recommendationsPlan22.last?.location {
                                            Text(firstLocation)
                                                .font(Font.custom("Charter-BlackItalic", size: 20))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .padding(.top, 5)
                                                .fontWeight(.bold)
                                                .padding(.leading, 10) // Align to the left
                                            Spacer() // Pushes text to the left
                                            // Cochin-Bold
                                            Text("Plan 2")
                                            .font(Font.custom("Cochin-Bold", size: 20))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .padding(.top, 5)
                                                .fontWeight(.bold)
                                                .padding(.trailing, 5) // Al
                                            
                                          }
            //
            //
                                    }
                                    Spacer()
                                    VStack {
                                       if let firstImage = recommendationsPlan22.last?.Image {
                                            AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: firstImage) ?? "")) { phase in
                                                switch phase {
                                                    case .empty:
                                                    ProgressView()
                                                    case .success(let image):
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill) // Maintain the aspect ratio by filling the frame
                                                            .frame(maxWidth: 185, maxHeight: 110) // Set the fixed size of the image
                                                    case .failure:
                                                        Image("1024 1")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit) // Maintain the aspect ratio by filling the frame
                                                        .frame(maxWidth: 185, maxHeight: 110)
                                                @unknown default:
                                                    fatalError()
                                                }
                                            }
                                            .cornerRadius(20)
                                        }
            //
                                    }
                                    .frame(minWidth: 185, minHeight: 120)
                                    .background(Color.white) // Add a white background for the image container
                                    .cornerRadius(10) // Round corners of the image container
                          
                                    Spacer()
                                    HStack {
                                      
                                       if let firstplace = recommendationsPlan22.last?.place {// Pushes text to the right
                                            Text(firstplace) // Replace with your card number
                                            .font(Font.custom("Charter-BlackItalic", size: 20))
                                                .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                                
                                                .padding(.bottom,5)
                                       }
                                    }
                                }
                                
                                
                           
                            }
                            .frame(minHeight: 175) // Adjust the height as needed
                                                       .padding(.vertical, 10)
                                                       
                                                       .background(Color.white) // Add a white background to the entire card
                                                       .cornerRadius(20) // Round corners of the card
                                                       .shadow(color: Color.gray.opacity(0.7), radius: 5, x: 0, y: 3) // Add a shadow effect
                                                       .padding(.horizontal, 40)
                            
                        }
                        .padding(.bottom, 5)
                    
                        NavigationLink( destination: DetailsScreen(TripType: Triptype[selectedTripType], budget: Double(tripBudget) ??  0.0, selectedDaysList: reverseCityDaysPosition(getSelectedDaysForCities()), PlanNumber: 2, HotelStars: selectedStars, userID:userID ,planId:generateRandomPlanID() )) {
                            ZStack(alignment: .center) {
                                
                                
                                Image("Modern and Minimal Company Profile Presentation (2)") // Replace "your_background_image" with your image name
                                       .resizable()
                                       .aspectRatio(contentMode: .fill)
                                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                                       .edgesIgnoringSafeArea(.all)
                                       .opacity(0.8)
                                       .frame(maxWidth: 175)
            //                                   RoundedRectangle(cornerRadius: 20)
            //                                       .fill(Color.white) // Background color of the card
            //                                       .shadow(color: Color.gray.opacity(0.7), radius: 5, x: 0, y: 3) // Shadow effect

                                let shape = RoundedRectangle(cornerRadius: 20)
                                shape.fill().foregroundColor(Color.gray.opacity(0.01))
                                
                                  
                                VStack {
                                  
                                    
                                 
                                    
                                    
                                    HStack {
                                        if let firstLocation = recommendationsPlan32.first?.location {
                                            Text(firstLocation)
                                                .font(Font.custom("Charter-BlackItalic", size: 20))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .padding(.top, 5)
                                                .fontWeight(.bold)
                                                .padding(.leading, 10) // Align to the left
                                            Spacer() // Pushes text to the left
                                            // Cochin-Bold
                                            Text("Plan 3")
                                            .font(Font.custom("Cochin-Bold", size: 20))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .padding(.top, 5)
                                                .fontWeight(.bold)
                                                .padding(.trailing, 5) // Al
                                            
                                          }
            //
            //
                                    }
                                    Spacer()
                                    VStack {
                                       if let firstImage = recommendationsPlan32.first?.Image {
                                            AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: firstImage) ?? "")) { phase in
                                                switch phase {
                                                    case .empty:
                                                    ProgressView()
                                                    case .success(let image):
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill) // Maintain the aspect ratio by filling the frame
                                                            .frame(maxWidth: 185, maxHeight: 110) // Set the fixed size of the image
                                                    case .failure:
                                                        Image("1024 1")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit) // Maintain the aspect ratio by filling the frame
                                                        .frame(maxWidth: 185, maxHeight: 110)
                                                @unknown default:
                                                    fatalError()
                                                }
                                            }
                                            .cornerRadius(20)
                                        }
            //
                                    }
                                    .frame(minWidth: 185, minHeight: 120)
                                    .background(Color.white) // Add a white background for the image container
                                    .cornerRadius(10) // Round corners of the image container
                          
                                    Spacer()
                                    HStack {
                                      
                                       if let firstplace = recommendationsPlan32.first?.place {// Pushes text to the right
                                            Text(firstplace) // Replace with your card number
                                            .font(Font.custom("Charter-BlackItalic", size: 20))
                                                .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                                
                                                .padding(.bottom,5)
                                       }
                                    }
                                }
                                
                                
                           
                            }
                            .frame(maxHeight: 175) // Adjust the height as needed
                                                       .padding(.vertical, 10)
                                                       
                                                       .background(Color.white) // Add a white background to the entire card
                                                       .cornerRadius(20) // Round corners of the card
                                                       .shadow(color: Color.gray.opacity(0.7), radius: 5, x: 0, y: 3) // Add a shadow effect
                                                       .padding(.horizontal, 40)
                        }
                        .padding(.bottom, 5)
                    }
                    
                    .padding(.bottom, 5)
                       }
                    
         
                if showGeneratButton != 0 {
                    
                    
                Rectangle()
                    .fill(Color.gray.opacity(0.01))
                    .frame(height: 200)
                      
                    Button(action: {
                      
                    }) {
                        Text("Generate Plan")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal,85)
                            .background(Color(red: 0.192, green: 0.259, blue: 0.333))
                            .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity) // Expand the button to full width
                  
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Note"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    }
                    
                }
                

                Spacer()



                }
           
                
                .background(Color.white.ignoresSafeArea())
              //  .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
            
        }
        

        
        func getCitiesForTripType() -> [String] {
             return cityInformation[selectedTripType] ?? []
         }
         
         func updateCitiesInfo() {
             let cities = getCitiesForTripType()
             citiesInfo = cities.map { CityInfo(cityName: $0, numberOfDays: 0) }
         }
         
         func updateCounts() {
             counts = Array(repeating: 0, count: citiesInfo.count)
         }
         
         func tripTypeString(_ index: Int) -> String {
             return ["Religious", "Sports", "Desert"][index] // Add other trip types as needed
         }

//          
//          func resetChoices() {
//              selectedTripType = 0
//              updateCitiesInfo()
//              updateCounts()
//              // Reset other states and choices...
//          }
        
        func generateRandomPlanID() -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<10).map { _ in letters.randomElement()! })
            
            
            return "Plan-\(randomString)"
            
           
        }

        
     
        
  

        func getSelectedDaysForCities() -> [[String: Any]] {
            var selectedDaysList: [[String: Any]] = []
            
            for (index, cityInfo) in citiesInfo.enumerated() {
                if selectedDaysForCities[index] > 0 {
                    // Construct the dictionary with the desired order
                    let cityDaysDict: [String: Any]
                    
                    // Check the city name and days order
                    
                        cityDaysDict = [
                            "city": cityInfo.cityName,
                            "days": selectedDaysForCities[index]
                        ]
                    
                      
                    
                    // Append the constructed dictionary to the list
                    selectedDaysList.append(cityDaysDict)
                }
            }
            
            return selectedDaysList
        }

        func incrementCount(_ index: Int) {
               counts[index] += 1
            selectedDaysForCities[index] += 1
               citiesInfo[index].numberOfDays += 1
           }

           func decrementCount(_ index: Int) {
               if counts[index] > 0 {
                   
                   counts[index] -= 1
                   selectedDaysForCities[index] -= 1
                   citiesInfo[index].numberOfDays -= 1
               }
           }
        
        func ensureCityBeforeDays(_ list: [[String: Any]]) -> [[String: Any]] {
            var correctedList = list

            for (index, dict) in list.enumerated() {
                if let city = dict["city"], let days = dict["days"] {
                    // Check if both 'city' and 'days' values are of expected types
                    if city is String && days is Int {
                        // Ensure 'city' is before 'days' in the dictionary
                        if let cityIndex = dict.index(forKey: "city"), let daysIndex = dict.index(forKey: "days") {
                            if daysIndex < cityIndex {
                                // Swap the positions of city and days if 'city' is after 'days'
                                var modifiedDict = dict
                                modifiedDict["city"] = days
                                modifiedDict["days"] = city
                                correctedList[index] = modifiedDict
                            }
                        }
                    } else {
                        // Handle cases where 'city' or 'days' values are not of the expected type
                        var modifiedDict = dict
                        // Set default values or convert to the correct type
                        if let cityString = city as? String {
                            modifiedDict["city"] = cityString
                        } else {
                            modifiedDict["city"] = ""
                        }
                        if let daysInt = days as? Int {
                            modifiedDict["days"] = daysInt
                        } else {
                            modifiedDict["days"] = 0
                        }
                        correctedList[index] = modifiedDict
                    }
                }
            }
            print("\(correctedList)++++++++++++++")

            return correctedList
        }


       // print("\(correctedList)++++++++++++++")


        // Usage example
     
        
//        func swapCityAndDaysPositions(_ list: [[String: Any]]) -> [[String: Any]] {
//            var correctedList = list
//
//            for (index, dict) in list.enumerated() {
//                // Check if both 'city' and 'days' keys are present
//                if let city = dict["city"], let days = dict["days"] {
//                    // Check if 'city' and 'days' are in different positions, swap them if necessary
//                    if let cityIndex = dict.index(forKey: "city"), let daysIndex = dict.index(forKey: "days"), cityIndex != daysIndex {
//                        var modifiedDict = dict
//                        // Swap positions of 'city' and 'days' keys while keeping their values unchanged
//                        modifiedDict["city"] = days
//                        modifiedDict["days"] = city
//                        correctedList[index] = modifiedDict
//                    }
//                }
//            }
//            print("\(correctedList)00000000")
//            return correctedList
//        }
        
        
        
//        func swapDaysAndCityOrder(_ list: [[String: Any]]) -> [[String: Any]] {
//            var correctedList = list
//
//            for (index, dict) in list.enumerated() {
//                if let _ = dict["city"], let _ = dict["days"], let cityIndex = dict.index(forKey: "city"), let daysIndex = dict.index(forKey: "days"), daysIndex != cityIndex {
//                    // Swap the positions of 'city' and 'days' keys
//                    var modifiedDict = [String: Any]()
//                    dict.forEach { key, value in
//                        if key == "city" {
//                            modifiedDict["days"] = value
//                        } else if key == "days" {
//                            modifiedDict["city"] = value
//                        } else {
//                            modifiedDict[key] = value
//                        }
//                    }
//                    correctedList[index] = modifiedDict
//                }
//            }
//            print("\(correctedList)00000000")
//            return correctedList
//        }
        
        func reverseCityDaysPosition(_ list: [[String: Any]]) -> [[String: Any]] {
            var correctedList = list

            for (index, dict) in list.enumerated() {
                // Check if both 'city' and 'days' keys are present
                if let city = dict["city"] as? Int, let days = dict["days"] as? String {
                    // Create a new dictionary with the reversed positions of 'city' and 'days' keys
                    var modifiedDict = [String: Any]()
                    modifiedDict["days"] = city
                    modifiedDict["city"] = days
                    correctedList[index] = modifiedDict
                }
            }
            print("\(correctedList)00000000")
            return correctedList
        }
         

        
        
        func getSelectedTrip() -> String {
            var selectedTrip: String = Triptype[selectedTripType]
            
            print(selectedTrip + "-------")
              return selectedTrip
          
          }

        
        func nextButtonAction() {
                showCities = false
                selectedHotelRoom = 1
//            print(getSelectedDaysForCities()) //
              
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
        
        
        
        
        

        
        
        
        
            func getMinimumPrice() -> String {
            guard selectedTripType > 0 && selectedTripType < tripPrices.count else { return "" }
            return "$\(tripPrices[selectedTripType])"
        }
       
        
        func isBudgetValid() -> Bool {
            let selectedPrice = getTripPrice(for: selectedTripType)
            let enteredBudget = Double(tripBudget) ?? 0
            
            if let price = selectedPrice as? Int {
                return Double(price) < enteredBudget
            }
            return false
        }

        func validateBudget() {
            chosenTripType = tripTypes[selectedTripType]
            let selectedPrice = getTripPrice(for: selectedTripType)
            let enteredBudget = Double(tripBudget) ?? 0

            if let price = selectedPrice as? Int, Double(price) > enteredBudget {
                errorMessage = "Entered budget is less than the minimum trip price!"
                showAlert = true
                
            } else {
                showPlann = 1
                showResetButton = 1
                showGeneratButton = 0
                selectedHotelRoom = 0
                isBudgetFieldEnabled = false
                isPickerEnabled = false
                showBudgetField = false
    //            generatedPlan = tripPlanner.generatePlan(
    //                budget: enteredBudget,
    //                duration: Int(duration) ?? 0,
    //                tripType: tripTypes[selectedTripType]
    //            )
                withAnimation {
                                       //    selectedTripType = 0
                                       }
                generatePlan = true
            }
        }

        func getTripPrice(for index: Int) -> Any {
            guard index > 0 && index < tripPrices.count else { return 0 }
            return tripPrices[index]
        }
        
        
    }


    struct CustomTextFieldStyle: TextFieldStyle {
        var isFocused: Bool = false
        var isEnabled: Bool = true

        func _body(configuration: TextField<_Label>) -> some View {
            configuration
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isEnabled ? Color.black : Color.gray, lineWidth: 1)
                )
                .foregroundColor(isEnabled ? .black : .gray) // Change text color based on enabled/disabled state
                .disabled(!isEnabled)
        }
    }

    struct PlanData: Decodable {
        struct DayDetails: Decodable {
            let hotel: String
            let place: String
            let restaurant: String
            let totalCost: Int
        }
        
        struct RecommendationPlan: Decodable {
            var day1: DayDetails
            var day2: DayDetails
            var day3: DayDetails
        }
        
        var bestRecommendationsPlans: [RecommendationPlan]
    }



struct Recommendation2: Codable, Hashable {
    let hotel: String
    let Image: String
    let location: String
    let place: String
    let Restaurant: String
    let TotalCost: String
}


    struct FifthScreen_Previews: PreviewProvider {
        static var previews: some View {
            PlanningScreen( userID: "")
        }
    }
