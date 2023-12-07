//
//  DetailsScreen.swift
//  ATGuide
//
//  Created by Michaelyoussef on 05/12/2023.
//

import SwiftUI

struct DetailsScreen: View {
    var tripDetails: TripDetails
    
    var body: some View {
        VStack {
            Text("Trip Type: \(tripDetails.tripType)")
            Text("Entered Budget: \(tripDetails.enteredBudget)")
            Text("Hotel Stars: \(tripDetails.hotelStars)")
            
            ForEach(tripDetails.citiesInfo, id: \.cityName) { cityInfo in
                Text("\(cityInfo.cityName): \(cityInfo.numberOfDays) days")
            }
        }
    }
}

#Preview {
    DetailsScreen(tripDetails:  TripDetails(tripType: "chosenTripType",
                                            citiesInfo: [],
                                            hotelStars: 0,
                                            enteredBudget: "tripBudget"))
}
