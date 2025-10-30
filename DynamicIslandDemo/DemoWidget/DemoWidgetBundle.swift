//
//  DemoWidgetBundle.swift
//  DemoWidget
//
//  Created by Mimi Chen on 10/29/25.
//

import WidgetKit
import SwiftUI

@main
struct DemoWidgetBundle: WidgetBundle {
    var body: some Widget {
        DemoLiveActivity()
        DemoWidgetControl()
        DemoWidgetLiveActivity()
    }
}
