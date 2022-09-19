//
//  ThermostatViewApp.swift
//  ThermostatView
//
//  Created by Adrien Surugue on 19/09/2022.
//

import SwiftUI

@main
struct ThermostatViewApp: App {
    @State var currentTemp: Float = 20.0
    @State var location: String = "Living Room"
    var body: some Scene {
        WindowGroup {
            ContentView(currentTemp: $currentTemp, location: $location)
        }
    }
}
