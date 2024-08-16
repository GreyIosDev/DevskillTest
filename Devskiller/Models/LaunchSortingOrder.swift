//
//  LaunchSortingOrder.swift
//  Devskiller
//
//  Created by Grey  on 14.08.2024.
//  Copyright © 2024 Mindera. All rights reserved.
//

import Foundation

enum LaunchOrder {
    case ascending
    case descending

    var value: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }
}
