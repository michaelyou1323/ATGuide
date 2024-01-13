//
//  AppObjectDemo.swift
//  ATGuide
//
//  Created by Michaelyoussef on 25/12/2023.
//

import Foundation


class ProgramObjectDemo: Encodable,Decodable,Identifiable{
    
    var hotelStars:String = ""
    var planNumber:String = ""
    var tripType:String = ""
    var budget:String = ""
    var selectedDayList:String = ""
    var userID:String = ""
    var Image: String = ""
}


extension Encodable{
    var toooDictionary: [String: Any]?{
        guard let data = try? JSONEncoder().encode(self) else{
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments)as? [String: Any]
    }
}

