//
//  ATGuideApp.swift
//  ATGuide
//
//  Created by Michaelyoussef on 07/10/2023.
//

import SwiftUI
import Firebase


@main
struct ATGuideApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
