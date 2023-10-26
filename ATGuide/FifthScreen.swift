import SwiftUI

struct TripPlan {
    var destination: String
    var activities: [String: Double]
    var totalCost: Double
}

class TripPlanner {
    func generatePlan(budget: Double, duration: Int, tripType: String) -> TripPlan {
        var destination = ""
        var activities = [String: Double]()
        var totalCost = 0.0

        // Simple logic for destination based on trip type
        switch tripType {
        case "Religious":
            destination = "Holy City"
            activities = [
                "Visit religious sites": 50.0,
                "Attend religious events": 30.0
            ]
        case "Sports":
            destination = "Sports Hub"
            activities = [
                "Attend sports events": 70.0,
                "Visit sports facilities": 40.0
            ]
        case "Desert":
            destination = "Desert Oasis"
            activities = [
                "Explore the desert": 60.0,
                "Experience local culture": 45.0
            ]
        case "Medical":
            destination = "Health Retreat"
            activities = [
                "Medical spa": 80.0,
                "Wellness activities": 55.0
            ]
        case "Festivals":
            destination = "Festival City"
            activities = [
                "Attend festivals": 65.0,
                "Explore local culture": 35.0
            ]
        case "Education":
            destination = "Knowledge Hub"
            activities = [
                "Visit educational institutions": 75.0,
                "Attend lectures": 50.0
            ]
        default:
            destination = "Generic Destination"
            activities = [
                "Explore the area": 40.0,
                "Enjoy local cuisine": 25.0
            ]
        }

        // Calculate total cost based on budget
        for (_, price) in activities {
            totalCost += price
        }

        return TripPlan(destination: destination, activities: activities, totalCost: totalCost)
    }
}

struct FifthScreen: View {
    // Trip budget variable
    @State private var tripBudget: String = ""
    
    // Duration variable
    @State private var duration: String = ""
    
    // Options for the trip type dropdown menu
    let tripTypes = ["Select trip type", "Religious", "Sports", "Desert", "Medical", "Festivals", "Education"]
    
    // Selected trip type variable
    @State private var selectedTripType = 0
    
    // Generated trip plan
    @State private var generatedPlan: TripPlan? = nil
    
    // Trip planner instance
    private let tripPlanner = TripPlanner()
    
    var body: some View {
        VStack {
            // Planning section text
            Text("Planning Section")
                .font(.title)
                .padding(.top, 1)
                .padding(.bottom, 30)
                
            // Trip budget text field with black outline
            TextField("Enter trip budget", text: $tripBudget)
                .textFieldStyle(CustomTextFieldStyle())
                .padding(.bottom, 1)
                .padding(.horizontal, 15)
            
            // Duration text field with black outline
            TextField("Enter duration", text: $duration)
                .textFieldStyle(CustomTextFieldStyle())
                .padding(.top, 8)
                .padding(.horizontal, 15)
            
            // Dropdown menu for trip types
            Picker("Select trip type", selection: $selectedTripType) {
                ForEach(0..<tripTypes.count) {
                    Text(self.tripTypes[$0])
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            Spacer()
            
            // Display the generated plan
            if let plan = generatedPlan {
                          VStack {
                              Text("Generated Plan:")
                                  .font(.headline)
                                  .padding()

                              Text("Destination: \(plan.destination)")
                                  .padding()

                              Text("Activities:")
                                  .padding()

                              ForEach(plan.activities.keys.sorted(), id: \.self) { activity in
                                  Text("\(activity): $\(plan.activities[activity] ?? 0)")
                                      .padding()
                              }

                              Text("Total Cost: $\(plan.totalCost)")
                                  .padding()
                          }
                      }
            
            Spacer()

            // Generate a plan button
            Button(action: {
                // Generate plan when the button is tapped
                generatedPlan = tripPlanner.generatePlan(
                    budget: Double(tripBudget) ?? 0,
                    duration: Int(duration) ?? 0,
                    tripType: tripTypes[selectedTripType]
                )
            }) {
                Text("Generate a Plan")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
}

// Custom TextFieldStyle for black outline
struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}

struct FifthScreen_Previews: PreviewProvider {
    static var previews: some View {
        FifthScreen()
    }
}
