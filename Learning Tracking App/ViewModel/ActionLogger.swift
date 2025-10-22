//
//  ActionLogger.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 29/04/1447 AH.
//

import SwiftUI
import Combine

class ActionLoggerViewModel: ObservableObject {
    @Published var hasLogged: Bool = false
    @Published var loggedType: LoggedType? = nil
    
    enum LoggedType {
        case learned, freezed
    }
    
    func logAsLearned() {
        hasLogged = true
        loggedType = .learned
        // Add other logic if needed
    }
    
    func logAsFreezed() {
        hasLogged = true
        loggedType = .freezed
        // Add other logic if needed
    }
}
