//
//  ProgramsDataModel.swift
//  Preacher
//
//  Created by Michaelyoussef on 12/09/2023.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class PlanViewModel: ObservableObject {
    @Published var plans: [Plan] = []
    let userId: String // The user ID for whom you want to fetch plans
    
    init(userId: String) {
        self.userId = userId
        fetchUserPlans()
    }
    
    func fetchUserPlans() {
        let ref = Database.database().reference().child("FavPlans").child(userId)
        
        ref.observe(.value) { snapshot in
            var fetchedPlans: [Plan] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let planDict = snapshot.value as? [String: Any] {
                    
                    // Parse the plan data from the snapshot
                    let id = snapshot.key
                    let hotelStars = planDict["HotelStars"] as? Int ?? 0
                    let planNumber = planDict["PlanNumber"] as? Int ?? 0
                    let tripType = planDict["TripType"] as? String ?? ""
                    let budget = planDict["budget"] as? Int ?? 0
                    let selectedDaysList = planDict["selectedDaysList"] as? String ?? ""
                    let planId = planDict["planId"] as? String ?? ""
                    // Create a Plan object and add it to the fetchedPlans array
                    let plan = Plan(id: id,
                                    hotelStars: hotelStars,
                                    planNumber: planNumber,
                                    tripType: tripType,
                                    budget: budget,
                                    selectedDaysList: selectedDaysList,
                                    planId: planId
                    )
                    
        
                    fetchedPlans.append(plan)
                }
            }
            // Update the published plans array
            DispatchQueue.main.async {
                self.plans = fetchedPlans
            }
        }
    }
}

struct Plan: Identifiable {
    let id: String
    let hotelStars: Int
    let planNumber: Int
    let tripType: String
    let budget: Int
    let selectedDaysList: String
    let planId: String
    // Add other properties as needed
}

