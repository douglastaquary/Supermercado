//
//  SupermarketViewModel.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 25/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import LLVS
import LLVSCloudKit
import CloudKit

final class SupermarketViewModel: ObservableObject {
    
    var supermarketService: SupermarketService
    
    public var items: [Supermarket] = []
        
    init(supermarketService: SupermarketService) {
        self.supermarketService = supermarketService
        self.items = self.supermarketService.supermarkets
    }
    
    public func sink(_ supermarketID: Supermarket.ID) {
        let supermarket = supermarketService.supermarket(withID: supermarketID)
        supermarketService.update(supermarket)
    }

}
