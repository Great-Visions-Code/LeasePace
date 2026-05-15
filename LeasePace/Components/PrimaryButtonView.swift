//
//  PrimaryButtonView.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 5/14/26.
//

import SwiftUI

struct PrimaryButtonView: View {
    
    let title: String
    var backgroundColor: Color = .blue
    
    var body: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundColor)
            )
    }
}

#Preview {
    PrimaryButtonView(
        title: "Button Text"
    )
}
