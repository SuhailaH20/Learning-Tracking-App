//
//  ContentView.swift
//  Learning Tracking App
//
//  Created by Suhaylah hawsawi on 24/04/1447 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 1000, style: .continuous)
                    .fill(Color.primary.opacity(0.20))
                    .frame(width: 109, height: 109)
                    .opacity(0.45)
                    .glassEffect()

                Image(systemName: "flame.fill")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(Color(red: 255/255, green: 146/255, blue: 48/255, opacity: 1.0))
                    .frame(width: 67, height: 43, alignment: .center)


            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
