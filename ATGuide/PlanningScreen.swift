import SwiftUI

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


struct CityInfo {
    let cityName: String
    var numberOfDays: Int
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


struct PlanningScreen: View {
    @State private var counts: [Int] = Array(repeating: 0, count: 6)
    @State private var citiesInfo: [CityInfo] = [
          CityInfo(cityName: "Cairo", numberOfDays: 0),
          CityInfo(cityName: "Siwa", numberOfDays: 0),
          CityInfo(cityName: "Aswan", numberOfDays: 0),
          CityInfo(cityName: "Luxor", numberOfDays: 0),
          CityInfo(cityName: "Giza", numberOfDays: 0),
          CityInfo(cityName: "Assiut", numberOfDays: 0)
      ]
    @State private var tripBudget: String = ""
    @State private var duration: String = ""
    @State  var apiUrl: String = ""
    let tripTypes = ["Select trip type", "Religious", "Sports", "Desert", "Medical", "Festivals", "Education"]
    let Religious = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
    let Sports = ["a", "Siwa", "b", "Luxor", "h", "Assiut"]
    let Desert = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
    let Medical = ["8787", "dddd", "jh", "jjhj", "Giza", "Assiut"]
    let Festivals = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
    let Education = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
    
    
    
    let Cairo = ["A1", "A2", "A3", "A4", "A5", "A6"]
    let Siwa = ["B1", "B2", "B3", "B4", "B5", "B6"]
    let Aswan = ["c1", "c2", "c3", "c4", "c5", "c6"]
    let Lucor = ["D1", "d2", "d3", "d4", "d5", "d6"]
    let Giza = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
    let Assiut = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
    
    
      
    let tripPrices = [0, 3000, 2000, 4500, 6000, 7000, 9000] as [Any]
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

     // @State private var religiousCityCount = Array(repeating: 0, count: 7)
   

       @State private var selectedStars = 1
    @State private var showPlannPlans: [TripPlan] = []
//    @State private var currencies: [Currency] = []
 @State private var isShowingFavouriteScreen = false
//
//
//    func fetchData() {
//        let headers = [
//            "X-RapidAPI-Key": "fd2ecd8edfmsh2d4087af4cccd54p1cb248jsnd0edafdaa13b",
//            "X-RapidAPI-Host": "tourist-attraction.p.rapidapi.com"
//        ]
//
//        guard let url = URL(string: "https://tourist-attraction.p.rapidapi.com/currencies") else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error)")
//            } else if let data = data {
//                do {
//                    let decodedData = try JSONDecoder().decode(CurrenciesResponse.self, from: data)
//                    
//                    DispatchQueue.main.async {
//                        self.currencies = decodedData.results
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
//            }
//        }
//        dataTask.resume()
//    }
//    
    func fetchDataBasedOnChoices() {
           if !chosenTripType.isEmpty && convertedBudget > 0 && totalNumberOfDays > 0 {
               // Call the fetchPlansData function here
               fetchPlansData(chosenTripType: chosenTripType, convertedBudget: convertedBudget, totalNumberOfDays: totalNumberOfDays)
           } else {
               // Handle incomplete data scenario, such as showing an error message to the user
               print("Please select trip type, enter budget, and calculate total number of days.")
           }
       }
    
    
    func fetchPlansData(chosenTripType: String, convertedBudget: Int, totalNumberOfDays: Int) {
           let urlString = "https://8422-197-54-130-239.ngrok-free.app/recommendations/\(chosenTripType)/\(convertedBudget)/\(totalNumberOfDays)"
           
           if let url = URL(string: urlString) {
               let task = URLSession.shared.dataTask(with: url) { data, response, error in
                   guard let data = data, error == nil else {
                       print("Error: \(error?.localizedDescription ?? "Unknown error")")
                       return
                   }
                   
                   do {
                       let decodedData = try JSONDecoder().decode(PlanData.self, from: data)
                       let fetchedPlans = decodedData.bestRecommendationsPlans
                       
                       DispatchQueue.main.async {
                           if fetchedPlans.count >= 3 {
                               self.showPlannPlans = [
                                   TripPlan(destination: fetchedPlans[0].day1.place, activities: [:], totalCost: Double(fetchedPlans[0].day1.totalCost)),
                                   TripPlan(destination: fetchedPlans[1].day2.place, activities: [:], totalCost: Double(fetchedPlans[1].day2.totalCost)),
                                   TripPlan(destination: fetchedPlans[2].day3.place, activities: [:], totalCost: Double(fetchedPlans[2].day3.totalCost))
                               ]
                               // Once plans are fetched, display them by setting showPlann = 1
                               self.showPlann = 1
                           }
                       }
                   } catch {
                       print("Error decoding JSON: \(error.localizedDescription)")
                   }
               }
               task.resume()
           }
       }
    
    var body: some View {
        
        
      
        VStack( ){
//                Text("Planning Section")
//                    .font(.title)
//                    .padding(.bottom, 40)
            
                
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 20)
                shape.fill().foregroundColor(Color.gray.opacity(0.01))
                shape.stroke(Color.gray, lineWidth: 1)
//                    .overlay(ArrowShape()
//                        .frame(width: 11, height: 11)
//                        .foregroundColor(.gray)
//                        .rotationEffect(isMenuOpen ? .degrees(180) : .degrees(0))
//                        .offset(  x: -95, y: 2)
//                             
//                    )
                
                
                    Picker(selection: $selectedTripType, label: Text("Select trip type")) {
                        ForEach(tripTypes.indices, id: \.self) { index in
                            Text(self.tripTypes[index])
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                   
          

            }
            .frame(height: 35)
            .padding(.top,0)
            .padding(.bottom, 10)
            .padding(.horizontal, 110)

            
            TextField("Enter trip budget (Minimum: \(getMinimumPrice()))", text: $tripBudget)
                .textFieldStyle(CustomTextFieldStyle(isFocused: isBudgetFieldFocused, isEnabled: selectedTripType != 0))
                .padding(.horizontal, 40)
                .disabled(selectedTripType == 0)
                .padding(.bottom, 15)
                
                
            
            
            
                if selectedTripType != 0  && showCities == true {
                  
                    Text("Choose your preferred city:")
                        .font(.headline)
                        .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
                        .padding(.horizontal, 40)
                        .padding(.bottom, 10)
                            
           
                        HStack {
                            Text("City")
                            Spacer()
                            Text("Days     ")
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
                                                   .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                           }
                                           .buttonStyle(BorderlessButtonStyle())

                                           Text("\(self.counts[index])")
                                               .padding(.horizontal, 10)

                                           Button(action: {
                                               self.decrementCount(index)
                                           }) {
                                               Image(systemName: "minus.circle")
                                                   .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
                                           }
                                           .buttonStyle(BorderlessButtonStyle())
                                       }
                                       .contentShape(Rectangle())
                                   }
                               }
                    .foregroundColor(Color(red: 0, green: 0.243, blue: 0.502))
//                    NavigationLink(destination: NextView(citiesInfo: citiesInfo), isActive: $navigateToNextView) {
//                                  EmptyView()
//                              }
//                              .hidden()

                               Button(action: {
                                   nextButtonAction()
                               }) {
                                   Text("Next")
                                       .foregroundColor(.white)
                                       .padding(.horizontal, 8)
                                       .padding(.vertical, 5)
                                       .background(Color(red: 0.043, green: 0.725, blue: 0.753))
                                       .cornerRadius(8)
                               }
                               .frame(maxWidth: .infinity, alignment: .trailing)
                               .padding(.trailing, 30)
                               .padding(.bottom, 90)
                           }
            
            else if( selectedTripType == 0 && showPlann == 0 && selectedHotelRoom == 0) {
                    // Show an empty frame with a height of 400 when no trip type is selected
                    VStack {
                        Spacer()
                        Rectangle()
                            .fill(Color.gray.opacity(0.01))
                            .frame(height: 400)
                        Spacer()
                    }
                }
                
            if selectedHotelRoom != 0 {
              
                Rectangle()
                    .fill(Color.gray.opacity(0.01))
                    .frame(height: 100)
       
                Text("Select Number Of Stars For your Hotel")
                    .font(.headline)
                    
                   
                Rectangle()
                    .fill(Color.gray.opacity(0.01))
                    .frame(height: 50)
                    
                        HStack {
                            ForEach(1..<6) { star in
                                Image(systemName: selectedStars >= star ? "star.fill" : "star")
                                    .foregroundColor(selectedStars >= star ? .yellow : .gray)
                                    .onTapGesture {
                                        selectedStars = star
                                    }
                            }
                        }
                        .font(.system(size: 24))
                    
                Rectangle()
                    .fill(Color.gray.opacity(0.01))
                    .frame(height: 50)
                    
             
                
                    Button(action: {
                        withAnimation {
                            selectedHotelRoom = 0
                           
                            showGeneratButton = 1
                        }
                    }) {
                        Text("Done")
                        
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .background(Color(red: 0.043, green: 0.725, blue: 0.753))
                            .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 20)
                    .padding(.bottom, 0) // Adjusted bottom padding
                
                
                Rectangle()
                    .fill(Color.gray.opacity(0.01))
                    .frame(height: 50)
            }
                
            if showPlann == 1 {
                       ForEach(showPlannPlans.indices, id: \.self) { index in
                           NavigationLink( destination: DetailsScreen()) {
                               VStack {
                                   Text("Destination: \(showPlannPlans[index].destination)")
                                   Text("Total Cost: \(showPlannPlans[index].totalCost)")
                                   // Add other relevant plan details here...
                               }
                               .padding()
                               .background(Color.white)
                               .cornerRadius(10)
                               .shadow(radius: 3)
                               .padding()
                               
                               
                               
                           }
                       }
                NavigationLink( destination: DetailsScreen()) {
                    ZStack(alignment: .center) {
                        let shape = RoundedRectangle(cornerRadius: 20)
                        shape.fill().foregroundColor(Color.gray.opacity(0.01))
                        
                        
                        VStack {
                            HStack {
                                Text("Your Headline Text")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.top, 10)
                                    .padding(.leading, 10) // Align to the left
                                Spacer() // Pushes text to the left
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
                            
                            HStack {
                                Spacer() // Pushes text to the right
                                Text("#1") // Replace with your card number
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.trailing, 20)
                            }
                        }
                        .padding(10) // Add padding for the whole content
                        
                    }
                    .frame(height: 160) // Adjust the height as needed
                    .padding(.vertical, 10)
                    
                    .background(Color.white) // Add a white background to the entire card
                    .cornerRadius(20) // Round corners of the card
                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 4) // Add a shadow effect
                    .padding(.horizontal, 40)
                }
                   }
                
     
            if showGeneratButton != 0 {
                
                
            Rectangle()
                .fill(Color.gray.opacity(0.01))
                .frame(height: 300)
                
                
                Button(action: {
                    if selectedTripType != 0{
                        
                        validateBudget()
                      
                        
                    } else{
                        showAlert = true
                        errorMessage = "Please select Trip type"
                    }
                    
                }) {
                    Text("Generate Plan")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                .padding(.bottom, 10)
                
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Note"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
                
            }
            
            if showResetButton != 0 {
                
                Button(action: {
                    // Reset choices action
                    showResetButton = 0
                    resetChoices()
                }) {
                    Text("Reset Choices")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding(.bottom, 10)
            }
            
            
            Spacer()


//                           NavigationLink(destination: FavoriteScreen(), isActive: $isShowingFavouriteScreen) {
//                               EmptyView()
//                           }
//                           .hidden()
//
//                           Button(action: {
//                               isShowingFavouriteScreen = true
//                           }) {
//                               Image(systemName: "heart.fill")
//                                   .foregroundColor(.red)
//                                   .padding()
//                                   .background(Color.white)
//                                   .clipShape(Circle())
//                                   .shadow(radius: 4)
//                           }
//                           .padding()
            
            }
       
            
            .background(Color.gray.opacity(0.1).ignoresSafeArea())
          //  .foregroundColor(Color(red: 0.043, green: 0.725, blue: 0.753))
        
    }
    
    func resetChoices() {
           // Reset all choices and states here
           // Reset selectedTripType, counts, citiesInfo, selectedHotelRoom, etc.
         showCities = true
           selectedTripType = 0
           counts = Array(repeating: 0, count: 6)
           citiesInfo = [
               CityInfo(cityName: "Cairo", numberOfDays: 0),
               // Rest of the cities...
           ]
           showPlann = 0
           selectedHotelRoom = 0
           showGeneratButton = 0
           generatedPlan = nil
           generatePlan = false // Reset the flag to hide generated plan content
        
       }
    
    
    func nextButtonAction() {
     
        showCities = false
        selectedHotelRoom = 1
     }

    
    
    func getCitiesForTripType() -> [String] {
        switch selectedTripType {
        case 1:
            return Religious
        case 2:
            return Sports
        case 3:
            return Desert
        case 4:
            return Medical
        case 5:
            return Festivals
        case 6:
            return Education
        default:
            return []
        }
    }
    
    
    func incrementCount(_ index: Int) {
           counts[index] += 1
           citiesInfo[index].numberOfDays += 1
       }

       func decrementCount(_ index: Int) {
           if counts[index] > 0 {
               counts[index] -= 1
               citiesInfo[index].numberOfDays -= 1
           }
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
//            generatedPlan = tripPlanner.generatePlan(
//                budget: enteredBudget,
//                duration: Int(duration) ?? 0,
//                tripType: tripTypes[selectedTripType]
//            )
            withAnimation {
                                       selectedTripType = 0
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


//func fetchPlansData(chosenTripType: String, convertedBudget: Int, totalNumberOfDays: Int) {
//    // Prepare the API URL string by interpolating the values
//    let urlString = "https://8422-197-54-130-239.ngrok-free.app/recommendations/\(chosenTripType)/\(convertedBudget)/\(totalNumberOfDays)"
//    
//    if let url = URL(string: urlString) {
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            do {
//                let decodedData = try JSONDecoder().decode(PlanData.self, from: data)
//                // Access the fetched plans here
//                let fetchedPlans = decodedData.bestRecommendationsPlans
//                
//                // Process or use the fetched plans as needed
//                print("Fetched Plans: \(fetchedPlans)")
//            } catch {
//                print("Error decoding JSON: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }
//}

//struct Currency: Codable {
//    let name: String
//    let code: String
//    // Add other properties as needed
//}
//
//
//
//struct CurrenciesResponse: Codable {
//    let status: Int
//    let msg: String?
//    let results: [Currency]
//}


struct FifthScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlanningScreen()
    }
}
