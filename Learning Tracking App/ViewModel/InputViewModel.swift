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

 
}
