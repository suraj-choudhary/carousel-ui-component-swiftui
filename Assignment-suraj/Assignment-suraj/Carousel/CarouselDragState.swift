//
//  CarouselDragState.swift
//  Assignment-suraj
//
//  Created by suraj_kumar on 01/11/25.
//

import Foundation

 enum CarouselDragState {
    
    case inActive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inActive:
            return .zero
        case .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inActive:
            return true
        case .pressing:
            return false
        case .dragging(let translation):
            return false
        }
    }
    
    var isPressing: Bool {
        switch self {
        case .inActive:
            return false
        case .pressing:
            return false
        case .dragging(let translation):
            return true
        }
    }
}
