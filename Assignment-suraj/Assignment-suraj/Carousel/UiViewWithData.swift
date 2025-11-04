//
//  UiViewWithData.swift
//  Assignment-suraj
//
//  Created by suraj_kumar on 01/11/25.
//

import Foundation

struct UiViewWithData: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String
    var imageName: String
}

let sampleItems = ObservableArray(array: [
    UiViewWithData(title: "Beach Escape", subtitle: "Relax at the seaside", imageName: "sun.max"),
    UiViewWithData(title: "Mountain Trek", subtitle: "Adventure awaits", imageName: "mountain.2"),
    UiViewWithData(title: "Cafe Time", subtitle: "Coffee & chill", imageName: "cup.and.saucer"),
    UiViewWithData(title: "Night Sky", subtitle: "Stargazing vibes", imageName: "moon.stars"),
    UiViewWithData(title: "Workout Day", subtitle: "Stay active", imageName: "figure.run"),
    UiViewWithData(title: "Road Trip", subtitle: "Hit the highway", imageName: "car")
])

