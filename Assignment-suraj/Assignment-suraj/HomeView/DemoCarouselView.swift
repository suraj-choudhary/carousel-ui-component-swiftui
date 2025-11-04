//
//  File.swift
//  Assignment-suraj
//
//  Created by suraj_kumar on 01/11/25.
//

import SwiftUI

struct CarouselDemo: View {
    
    @StateObject var items = sampleItems
    
    var body: some View {
        GeometryReader { proxy in
            CustomCarousel(
                proxy: proxy,
                uiCarouselList: items,
                
                content: { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 22)
                            .fill(
                                LinearGradient(
                                    colors: [.blue.opacity(0.3), .purple.opacity(0.4)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                        
                        VStack(spacing: 12) {
                            Image(systemName: items.array[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                            
                            Text(items.array[index].title)
                                .font(.title2.bold())
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                        }
                        .padding(32)
                    }
                },
                
                bottomContent: { index in
                    Text(items.array[index].subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.top, 4)
                }
            )
        }
        .padding(.horizontal)
    }
}
