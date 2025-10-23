//
//  InputViewModel.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 28/04/1447 AH.
//

import SwiftUI
import Combine

class InputSectionViewModel: ObservableObject {
    @Published var topic: String = ""
    @Published var selectedTimeframe: String = "Week"

    /// Computed property for allowed freeze days
    var freezeLimit: Int {
        switch selectedTimeframe {
        case "Week":
            return 2
        case "Month":
            return 8
        case "Year":
            return 96
        default:
            return 0
        }
    }
}

