//
//  ObjectDemo.swift
//  ATGuide
//
//  Created by Michaelyoussef on 25/12/2023.
//



import Foundation
class ObjectDemo: Encodable{
    var TripType: String = ""
    var budget: Double = 0.0
    var selectedDaysList: String = "" // Make sure to initialize it properly
    var PlanNumber: Int = 0
    var HotelStars: Int = 0
    var userID: String = ""
    var planId: String = ""
    var Image: String = ""
    var selectNumberOfPersons: Int = 0
    var favStatus: Bool = true
    
}

extension Encodable{
    var tooDictionary: [String: Any]?{
        guard let data = try? JSONEncoder().encode(self)
        else{
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
