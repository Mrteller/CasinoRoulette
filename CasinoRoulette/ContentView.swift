//
//  ContentView.swift
//  CasinoRoulette
//
//  Created by  Paul on 21.11.2021.
//

import SwiftUI
enum Color: String {
    case red = "RED"
    case black = "BLACK"
    case green = "ZERO"
}
struct Sector: Equatable {
    let number: Int
    let color: Color
}
struct ContentView: View {
    @State private var isAnimating = false
    @State private var spinDegrees = 0.0
    private let fullTurn = 360.0
    private var randomAngle: Double { Double.random(in: 1...fullTurn) }
    let halfSector = 360.0 / 37.0 / 2.0
    let sectors: [Sector] = [Sector(number: 32, color: .red),
                             Sector(number: 15, color: .black),
                             Sector(number: 19, color: .red),
                             Sector(number: 4, color: .black),
                             Sector(number: 21, color: .red),
                             Sector(number: 2, color: .black),
                             Sector(number: 25, color: .red),
                             Sector(number: 17, color: .black),
                             Sector(number: 34, color: .red),
                             Sector(number: 6, color: .black),
                             Sector(number: 27, color: .red),
                             Sector(number: 13, color: .black),
                             Sector(number: 36, color: .red),
                             Sector(number: 11, color: .black),
                             Sector(number: 30, color: .red),
                             Sector(number: 8, color: .black),
                             Sector(number: 23, color: .red),
                             Sector(number: 10, color: .black),
                             Sector(number: 5, color: .red),
                             Sector(number: 24, color: .black),
                             Sector(number: 16, color: .red),
                             Sector(number: 33, color: .black),
                             Sector(number: 1, color: .red),
                             Sector(number: 20, color: .black),
                             Sector(number: 14, color: .red),
                             Sector(number: 31, color: .black),
                             Sector(number: 9, color: .red),
                             Sector(number: 22, color: .black),
                             Sector(number: 18, color: .red),
                             Sector(number: 29, color: .black),
                             Sector(number: 7, color: .red),
                             Sector(number: 28, color: .black),
                             Sector(number: 12, color: .red),
                             Sector(number: 35, color: .black),
                             Sector(number: 3, color: .red),
                             Sector(number: 26, color: .black),
                             Sector(number: 0, color: .green)]
    
    func getAngle(angle: Double) -> Double {
        let deg = 360 - angle.truncatingRemainder(dividingBy: 360)
        return deg
    }
    
    func sectorFromAngle(angle: Double) -> String {
        
        for i in sectors.indices {
            let start: Double = halfSector * Double((i*2 + 1)) - halfSector
            let end: Double = halfSector * Double((i*2 + 3))
            
            if(angle >= start && angle < end) {
                let sector = sectors[i]
                return "Sector\n\(sector.number) \(sector.color.rawValue)"
            }
        }
        
        return "Undefined sector"
    }
    
    var body: some View {
        VStack {
            Text(isAnimating ? "Spining\n..." : sectorFromAngle(angle : getAngle(angle: spinDegrees)))
                .multilineTextAlignment(.center)
            Image("Arrow")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Roulette()
                .modifier(AnimatableModifierWithCompletion(
                    bindedValue: spinDegrees,
                    completion: { isAnimating = false }))
                .rotationEffect(Angle(degrees: spinDegrees))
                .padding()
            Button("SPIN") {
                isAnimating = true
                let randomTurns = Int.random(in: 1...3)
                withAnimation(.easeOut(duration: Double(2 + randomTurns))) {
                    spinDegrees += fullTurn * Double(randomTurns) + randomAngle
                }
            }
            .padding(40)
            .disabled(isAnimating == true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
