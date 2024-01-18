


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
    var cityName: String
    var numberOfDays: Int
    // Other properties...
}



struct PlanningScreen: View {
    let userID: String
    
    // @State private var counts: [Int] = Array(repeating: 0, count: 8)
    
    
    //   @State private var citiesInfo: [CityInfo] = Array(repeating: CityInfo(cityName: "", numberOfDays: 0), count: 8)
    @State private var citiesInfo: [CityInfo] = [] // Assuming this keeps track of city information
    @State private var counts: [Int] = [] // Counts for each city
    
    let cityInformation: [Int: [String]] = [
        1: ["Cairo", "Alexandria", "Aswan", "Luxor"], // culture_places
        2: ["Cairo", "Alexandria"], // sports_places
        3: ["Fayoum", "Ras Sudr", "Nuweiba"], // desert_places
        4: ["Cairo", "Alexandria", "Siwa", "Fayoum"], // medical_places
   
        5: ["Cairo", "Alexandria", "Luxor","Dahab","El Gouna"], // festival_places
        6: ["Cairo", "Alexandria", "Sharm El Sheikh", "Suez","Marsa Alam"], // conference_places
      
        7: ["Hurghada", "Aswan", "Sharm El Sheikh","Cairo","Dahab"], // pleasure_places
        8: ["Cairo", "Alexandria", "Sinai", "Red Sea", "Sohag"], // religious_places
        
    ]
 
    @State private var tripBudget: String = ""
    @State private var duration: String = ""
    @State  var apiUrl: String = ""
    let tripTypes = ["Select trip type", "Culture", "Sports", "Desert", "Medical", "Festival", "Conference","Pleasure","Religious"]
    
    
    
    
    
    
    @State private var recommendationsPlan12: [Recommendation] = []
    @State private var recommendationsPlan22: [Recommendation] = []
    @State private var recommendationsPlan32: [Recommendation] = []
    
    
    let tripPrices = [0, 3000, 2000, 4500, 6000, 7000, 9000,1000,11111] as [Any]
    @State private var selectedTripType = 0
    @State private var selectedHotelRoom = 0
    @State private var showSecoundNext = 0
    @State private var showGeneratButton = 0
    @State private var showResetButton = 0
    @State private var backButtonPositino = 0
    @State private var showCities = true
    @State private var chosenTripType = ""
    @State private var generatedPlan: TripPlan? = nil
    @State private var religiousCityCounts = Array(repeating: 0, count: 9)
    
    //  private let tripPlanner = TripPlanner()
    
    @FocusState private var isBudgetFieldFocused: Bool
    @FocusState private var isDurationFieldFocused: Bool
    @State private var showAlert = false
    @State private var showAlertFor0Days = false
    @State private var showAlertForPersonNumber = false

    
    
    
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
    @State private var selectedIndex = 0
    @State private var calculatedBudget = 0.0
    @State private var favStatusForPlan1 = false
    @State private var favStatusForPlan2 = false
    @State private var favStatusForPlan3 = false
    private let totalImages = 3
    @State private var showDetailsSheet = false
    @State private var selectPersons = true
    @State private var firstPlanId = ""
    @State private var secondPlanId = ""
    @State private var thirdPlanId = ""
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
    @State private var selectedDaysForCities: [Int] = Array(repeating: 0, count: 8)
    @State private var opacity = 0.5
    @State private var aOffsetY: CGFloat = 1000
    @State private var tOffsetY: CGFloat = -1000
    @State private var guideOpacity = 0.0
    @State private var rotationAngle: Double = 0.0
    @State private var pickerStatus = true
    
    
    func fetchDataBasedOnChoices() {
        if !chosenTripType.isEmpty && convertedBudget > 0 && totalNumberOfDays > 0 {
            // Call the fetchPlansData function here
            //               fetchPlansData(chosenTripType: chosenTripType, convertedBudget: convertedBudget, totalNumberOfDays: totalNumberOfDays)
            
        } else {
            // Handle incomplete data scenario, such as showing an error message to the user
            print("Please select trip type, enter budget, and calculate total number of days.")
        }
    }
    
    func initializeData() {
        let cities = getCitiesForTripType()
        citiesInfo = cities.map { CityInfo(cityName: $0, numberOfDays: 0) }
        updateCounts()
        
    }
    
    func fetchData() {
        guard let url = URL(string: "https://ee69-105-36-31-83.ngrok-free.app/recommendations") else {
            return
        }
        firstPlanId = generateRandomPlanID()
        secondPlanId = generateRandomPlanID()
        thirdPlanId = generateRandomPlanID()
        //  let reversedList =
        print(getSelectedTrip() + "-----------")
        let body: [String: Any] = [
            "place_type":getSelectedTrip(),
            "budget": calculatedBudget,
            "rating":selectedStars,
            "city_day":getSelectedDaysForCities()
        ]
        
        
        print("\(body)-----------000000000")
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
                                print(recommendationsPlan12)
                            } else if let recommendations = plan["best_recommendations_plan_2"] as? [[String: Any]] {
                                for recommendationData in recommendations {
                                    if let recommendation = createRecommendation2(from: recommendationData) {
                                        DispatchQueue.main.async {
                                            self.recommendationsPlan22.append(recommendation)
                                        }
                                    }
                                }
                                print(recommendationsPlan22)
                            } else if let recommendations = plan["best_recommendations_plan_3"] as? [[String: Any]] {
                                for recommendationData in recommendations {
                                    if let recommendation = createRecommendation2(from: recommendationData) {
                                        DispatchQueue.main.async {
                                            self.recommendationsPlan32.append(recommendation)
                                        }
                                    }
                                }
                                print(recommendationsPlan32)
                            }
                        }
                        
                        
}
                   
                }
                
                catch {
                    //  print("JSON serialization error: \(error.localizedDescription)")
                }
            }
        }.resume()
        
    }
    
    func createRecommendation2(from data: [String: Any]) -> Recommendation? {
        
        guard let hotel = data["Hotel"]as? String,
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
        
        
        
        return Recommendation(hotel: hotel, Image: image, location: location, place: place, Restaurant: restaurant, TotalCost: totalCost, Hotel_Image: hotel_Image, Restaurant_Image: restaurant_Image, Hotel_Price: Hotel_Price)
    }
    
    
    @State private var selectNumberOfPersons: Int? = nil
    
    var body: some View {
        
         
        
        VStack{
            
              
            if selectPersons == true {
                VStack {
                    Spacer()
                   
                    Text("Choose Number Of Persons")
                    //                              .font(.title)
                    
                        .foregroundColor(Color(red: 0.192, green: 0.259, blue: 0.333))
                        .font(Font.custom("", size: 28))
                        .padding(.horizontal,19)
                        .padding(.vertical,5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(red: 0.043, green: 0.725, blue: 0.753), lineWidth: 5)
                        )
                        .cornerRadius(15)
                        .padding(.top,20)
                        .padding(.bottom,30)
                  
                    
                    VStack{
                    HStack {
                        VStack {
                            Button(action: {
                                self.selectNumberOfPersons = 1
                            }) {
                                Image(systemName: "person")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: selectNumberOfPersons == 1 ? 120 : 90, height: selectNumberOfPersons == 1 ? 120 : 90)
                                    .opacity(selectNumberOfPersons == 1 ? 1 : 0.5)
                                    .foregroundColor(selectNumberOfPersons == 1 ? Color(red: 0.043, green: 0.725, blue: 0.753) : Color.gray)
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(selectNumberOfPersons == 1 ?  Color(red: 0.722, green: 0.275, blue: 0.114): Color(red: 0.043, green: 0.725, blue: 0.753) ,lineWidth: 5 )
                                //
                            )
                            .cornerRadius(15)
                            
                            Text("One Person")
                                .font(Font.custom("", size: 15))
                            
                                .padding(.vertical,5)
                            
                            //.background()
                            
                        }
                        
                        VStack {
                            Button(action: {
                                self.selectNumberOfPersons = 2
                            }) {
                                Image(systemName: "person.2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: selectNumberOfPersons == 2 ? 120 : 90, height: selectNumberOfPersons == 2 ? 120 : 90)
                                    .opacity(selectNumberOfPersons == 2 ? 1 : 0.5)
                                    .foregroundColor(selectNumberOfPersons == 2 ? Color(red: 0.043, green: 0.725, blue: 0.753) : Color.gray)
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(selectNumberOfPersons == 2 ?  Color(red: 0.722, green: 0.275, blue: 0.114): Color(red: 0.043, green: 0.725, blue: 0.753) ,lineWidth: 5 )                                       )
                            .cornerRadius(15)
                            
                            Text("Two Person")
                                .font(Font.custom("", size: 15))
                            
                                .padding(.vertical,5)
                        }
                        
                    }
                    .padding(20)
                        
                        
                    
                }
                         
                          
                          Button(action: {
                              // selectPersons = false
                              // Handle start button action here
                              if let selectedOption = selectNumberOfPersons {
                                  print("Start button tapped with option \(selectedOption)")
                                  // Add your logic for starting with selected option here
                                  selectPersons = false
                              
                              } else {
                                  print("Please select an option")
                                  // Handle case where no option is selected
                                  showAlertForPersonNumber = true
                              }
                          }) {
                              Text("Continue")
                           
                                  .foregroundColor(.white)
                                  .padding(.horizontal,110)
                                  .padding(.vertical, 8)
                                  .background(Color(red: 0.192, green: 0.259, blue: 0.333))
                                  .cornerRadius(8)
                                  .font(Font.custom("Baskerville-Bold", size: 16)).frame()
                                  .padding(.bottom,210)
                          }
                          .alert(isPresented: $showAlertForPersonNumber) {
                              Alert(title: Text("No Number selected"), message: Text("Please choose Persons number"), dismissButton: .default(Text("OK")))
                          }
                          .padding()
                      }
               
                
                
                
    
            }
             else if selectPersons == false{
                VStack( ){
                    //
                   
                    
                    HStack{
                        
                        if backButtonPositino != 0 {
                            
                    
                            Button(action: {
                                backButtonFunction()
                                
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left")
                                        .resizable()
                                        .frame(width: 15, height: 22)
                                        .padding(.leading,5)
                                    
                                    Text("Back")
                                    
                                }
                                .foregroundColor(Color(red: 0.192, green: 0.259, blue: 0.333)) // Adjust color as needed
                            }
                            .padding(.trailing,-25)
                            .padding(.leading,30)
                            Spacer()
                        }
                        else {
                            
                            Text("  ")
                                .padding(.leading,85)
                        }
                        
                        
                        if pickerStatus == true  {
                            ZStack {
                                //                            let shape = RoundedRectangle(cornerRadius: 20)
                                //
                                //                            if isPickerEnabled {
                                //                                shape.fill().foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                //                            }
                                //                            else {
                                //
                                //                                shape.fill().foregroundColor(Color.gray)
                                //                            }
                                
                                //                    shape.stroke(Color(red: 0, green: 0.243, blue: 0.502), lineWidth: 1)
                                //
                                
                                
                                Picker(selection: $selectedTripType, label: Text("Select trip type").font(Font.custom("", size: 20))) {
                                    ForEach(tripTypes.indices, id: \.self) { index in
                                        Text(self.tripTypes[index])
                                            .font(Font.custom(" ", size: 20))
                                    }
                                }
                                
                                
                                .accentColor(.black)
                                .onChange(of: selectedTripType, initial: false){ initial, _ in
                                    updateCitiesInfo()
                                    updateCounts()
                                }
                                
                                .pickerStyle(InlinePickerStyle())
                                
                                .disabled(!isPickerEnabled)
                                
                                
                                
                            }
                            .frame(width: 200, height: 105)
                            //                        .padding(.top,10)
                            //                        .padding(.bottom, 10)
                            //                        .padding(.horizontal,10)
                        }
                        
                        
                        else{
                            ZStack {
                              Text("                  ")
                         
                            }
                            .frame(width: 200, height: 90)
                            
                        }
                        
                        if showPlann == 1 {
                            Button(action: {
                                          // Rotate the arrow icon anticlockwise
                                         generatAnotherPlan()
                                      }) {
                                         Text("Return To Plan")
                                      }
                                      .padding(.horizontal,20)
                            
                        }
                        else {
                            if pickerStatus == true {
                                AnimatedImage(name: "Copy of Animation - 1705226473630.gif")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width:50,height:50)
                                    .padding(.leading, -50)
                                    .padding(.trailing,80)
                            }
                        }
                    }
                    .padding(.trailing,10)
                    //                .onChange(of: selectedTripType) { newValue in
                    //                            resetChoices() // Reset counts and days selected for cities
                    //                        }
                    //
                    
                    if showBudgetField == true {
                        VStack(spacing: 0) {
                            let totalCoast = (totalNumberOfDays * 200) + (Int(getMinimumPrice()) ?? 0)
                            
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
                                .onAppear(){
                                    // if selectedTripType != 0 {
                                    backButtonPositino = 1
                                    
                                }
                            
                            HStack(){
                                Spacer()
                                
                                
                                let minimumPriceAsString = getMinimumPrice()
                                
                                
                                // Convert String to Int using Int() initializer
                                //                             let minimumPriceAsInt = Int(minimumPriceAsString) {
                                //                                let totalCoast = (totalNumberOfDays * 200) + minimumPriceAsInt
                                //
                                //
                                //                            }
                                
                                
                                
                                
                                Text("Minimum: (\(totalCoast*(selectNumberOfPersons ?? 0)))$")
                                    .font(Font.custom("Cochin-BoldItalic", size: 16))
                                    .padding(.top,0)
                                
                            }
                            .padding(.bottom,30)
                            
                            
                            if showSecoundNext == 1{
                                Button(action: {
                                    
                                    nextButtonActionShowStars()
                                   
                                    
                                })
                                {
                                    Text("Next")
                                        .foregroundColor(.white)
                                        .padding(.horizontal,110)
                                        .padding(.vertical, 8)
                                        .background(Color(red: 0.192, green: 0.259, blue: 0.333))
                                        .cornerRadius(8)
                                        .font(Font.custom("Baskerville-Bold", size: 16))
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.top,30)
                                .background(Color.clear)
                                .alert(isPresented: $showAlert) {
                                    Alert(title: Text("Note"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                                }
                            }
                            
                            
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 15)
                        
                    }
                    
                    
                    if selectedTripType != 0  && showCities == true {
                        
                        VStack{
                            ZStack{
                                let shape = RoundedRectangle(cornerRadius: 9)
                                shape.fill().foregroundColor(.clear)
                                
                                shape.stroke(Color(red: 0, green: 0.243, blue: 0.502), lineWidth: 1)
                                Text("Choose your preferred city:")
                                
                                    .font(Font.custom("", size: 22))
                                    .padding(.bottom,2)
                                
                                //  SnellRoundhand-Bold
                                //
                            }
                    
                            
                            .frame(height: 45)
                            .padding(.top,10)
                            .padding(.bottom, 15)
                            .padding(.horizontal, 30)
                            
                            HStack {
                                
                                Text("City")
                                    .font(Font.custom("DINCondensed-Bold", size: 21))
                                    .padding(.leading,5)
                                Spacer()
                                Text("Days")
                                    .padding(.trailing,25)
                                    .font(Font.custom("DINCondensed-Bold", size: 21))
                                //
                            }
                            //.foregroundColor(.black)
                            .padding(.bottom, 5)
                            .padding(.horizontal,20)
                            .background(Color.clear)
                            
                            
                            List {
                                ForEach(citiesInfo.indices, id: \.self) { index in
                                    let cityInfo = citiesInfo[index]
                                    HStack {
                                        Text(cityInfo.cityName)
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
                                    .listRowBackground(Color.clear)
                                    .contentShape(RoundedRectangle(cornerRadius: 20))
                                }
                            }
                            .listStyle(PlainListStyle())
                            .background(Color.clear)
                            
                            .onAppear {
                                initializeData()
                            }
                            Spacer()
                            VStack{
                                
                                Button(action: {
                                    nextButtonAction()
                                 
                                })
                                {
                                    Text("Next")
                                        .foregroundColor(.white)
                                        .padding(.horizontal,110)
                                        .padding(.vertical, 8)
                                        .background(Color(red: 0.192, green: 0.259, blue: 0.333))
                                        .cornerRadius(8)
                                        .font(Font.custom("Baskerville-Bold", size: 16))
                                }
                                
                                .background(Color.clear)
                                .alert(isPresented: $showAlertFor0Days) {
                                    Alert(title: Text("0 days"), message: Text("Please choose days number for each city"), dismissButton: .default(Text("OK")))
                                }
                                
                                
                                Image("IMG_20240107_123513")
                                    .resizable()
                                    .clipped()
                                    .aspectRatio(contentMode: .fit)
                                    .ignoresSafeArea()
                                    .padding(.top,4)
                                    .frame(height: 160)
                            }
                        }
                    }
                    
                    
                    else if( selectedTripType == 0 && showPlann == 0 && selectedHotelRoom == 0) {
                        // Show an empty frame with a height of 400 when no trip type is selected
                        VStack {
                            Spacer()
                   
                            AnimatedImage(name: "image-processing20220708-21892-unscreen.gif")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                        
                            
                            
                                .clipped()
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
                            // withAnimation {
                            
                            
                            
                            //showGeneratButton = 1
                            //                                let selectedDaysList =
                            //                               // print(selectedDaysList) // This list is in the format you requested
                            //                               // ensureCityBeforeDays(selectedDaysList)
                            //                                let selectedDaysList2 =
                            // getSelectedDaysForCities()
                            
                            backButtonPositino = 3
                            let numberOfPersons = Double(selectNumberOfPersons ?? 0)
                            let enteredBudget = Double(tripBudget) ?? 0
                            //calculatedBudget = Double(Double(tripBudget) ?? 0.0-Double(totalNumberOfDays * 200))
                            calculatedBudget = Double(enteredBudget-Double(totalNumberOfDays * 200))/(numberOfPersons)
                            //                            print("\(calculatedBudget)")
                            //                            print("\(tripBudget)")
                            //                            print("\(Double(totalNumberOfDays * 200))")
                            validateBudget()
                            fetchData()
//                            print("\(recommendationsPlan12)12121212")
//                            print("\(recommendationsPlan22)2222222")
//                            print("\(recommendationsPlan32)323232323232")
                            // }
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
                        
                        .frame(height: 40)
                      
                        .padding(.bottom, 10)
                        .padding(.horizontal, 40)
                        .onAppear{
                            withAnimation {
                                
                            }
                        }
                        
                        
                        
                        
                        
                        ScrollView{
                            
                            
                            
                            NavigationLink( destination: DetailsScreen(TripType: getSelectedTrip() ,  budget:calculatedBudget , selectedDaysList: getSelectedDaysForCities(), PlanNumber: 0, HotelStars: selectedStars, userID:userID ,planId:firstPlanId, Image2: recommendationsPlan12.first?.Image ?? "", selectNumberOfPersons: selectNumberOfPersons ?? 0, favStatus: $favStatusForPlan1)
                                .transition(.move(edge: .leading))
                            ){
                                ZStack(alignment: .center) {
                                    Image("Modern and Minimal Company Profile Presentation (2)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .edgesIgnoringSafeArea(.all)
                                        .opacity(0.8)
                                        .frame(maxWidth: 175)

                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.white, Color(red: 0.043, green: 0.725, blue: 0.753)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 5) // Improved shadow effect

                                    VStack {
                                        HStack {
                                          
                                            Text("Plan 1")
                                                .font(Font.custom("Cochin-Bold", size: 20))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .padding(.top, 5)
                                                .fontWeight(.bold)
                                                .padding(.leading, 30)
                                            Spacer()
                                        }

                                        Spacer()

                                        VStack {
                                            TabView(selection: $selectedIndex) {
                                                ForEach(0..<totalImages, id: \.self) { index in
                                                    getImage2(forIndex: index, fromRecommendationsPlan: recommendationsPlan12)
                                                        .tag(index)
                                                }
                                            }
                                            .tabViewStyle(PageTabViewStyle())
                                            .frame(width: 250, height: 150)
                                            .background(Color.white)
                                            .cornerRadius(20)
                                            .onAppear {
                                                startTimer2()
                                            }
                                            .onChange(of: selectedIndex, initial: false) {
                                                startTimer2()
                                            }
                                        }
                                        .frame(minWidth: 185, minHeight: 60)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 0)

                                        Spacer()
                                        
                                        if let firstLocation = recommendationsPlan12.last?.location {
                                            Text(firstLocation)
                                                .font(Font.custom("Charter-Black", size: 20))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .padding(.top, 5)
                                                .fontWeight(.bold)
                                            
                                              //  .padding(.leading, 10)

                                        
                                           
                                        }
                                        HStack {
                                            if let firstPlace = recommendationsPlan12.last?.place {
                                                Text(firstPlace)
                                                    .font(Font.custom("Charter-Black", size: 20))
                                                    .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                    .padding(.bottom, 5)
                                                    .lineLimit(1)
                                            }
                                        }
                                    }
                                }
                                .frame(minHeight: 175)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.043, green: 0.725, blue: 0.753), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                )
                                .cornerRadius(12)
                                .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
                                .padding(.horizontal, 40)

                                
                            }
                            .padding(.bottom, 5)
                            
                            
                            NavigationLink( destination: DetailsScreen(TripType: Triptype[selectedTripType], budget: calculatedBudget, selectedDaysList: getSelectedDaysForCities(), PlanNumber: 1, HotelStars: selectedStars, userID:userID ,planId:secondPlanId, Image2: recommendationsPlan22.first?.Image ?? "",  selectNumberOfPersons: selectNumberOfPersons ?? 0, favStatus: $favStatusForPlan2)) {
                                ZStack(alignment: .center) {
                                    Image("Modern and Minimal Company Profile Presentation (2)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .edgesIgnoringSafeArea(.all)
                                        .opacity(0.8)
                                        .frame(maxWidth: 175)

                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.white, Color(red: 0.043, green: 0.725, blue: 0.753)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 5) // Improved shadow effect

                                    VStack {
                                        HStack {
                                          
                                            Text("Plan 2")
                                                .font(Font.custom("Cochin-Bold", size: 20))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .padding(.top, 5)
                                                .fontWeight(.bold)
                                                .padding(.leading, 30)
                                            Spacer()
                                        }

                                        Spacer()

                                        VStack {
                                            TabView(selection: $selectedIndex) {
                                                ForEach(0..<totalImages, id: \.self) { index in
                                                    getImage2(forIndex: index, fromRecommendationsPlan: recommendationsPlan22)
                                                        .tag(index)
                                                }
                                            }
                                            .tabViewStyle(PageTabViewStyle())
                                            .frame(width: 250, height: 150)
                                            .background(Color.white)
                                            .cornerRadius(20)
                                            .onAppear {
                                                startTimer2()
                                            }
                                            .onChange(of: selectedIndex, initial: false) {
                                                startTimer2()
                                            }
                                        }
                                        .frame(minWidth: 185, minHeight: 60)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 0)

                                        Spacer()
                                        
                                        if let firstLocation = recommendationsPlan22.last?.location {
                                            Text(firstLocation)
                                                .font(Font.custom("Charter-BlackItalic", size: 20))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .padding(.top, 5)
                                                .fontWeight(.bold)
                                              //  .padding(.leading, 10)

                                        
                                           
                                        }
                                        HStack {
                                            if let firstPlace = recommendationsPlan22.last?.place {
                                                Text(firstPlace)
                                                    .font(Font.custom("Charter-BlackItalic", size: 20))
                                                    .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                    .padding(.bottom, 5)
                                            }
                                        }
                                    }
                                }
                                .frame(minHeight: 175)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.043, green: 0.725, blue: 0.753), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                )
                                .cornerRadius(12)
                                .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
                                .padding(.horizontal, 40)
                                
                            }
                            .padding(.bottom, 5)
                            
                            NavigationLink( destination: DetailsScreen(TripType: Triptype[selectedTripType], budget:calculatedBudget, selectedDaysList: getSelectedDaysForCities(), PlanNumber: 2, HotelStars: selectedStars, userID:userID ,planId:thirdPlanId, Image2: recommendationsPlan32.first?.Image ?? "" ,selectNumberOfPersons: selectNumberOfPersons ?? 0, favStatus: $favStatusForPlan3)) {
                                ZStack(alignment: .center) {
                                    Image("Modern and Minimal Company Profile Presentation (2)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .edgesIgnoringSafeArea(.all)
                                        .opacity(0.8)
                                        .frame(maxWidth: 175)

                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.white, Color(red: 0.043, green: 0.725, blue: 0.753)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 5) // Improved shadow effect

                                    VStack {
                                        HStack {
                                          
                                            Text("Plan 3")
                                                .font(Font.custom("Cochin-Bold", size: 20))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .padding(.top, 5)
                                                .fontWeight(.bold)
                                                .padding(.leading, 30)
                                            Spacer()
                                        }

                                        Spacer()

                                        VStack {
                                            TabView(selection: $selectedIndex) {
                                                ForEach(0..<totalImages, id: \.self) { index in
                                                    getImage2(forIndex: index, fromRecommendationsPlan: recommendationsPlan32)
                                                        .tag(index)
                                                }
                                            }
                                            .tabViewStyle(PageTabViewStyle())
                                            .frame(width: 250, height: 150)
                                            .background(Color.white)
                                            .cornerRadius(20)
                                            .onAppear {
                                                startTimer2()
                                            }
                                            .onChange(of: selectedIndex, initial: false) {
                                                startTimer2()
                                            }
                                        }
                                        .frame(minWidth: 185, minHeight: 60)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 0)

                                        Spacer()
                                        
                                        if let firstLocation = recommendationsPlan32.last?.location {
                                            Text(firstLocation)
                                                .font(Font.custom("Charter-BlackItalic", size: 20))
                                                .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                .padding(.top, 5)
                                                .fontWeight(.bold)
                                              //  .padding(.leading, 10)

                                        
                                           
                                        }
                                        HStack {
                                            if let firstPlace = recommendationsPlan32.last?.place {
                                                Text(firstPlace)
                                                    .font(Font.custom("Charter-BlackItalic", size: 20))
                                                    .foregroundColor(Color(UIColor(hex: 0x313F54)))
                                                    .padding(.bottom, 5)
                                            }
                                        }
                                    }
                                }
                                .frame(minHeight: 175)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.043, green: 0.725, blue: 0.753), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                )
                                .cornerRadius(12)
                                .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
                                .padding(.horizontal, 40)
                                
                            }
                            .padding(.bottom, 5)
                        }
                        
                        .padding(.bottom, 5)
                    }
                    
                    
                    //                if showGeneratButton != 0 {
                    //
                    //
                    //                    Rectangle()
                    //                        .fill(Color.gray.opacity(0.01))
                    //                        .frame(height: 200)
                    //
                    //                    Button(action: {
                    //
                    //                    }) {
                    //                        Text("Generate Plan")
                    //                            .foregroundColor(.white)
                    //                            .padding()
                    //                            .padding(.horizontal,85)
                    //                            .background(Color(red: 0.192, green: 0.259, blue: 0.333))
                    //                            .cornerRadius(8)
                    //                    }
                    //                    .frame(maxWidth: .infinity) // Expand the button to full width
                    //
                    //                    .alert(isPresented: $showAlert) {
                    //                        Alert(title: Text("Note"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    //                    }
                    //
                    //                }
                    
                    
                    Spacer()
                    
                    
                    
                }
            
                
            }
            
        }
        .background(Image("IMG_20240104_181119 (2)").resizable().scaledToFill().clipped().edgesIgnoringSafeArea([.all]).opacity(0.6))
//            .sheet(isPresented: $showDetailsSheet) {
//                DetailsScreen(TripType: getSelectedTrip() ,  budget:calculatedBudget , selectedDaysList: getSelectedDaysForCities(), PlanNumber: 0, HotelStars: selectedStars, userID:userID ,planId:generateRandomPlanID(), favStatus: favStatus )
//                   
//                    .presentationDetents([.medium, .large])
//                    }
          
            //  .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
        
            
        }
        
        
        func getImage2(forIndex index: Int, fromRecommendationsPlan planNumber: [Recommendation]) -> some View {
            // Use the 'planNumber' parameter to fetch the specific 'recommendationsPlan' item
            let planItem = planNumber
        
            switch index {
            case 0:
                return AnyView(
                
                    
                    AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: planItem.first?.Image ?? "") ?? ""))
                          {
                        phase in
                                 switch phase {
                                 case.empty:
                                
                                     Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
                                                                              .resizable()
                                                                              .aspectRatio(contentMode: .fit)
                                                                              .frame(width: 250, height: 150)
                                                                              .cornerRadius(10)
                                                                              .redacted(reason: .placeholder)
                                 case.success(let image):
                                     image
                                         .resizable()
                                         .aspectRatio(contentMode: .fill)
                                         .frame(width: 250, height: 200)
                                         .cornerRadius(20)
                                 case.failure:
                                     Image("Screenshot 2024-01-02 at 4.16.52 PM (1)")
                                         .resizable()
                                         .aspectRatio(contentMode: .fit)
                                         .frame(width: 250, height: 200)
                                         .cornerRadius(20)
    //                                 @unknown default:
    //                                     EmptyView()
                                 @unknown default:
                                     fatalError()
                                 }
                      
                             }
                        .cornerRadius(20)
                        .frame(width: 250, height: 150)
                        .cornerRadius(10)
                )
            case 1:
                return AnyView(
                    AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: planItem.last?.Image ?? "") ?? ""))
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
                                         .aspectRatio(contentMode: .fill)
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
                    AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink:planItem.last?.Image ?? "") ?? ""))
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
                                         .aspectRatio(contentMode: .fill)
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
      
        
        
//        func getImage2(forIndex index: Int) -> some View {
//            if let firstImage = recommendationsPlan22.last?.Image {
//                let asyncImage = AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: firstImage) ?? "")) { phase in
//                    switch phase {
//                    case .empty:
//                        switch index {
//                        case 0:
//                            return AnyView(
//                                Image("museum2")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 210, height: 150)
//                                    .cornerRadius(20)
//                                    .padding(.horizontal, 10)
//                            )
//                        case 1:
//                            return AnyView(
//                                AnimatedImage(name: "a-hero-image")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 230, height: 150)
//                                    .cornerRadius(20)
//                                    .padding(.horizontal, 10)
//                            )
//                        case 2:
//                            return AnyView(
//                                Image("restaurant")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 210, height: 150)
//                                    .cornerRadius(20)
//                                    .padding(.horizontal, 10)
//                            )
//                        default:
//                            return AnyView(EmptyView())
//                        }
//                            case.success:
//                        VStack {
//                            if let firstImage = recommendationsPlan32.first?.Image {
//                                AsyncImage(url: URL(string: convertGoogleDriveLinkToDirectImageURL(googleDriveLink: firstImage) ?? "")) { phase in
//                                    switch phase {
//                                    case .empty:
//                                        ProgressView()
//                                    case .success(let image):
//                                        image
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fill) // Maintain the aspect ratio by filling the frame
//                                            .frame(maxWidth: 185, maxHeight: 110) // Set the fixed size of the image
//                                    case .failure:
//                                        Image("1024 1")
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit) // Maintain the aspect ratio by filling the frame
//                                            .frame(maxWidth: 185, maxHeight: 110)
//                                    @unknown default:
//                                        fatalError()
//                                    }
//                                }
//                                .cornerRadius(20)
//                            }
//                            //
//                        }
//                        .frame(minWidth: 185, minHeight: 120)
//                        .background(Color.white) // Add a white background for the image container
//                        .cornerRadius(10) // Round corners of the image container
//                        
//                    case .failure:
//                        switch index {
//                        case 0:
//                            return AnyView(
//                                Image("museum2")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 210, height: 150)
//                                    .cornerRadius(20)
//                                    .padding(.horizontal, 10)
//                            )
//                        case 1:
//                            return AnyView(
//                                AnimatedImage(name: "a-hero-image")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 210, height: 150)
//                                    .cornerRadius(20)
//                                    .padding(.horizontal, 10)
//                            )
//                        case 2:
//                            return AnyView(
//                                Image("restaurant")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 210, height: 150)
//                                    .cornerRadius(20)
//                                    .padding(.horizontal, 10)
//                            )
//                        default:
//                            return AnyView(EmptyView())
//                        }
//                    @unknown default:
//                        switch index {
//                        case 0:
//                            return AnyView(
//                                Image("museum2")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 210, height: 150)
//                                    .cornerRadius(20)
//                                    .padding(.horizontal, 10)
//                            )
//                        case 1:
//                            return AnyView(
//                                AnimatedImage(name: "a-hero-image")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 210, height: 150)
//                                    .cornerRadius(20)
//                                    .padding(.horizontal, 10)
//                            )
//                        case 2:
//                            return AnyView(
//                                Image("restaurant")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 210, height: 150)
//                                    .cornerRadius(20)
//                                    .padding(.horizontal, 10)
//                            )
//                        default:
//                            return AnyView(EmptyView())
//                        }
//                    }
//                    return AnyView(asyncImage)
//                } return AnyView(asyncImage)
//            }
//            return AnyView(EmptyView())
//        }

        
        func startTimer2() {
               Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                   let nextIndex = (selectedIndex + 1) % totalImages
                   selectedIndex = nextIndex
               }
           }
        
        
        
//        func getCitiesForTripType() -> [String] {
//             return cityInformation[selectedTripType] ?? []
//         }
//         
         func updateCitiesInfo() {
             let cities = getCitiesForTripType()
             citiesInfo = cities.map { CityInfo(cityName: $0, numberOfDays: 0) }
         }
         
        func getCitiesForTripType() -> [String] {
            return cityInformation[selectedTripType] ?? []
        }

        func updateCounts() {
            counts = Array(repeating: 0, count: citiesInfo.count)
        }
//         func tripTypeString(_ index: Int) -> String {
//             return ["Religious", "Sports", "Desert"][index] // Add other trip types as needed
//         }

//          
//          func resetChoices() {
//              selectedTripType = 0
//              updateCitiesInfo()
//              updateCounts()
//              // Reset other states and choices...
//          }
        
//    func generateThreeRandomPlanIDs() -> [String] {
//        return (0..<3).map { _ in generateRandomPlanID() }
//    }

    func generateRandomPlanID() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<10).map { _ in letters.randomElement()! })

        return "Plan-\(randomString)"
    }


//    func generateThreeRandomPlanIDs() -> (String, String, String) {
//        let id1 = generateRandomPlanID()
//        let id2 = generateRandomPlanID()
//        let id3 = generateRandomPlanID()
//        
//        return (id1, id2, id3)
//    }

    // Example usage:
  //
        
  

        func getSelectedDaysForCities() -> [[String: Any]] {
            var selectedDaysList: [[String: Any]] = []
            
            for (index, cityInfo) in citiesInfo.enumerated() {
                if selectedDaysForCities[index] > 0 {
//                    var cityDaysDict: [String: Any] = [:]
//                    
//                    // Set the keys in a specific order to ensure consistency
//                    cityDaysDict["city"] = cityInfo.cityName
//                    cityDaysDict["days"] = selectedDaysForCities[index]
                  
                    
                    selectedDaysList.append(["city":cityInfo.cityName, "days":cityInfo.numberOfDays])
                }
            }
            print(selectedDaysList)
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
        
        
//        func incrementCount(_ index: Int) {
//            guard index >= 0 && index < counts.count else {
//                return // Avoid index out of range
//            }
//            counts[index] += 1
//        }
//
//        // Decrement count for a specific index
//        func decrementCount(_ index: Int) {
//            guard index >= 0 && index < counts.count else {
//                return // Avoid index out of range
//            }
//            if counts[index] > 0 {
//                counts[index] -= 1
//            }
//        }

//        func ensureCityBeforeDays(_ list: [[String: Any]]) -> [[String: Any]] {
//            var correctedList = list
//
//            for (index, dict) in list.enumerated() {
//                if let city = dict["city"] as? String, let days = dict["days"] as? Int {
//                    if dict.keys.sorted() != ["city", "days"] {
//                        var modifiedDict = [String: Any]()
//                        modifiedDict["city"] = city
//                        modifiedDict["days"] = days
//                        correctedList[index] = modifiedDict
//                    }
//                }
//            }
//            print("\(correctedList) 0000")
//            return correctedList
//        }
//
//        func reverseCityDaysPosition(_ list: [[String: Any]]) -> [[String: Any]] {
//            var correctedList = list
//
//            for (index, dict) in list.enumerated() {
//                if let days = dict["days"] as? Int, let city = dict["city"] as? String {
//                    if dict.keys.sorted() != ["city", "days"] {
//                        var modifiedDict = [String: Any]()
//                        modifiedDict["days"] = days
//                        modifiedDict["city"] = city
//                        correctedList[index] = modifiedDict
//                    }
//                }
//            }
//            print("\(correctedList) + 111")
//            return correctedList
//        }
//

       // print("\(correctedList)++++++++++++++")


        // Usage example
     
        

        
        

  
        
        
        func getSelectedTrip() -> String {
            let selectedTrip: String = Triptype[selectedTripType]
            
            print(selectedTrip + "-------")
              return selectedTrip
          
          }

        
        func nextButtonAction() {
        
                
            if totalNumberOfDays == 0 {
                showAlertFor0Days = true
            } else {
                
                showCities = false
               showSecoundNext = 1
                showBudgetField = true
                isBudgetFieldEnabled = true
                pickerStatus = false
            }
//            print(getSelectedDaysForCities()) //
              
        }

        
        func nextButtonActionShowStars() {
        
                
            _ = getTripPrice(for: selectedTripType)
            let enteredBudget = Double(tripBudget) ?? 0
            let totalCoast = Double(totalNumberOfDays * 200) + (Double(getMinimumPrice()) ?? 0)
            let numberOfPerson = Double(selectNumberOfPersons ?? 0)
            if  totalCoast*numberOfPerson > enteredBudget {
                errorMessage = "Entered budget is less than the minimum trip price!"
                showAlert = true
                
                
              
            } else {
                showSecoundNext = 0
                
//                showCities = false
                backButtonPositino = 2
                selectedHotelRoom = 1
                isBudgetFieldEnabled = false
//                isPickerEnabled = false
//                showBudgetField = true
//                isBudgetFieldEnabled = true
            }
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
            return "\(tripPrices[selectedTripType])"
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
//            chosenTripType = tripTypes[selectedTripType]
//            let selectedPrice = getTripPrice(for: selectedTripType)
//            let enteredBudget = Double(tripBudget) ?? 0
//            let totalCoast = Double(totalNumberOfDays * 200) + (Double(getMinimumPrice()) ?? 0)
//            
//            if  totalCoast > enteredBudget {
//                errorMessage = "Entered budget is less than the minimum trip price!"
//                showAlert = true
//                
//            } else {
                showPlann = 1
                showResetButton = 1
                showGeneratButton = 0
                selectedHotelRoom = 0
                isBudgetFieldEnabled = false
                isPickerEnabled = false
                showBudgetField = false
           
            generatePlan = true
            
            
            
            
           
    //            generatedPlan = tripPlanner.generatePlan(
    //                budget: enteredBudget,
    //                duration: Int(duration) ?? 0,
    //                tripType: tripTypes[selectedTripType]
    //            )
                withAnimation {
                                       //    selectedTripType = 0
                                       }
               
            // }
        }
    
    
    func generatAnotherPlan() {
        selectPersons = true
            showSecoundNext = 0
            showBudgetField = false
        pickerStatus = true
            showCities = true
            initializeData()
            let cities = getCitiesForTripType()
            citiesInfo = cities.map { CityInfo(cityName: $0, numberOfDays: 0) }
            updateCounts()
           selectedDaysForCities = Array(repeating: 0, count: 8)
          citiesInfo  = [] // Assuming this keeps track of city information
         counts = [] // Counts for each city
            backButtonPositino = 0
            
        
            
         
           
            isBudgetFieldEnabled = false

           
            showPlann = 0
          
            showGeneratButton = 0
            selectedHotelRoom = 0
            // isBudgetFieldEnabled = true
            isPickerEnabled = true
            //
        
        generatePlan = false
        
    }
        
        func backButtonFunction() {
            if backButtonPositino == 1 {
                showSecoundNext = 0
                showBudgetField = false
                
                showCities = true
                initializeData()
                let cities = getCitiesForTripType()
                citiesInfo = cities.map { CityInfo(cityName: $0, numberOfDays: 0) }
                updateCounts()
               selectedDaysForCities = Array(repeating: 0, count: 8)
              citiesInfo  = [] // Assuming this keeps track of city information
             counts = [] // Counts for each city
                backButtonPositino = 0
                isPickerEnabled = true
                pickerStatus = true
            } else if backButtonPositino == 2 {
                
                backButtonPositino = 1
                selectedHotelRoom = 0
                showSecoundNext = 1
                showBudgetField = true
                isBudgetFieldEnabled = true
//                initializeData()
//                let cities = getCitiesForTripType()
//                citiesInfo = cities.map { CityInfo(cityName: $0, numberOfDays: 0) }
//                updateCounts()
//               selectedDaysForCities = Array(repeating: 0, count: 8)
//              citiesInfo  = [] // Assuming this keeps track of city information
//             counts = [] // Counts for each city
             // Assuming this keeps track of city information
             //   counts = [] // Counts for each city
            }
            else if backButtonPositino == 3 {
                backButtonPositino = 2
                showPlann = 0
                showResetButton = 0
                showGeneratButton = 0
                selectedHotelRoom = 1
                // isBudgetFieldEnabled = true
                isPickerEnabled = false
                //
                recommendationsPlan12.removeAll()
                recommendationsPlan22.removeAll()
                recommendationsPlan32.removeAll()
            generatePlan = false
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
    let Hotel_Image: String
    let Restaurant_Image: String
                    
}


    struct FifthScreen_Previews: PreviewProvider {
        static var previews: some View {
            PlanningScreen( userID: "")
        }
    }
