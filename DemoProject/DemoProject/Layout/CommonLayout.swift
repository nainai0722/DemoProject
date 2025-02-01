//
//  CommonLayout.swift
//  DemoProject
//
//  Created by 指原奈々 on 2025/02/01.
//

import Foundation
import SwiftUI

struct CommonLayout {
    static let width = UIDevice.current.userInterfaceIdiom == .phone ? UIScreen.main.bounds.width - 100 : UIScreen.main.bounds.width * 0.35
}

