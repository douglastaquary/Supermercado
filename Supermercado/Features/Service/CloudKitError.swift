//
//  CloudKitError.swift
//  Supermercado
//
//  Created by Douglas Taquary on 05/05/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//


import Foundation

enum CloudKitError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again"
    case unableToAddCart = "Unable to add new cart in iCloud. Oops. I'm sorry ☹️."
    case unableToRemoveCart = "Unable to delete cart from iCloud. Oops. I'm sorry ☹️."
    case unableToAddPurchase = "Unable to add your purchase on your list in iCloud. Oops. I'm sorry ☹️."
    case unableToRemovePurchase = "Unable to delete purchase from your list in iCloud. Oops. I'm sorry ☹️."
    case unableToCartList = "Unable to fetch carts from iCloud. Oops. I'm sorry ☹️."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToShoppingList = "Unable to fetch shopping from your list in iCloud. Oops. I'm sorry ☹️."

}
