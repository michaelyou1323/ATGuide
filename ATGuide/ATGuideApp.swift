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
    @AppStorage("selectedTabIndex") var selectedTabIndex: Int = 0
    @AppStorage("didLaunchBefore") private var didLaunchBefore: Bool = false
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
