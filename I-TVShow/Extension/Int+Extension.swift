//
//  Int+Extension.swift
//  I-TVShow
//
//  Created by Fuego on 8/29/20.
//  Copyright © 2020 Kobi Cook. All rights reserved.
//

import Foundation

extension Int {
    var addCommas: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: self as NSNumber)
    }
}
