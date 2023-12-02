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

struct FifthScreen: View {

    @State private var tripBudget: String = ""
    @State private var duration: String = ""
    let tripTypes = ["Select trip type", "Religious", "Sports", "Desert", "Medical", "Festivals", "Education"]
    let Religious = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
    let Sports = ["a", "Siwa", "b", "Luxor", "h", "Assiut"]
    let Desert = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
    let Medical = ["8787", "dddd", "jh", "jjhj", "Giza", "Assiut"]
    let Festivals = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
    let Education = ["Cairo", "Siwa", "Aswan", "Luxor", "Giza", "Assiut"]
       @State private var counts: [Int] = Array(repeating: 0, count: 6)
    let tripPrices = [0, 3000, 2000, 4500, 6000, 7000, 9000] as [Any]
    @State private var selectedTripType = 0
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
    
    
     // @State private var religiousCityCount = Array(repeating: 0, count: 7)

    
    var body: some View {
        
        VStack( ){
                Text("Planning Section")
                    .font(.title)
                    .padding(.bottom, 40)
            
                
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
                Picker("Select trip type", selection: $selectedTripType) {
                    ForEach(tripTypes.indices, id: \.self) { index in
                        Text(self.tripTypes[index])
                      
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
            }
            .frame(height: 35)
            .padding(.bottom, 10)
            .padding(.horizontal, 110)

            
            TextField("Enter trip budget (Minimum: \(getMinimumPrice()))", text: $tripBudget)
                .textFieldStyle(CustomTextFieldStyle(isFocused: isBudgetFieldFocused, isEnabled: selectedTripType != 0))
                .padding(.horizontal, 40)
                .disabled(selectedTripType == 0)
                .padding(.bottom, 15)
                
            
            
//            
//                if selectedTripType != 0 {
//                  
//                        Text("Choose your preferred city:")
//                            .font(.headline)
//                            .padding(.horizontal, 40)
//                            .padding(.bottom, 10)
//           
//                        HStack {
//                            Text("City")
//                            Spacer()
//                            Text("Days     ")
//                        }
//                        .foregroundColor(.green)
//                        .padding(.horizontal,33)
//                        .padding(.bottom, 5)
//                        
//                        
//                        
//                    List {
//                        ForEach(getCitiesForTripType(), id: \.self) { city in
//                            let index = getCitiesForTripType().firstIndex(of: city) ?? 0
//                            HStack {
//                               
//                                Text(city)
//                                Spacer()
//
//                                Button(action: {
//                                    self.incrementCount(index)
//                                }) {
//                                    Image(systemName: "plus.circle")
//                                        .foregroundColor(.blue)
//                                }
//                                .buttonStyle(BorderlessButtonStyle())
//
//                                Text("\(self.counts[getCitiesForTripType().firstIndex(of: city) ?? 0])")
//                                    .padding(.horizontal, 10)
//
//                                Button(action: {
//                                    self.decrementCount(index)
//                                }) {
//                                    Image(systemName: "minus.circle")
//                                        .foregroundColor(.blue)
//                                }
//                                .buttonStyle(BorderlessButtonStyle())
//                            }
//                            .contentShape(Rectangle())
//                        }
//                    }
//                        .frame(height: 300)
//                        .listStyle(.plain)
//                        .padding(.horizontal, 10)
//                        .cornerRadius(15)
//                        .padding(.bottom, 0)
//                        .transition(.opacity) // Adding transition
//                        .animation(.smooth) // Adding animation
//                    
//                        Button(action: {
//                            withAnimation {
//                                selectedTripType = 0
//                            }
//                        }) {
//                            Text("Done")
//                            
//                                .foregroundColor(.white)
//                                .padding(.horizontal, 8)
//                                .padding(.vertical, 5)
//                                .background(Color.green)
//                                .cornerRadius(8)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .trailing)
//                        .padding(.trailing, 20)
//                        .padding(.bottom, 0) // Adjusted bottom padding
//                    
//                }else {
//                    // Show an empty frame with a height of 400 when no trip type is selected
//                    VStack {
//                        Spacer()
//                        Rectangle()
//                            .fill(Color.gray.opacity(0.01))
//                            .frame(height: 400)
//                        Spacer()
//                    }
//                }
//                
                
                
                if selectedTripType == 0 {
                  
                    VStack() {
                        ScrollView{
                                              
                                          
                        ZStack {
                            let shape = RoundedRectangle(cornerRadius: 20)
                            shape.fill().foregroundColor(Color.gray.opacity(0.01))
                            shape.stroke(Color.gray, lineWidth: 1)
                            Text("First Plan")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            
                        }
                        .frame(height: 120)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 60)
                        
                        ZStack() {
                            let shape = RoundedRectangle(cornerRadius: 20)
                            shape.fill().foregroundColor(Color.gray.opacity(0.01))
                            shape.stroke(Color.gray, lineWidth: 1)
                            Text("Second Plan")
                                .padding(.bottom, 2)
                                
                            Text("")
                            
                        }
                        .frame(height: 120)
                        .padding(.vertical, 10) 
                        .padding(.horizontal, 60)
                        
                        
                        ZStack {
                            let shape = RoundedRectangle(cornerRadius: 20)
                            shape.fill().foregroundColor(Color.gray.opacity(0.01))
                            shape.stroke(Color.gray, lineWidth: 1)
                            Text("Third Plan")
                                .padding(.bottom, 2)
                            
                        }
                        .frame(height: 120)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 60)
                        
                      
                        
//                        ForEach(plan.activities.keys.sorted(), id: \.self) { activity in
//                            Text("\(activity): $\(plan.activities[activity] ?? 0)")
//                                .padding(.bottom, 2)
//                        }
                        
                      
                        Spacer()
                        }
                    }
                }
                
     
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
            
                .padding(.bottom, 50)
                
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Note"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
         
            }
       
            
            .background(Color.gray.opacity(0.1).ignoresSafeArea())
      
        
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
    }

    func decrementCount(_ index: Int) {
        if counts[index] > 0 {
            counts[index] -= 1
        }
    }
    
    
//    struct ReligiousCityRow: View {
//        let title: String
//        @Binding var count: Int
//        
//        var body: some View {
//            HStack {
//                Text(title)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                
//                Spacer()
//                
//                HStack(spacing: 8) {
//                    Button(action: {
//                        if count > 0 {
//                            count -= 1
//                            
//                        }
//                    }) {
//                        Image(systemName: "minus.circle")
//                            .foregroundColor(.blue)
//                    }
//                    
//                    Text("\(count)")
//                        .padding(.horizontal, 8)
//                    
//                    Button(action: {
//                        count += 1
//                        
//                    }) {
//                        Image(systemName: "plus.circle")
//                            .foregroundColor(.blue)
//                    }
//                }
//            }
//            .contentShape(Rectangle())
//        }
//        
//    }
    
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

struct FifthScreen_Previews: PreviewProvider {
    static var previews: some View {
        FifthScreen()
    }
}
