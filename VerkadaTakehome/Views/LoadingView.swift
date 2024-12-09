//
//  LoadingView.swift
//  VerkadaTakehome
//
//  Created by Richie Sun on 12/9/24.
//

import SwiftUI

struct LoadingView: View {

    @State private var isAnimating = false

    var color: Color = Constants.Colors.pokemonBlue

    var size: CGFloat = 50

    var lineWidth: CGFloat = 8

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.75)
            .stroke(color, lineWidth: lineWidth)
            .frame(width: size, height: size)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .animation(
                .linear(duration: 1).repeatForever(autoreverses: false),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}
