//
//  Views+Haptic.swift
//  Supermercado
//
//  Created by Douglas Taquary on 21/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI


func haptic(_ notificationType: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(notificationType)
}
