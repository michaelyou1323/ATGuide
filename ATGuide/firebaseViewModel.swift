//
//  firebaseViewModel.swift
//  ATGuide
//
//  Created by Michaelyoussef on 25/12/2023.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift


class firebaseViewModel: ObservableObject{
    
    private let ref = Database.database().reference ()

    func pushNewValue (value: String) {
        ref.setValue(value)
    }
    
    func pushObject(TripType: String, HotelStars: Int, PlanNumber: Int, budget: Double, selectedDaysList: String, userID:String, planId:String, Image:String ,selectNumberOfPersons:Int, favStatus:Bool) {
        let generateObject = ObjectDemo()
        generateObject.TripType = TripType
        generateObject.HotelStars = HotelStars
        generateObject.PlanNumber = PlanNumber
        generateObject.budget = budget
        generateObject.userID = userID
        generateObject.selectedDaysList = selectedDaysList
        generateObject.planId = planId
        generateObject.Image = Image
        generateObject.selectNumberOfPersons = selectNumberOfPersons
        
        generateObject.favStatus = favStatus
        
        let hotelStarsString = String(HotelStars)
        let PlanNumberString = String(PlanNumber)
        ref.child("FavPlans").child(userID).child( "Type:" + TripType + "Plan:" + planId).setValue(generateObject.toooDictionary)
   
        
        }
    
    func deletObject(TripType: String, userID: String, planId: String) {
        ref.child("FavPlans").child(userID).child("Type:" + TripType + "Plan:" + planId).removeValue()
    }
}


