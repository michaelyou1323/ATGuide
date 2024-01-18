import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

struct Reservation: Identifiable {
    let id: String
    let hotelsDetails: String // Adjust the type as needed
    let numberOfUser: Int
    let tripType: String
    let budget: Double
    let selectedDaysList: [[String: Any]] // Adjust the type as needed
    let planNumber: Int
    let hotelStars: Int
    let userID: String
    let planId: String
    let image2: String
    let selectNumberOfPersons: Int


}

class ReservationModel: ObservableObject {
    @Published var reservations: [Reservation] = []
    let userId: String // The user ID for whom you want to fetch plans
    
    init(userId: String) {
        self.userId = userId
        fetchUserPlans()
    }
    
    func fetchUserPlans() {
        guard !userId.isEmpty && userId.rangeOfCharacter(from: CharacterSet(charactersIn: ".#$[]")) == nil else {
            // Handle invalid userId
            return
        }

        let ref = Database.database().reference().child("plans").child(userId)
        ref.observe(.value) { snapshot in
            var fetchedPlans: [Reservation] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let planDict = snapshot.value as? [String: Any] {
                    
                    // Parse the plan data from the snapshot
                    let id = snapshot.key
                    let hotelsDetails = planDict["hotelsDetails"] as? String ?? " "
                    let numberOfUser = planDict["numberOfUser"] as? Int ?? 0
                    let tripType = planDict["TripType"] as? String ?? " "
                    let budget = planDict["budget"] as? Double ?? 0.0
                    let selectedDaysList = planDict["selectedDaysList"] as? [[String: Any]] ?? []
                    let planNumber = planDict["PlanNumber"] as? Int ?? 0
                    let hotelStars = planDict["HotelStars"] as? Int ?? 0
                    let userID = planDict["userID"] as? String ?? " "
                    let planId = planDict["planId"] as? String ?? " "
                    let image2 = planDict["Image2"] as? String ?? " "
                    let selectNumberOfPersons = planDict["selectNumberOfPersons"] as? Int ?? 0

                    // Create a Plan object and add it to the fetchedPlans array
                    let reservation = Reservation(
                        id: id,
                        hotelsDetails: hotelsDetails,
                        numberOfUser: numberOfUser,
                        tripType: tripType,
                        budget: budget,
                        selectedDaysList: selectedDaysList,
                        planNumber: planNumber,
                        hotelStars: hotelStars,
                        userID: userID,
                        planId: planId,
                        image2: image2,
                        selectNumberOfPersons: selectNumberOfPersons
                    )

                    fetchedPlans.append(reservation)
                }
            }
            // Update the published plans array
            DispatchQueue.main.async {
                self.reservations = fetchedPlans
            }
        }
    }
}



