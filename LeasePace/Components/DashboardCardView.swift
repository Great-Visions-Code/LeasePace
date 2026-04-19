//
//  DashboardCardView.swift
//  LeasePace
//
//  Created by Great-Visions-Code on 4/14/26.
//

import SwiftUI

struct DashboardCardView<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(
        title: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .bold()
            
            Divider()
            
            content
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue.opacity(0.10)
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 8) {
            
            // Example Lease Progress Card
            DashboardCardView(title: "Lease Progress") {
                VStack(spacing: 12) {
                    
                    Text("42% Complete")
                    
                    Divider()
                                                            
                    Text("213 days remaining")
                    
                    Divider()
                    
                    Text("Ends Feb 24, 2028")
                }
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
    }
}
