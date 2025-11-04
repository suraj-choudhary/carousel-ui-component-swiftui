
//
//  CustomCarousel.swift
//  Assignment-suraj
//
//  Created by suraj_kumar on 01/11/25.
//


import SwiftUI

struct CustomCarousel<Content: View, BottomContent: View>: View {
    
    var proxy: GeometryProxy
    @ObservedObject var uiCarouselList: ObservableArray<UiViewWithData>
    @ViewBuilder var content: (Int)-> Content
    @ViewBuilder var bottomContent: (Int) -> BottomContent
    
    @GestureState public var longPressState: CarouselDragState = .inActive
    @GestureState public var isDragging: Bool = false
    
    @State public var activeIndex: Int = 0
    @State public var dragOffset: Double = 0.0
    
    public let dragThreshold: CGFloat = 0.2
    public let boundaryResistance: CGFloat = 0.1
    
    @State public var draggingItem: Double = 0.0
    @State public var draggingItemCurrent: Double = 0.0
    @State public var userIsHolding: Bool = false
    var showNextCardPreview: Bool = false
    
    
    var cardSpacing: Double = 70.0
    
    @State var anyViewHeight: CGFloat?
    
    var body: some View {
        VStack(spacing: 12) {
            
            let dragGesture = carouselDragGesture
            
            ZStack(alignment: .top) {
                getContentList()
            }
            .contentShape(Rectangle())
            .if(uiCarouselList.array.count > 1) { view in
                view.gesture(dragGesture)
            }
            
            HStack(spacing: 8) {
                ForEach(uiCarouselList.array.indices, id: \.self) { index in
                    Circle()
                        .fill(index == activeIndex ? Color.blue : Color.gray.opacity(0.4))
                        .frame(width: index == activeIndex ? 10 : 7,
                               height: index == activeIndex ? 10 : 7)
                        .animation(.easeInOut(duration: 0.25), value: activeIndex)
                }
            }
            .padding(.top, 8)
        }
        .padding(.vertical, 8)
    }
    
    @ViewBuilder
    private func getContentList() -> some View {
        let itemCount = uiCarouselList.array.count
        
        ForEach(Array(uiCarouselList.array.enumerated()), id: \.element.id) { (index, item) in
            
            let offset = getCurrentOffset(index: index, proxy: proxy)
            let isActive = index == activeIndex
            
            let scale = scaleFor(index: index)
            VStack(spacing: 6) {
                if let fixedHeight = anyViewHeight {
                    content(index)
                        .frame(height: fixedHeight)
                } else {
                    content(index)
                }
                bottomContent(index)
            }
            .scaleEffect(userIsHolding && isActive ? 0.7 : scale)
            
            .frame(maxWidth: .infinity)
            .animation(.spring(response: 0.35, dampingFraction: 0.75), value: activeIndex)
            .offset(x: offset)
            .zIndex(Double(itemCount - abs(activeIndex - index)))
            .contentShape(Rectangle())
        }
    }
    
}


