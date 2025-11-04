//
//  CustomCarousel+Extension.swift
//  Assignment-suraj
//
//  Created by suraj_kumar on 02/11/25.
//

import SwiftUI

extension CustomCarousel {
    
    func getCurrentOffset(index: Int, proxy: GeometryProxy) -> Double {
        let width = proxy.size.width
        let baseSpacing = width - cardSpacing * 3
        let count = uiCarouselList.array.count
        
        // Relative index position (-2, -1, 0, +1, +2,...)
        var relativeIndex = index - activeIndex
        
        // Adjust relative index to compress movement
        if relativeIndex > 0 { relativeIndex -= 1 }
        if relativeIndex < 0 { relativeIndex += 1 }
        
        // Base offset for card according to distance
        var offset = Double(relativeIndex) * baseSpacing
        
        // Apply drag movement to all cards
        offset += draggingItem * width
        
        // Apply additional drag movement for the active card only
        if index == activeIndex {
            offset += draggingItemCurrent * width
        }
        
        // When holding, shift side cards inward slightly
        if userIsHolding {
            let holdShift = width / 8
            if index < activeIndex { offset += holdShift }
            if index > activeIndex { offset -= holdShift }
        }
        
        // Spread left and right cards outward relative to center
        if index < activeIndex { offset -= baseSpacing }
        if index > activeIndex { offset += baseSpacing }
        
        // Optional: show preview spacing on first/last cards
        if showNextCardPreview && count > 1 {
            if activeIndex == 0 { offset -= cardSpacing }
            if activeIndex == count - 1 { offset += cardSpacing }
        }
        
        return offset
    }
    
    // MARK: Drag Gesture Handler
     var carouselDragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                guard !longPressState.isPressing else { return }
                
                let dragPercent = value.translation.width / proxy.size.width
                
                // boundary resistance at edges
                if (activeIndex == 0 && dragPercent > 0) ||
                    (activeIndex == uiCarouselList.array.count - 1 && dragPercent < 0) {
                    
                    draggingItem = dragPercent * boundaryResistance
                } else {
                    draggingItem = dragPercent
                }
            }
            .onEnded { value in
                guard !longPressState.isPressing else { return }
                
                let predicted = value.predictedEndTranslation.width / proxy.size.width
                
                withAnimation(.getAnimation(0.45)) {
                    if predicted < -dragThreshold {
                        activeIndex = min(activeIndex + 1, uiCarouselList.array.count - 1)
                    } else if predicted > dragThreshold {
                        activeIndex = max(activeIndex - 1, 0)
                    }
                    
                    draggingItem = 0
                    draggingItemCurrent = 0
                }
            }
            .updating($isDragging) { _, state, _ in
                guard !longPressState.isPressing else { return }
                state = true
            }
    }
    
    
     func scaleFor(index: Int) -> CGFloat {
        let isActive = (index == activeIndex)
        let drag = draggingItem
        let absT = abs(max(-1, min(1, drag * 2)))
        
        if drag > 0 {
            if isActive { return lerp(1, 0.5, ttt: absT) }
            if index == activeIndex - 1 { return lerp(0.5, 1, ttt: absT) }
            return 0.5
        } else if drag < 0 { // dragging right
            if isActive { return lerp(1, 0.5, ttt: absT) }
            if index == activeIndex + 1 { return lerp(0.5, 1, ttt: absT) }
            return 0.5
        } else {
            return isActive ? 1 : 0.5
        }
    }
    
    func lerp(_ aaa: CGFloat, _ bbb: CGFloat, ttt: CGFloat) -> CGFloat {
        aaa + (bbb - aaa) * ttt
    }
}
