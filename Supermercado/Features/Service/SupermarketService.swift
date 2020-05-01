//
//  SupermarketService.swift
//  SuperMarketUI
//
//  Created by Douglas Alexandre Barros Taquary on 26/02/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import LLVS
import LLVSCloudKit
import CloudKit
import Combine

public final class SupermarketService: ObservableObject {
    
    static let identifier = "iCloud.com.douglastaquary.mercado"
    static let mainZone = "MainZone"
    static let mainStore = "MainStore"
    
    lazy public var storeCoordinator: StoreCoordinator = {
        LLVS.log.level = .verbose
        let coordinator = try! StoreCoordinator()
        let container = CKContainer(identifier: SupermarketService.identifier)
        let exchange = CloudKitExchange(with: coordinator.store, storeIdentifier: SupermarketService.mainStore, cloudDatabaseDescription: .privateDatabaseWithCustomZone(container, zoneIdentifier: SupermarketService.mainZone))
        coordinator.exchange = exchange
        exchange.subscribeForPushNotifications()
        return coordinator
    }()
    
    private var cartSubscriber: AnyCancellable?
    
    public init() {
        cartSubscriber = storeCoordinator.currentVersionSubject
            .receive(on: DispatchQueue.main)
            .map( { self.performCarts(at: $0) })
            .assign(to: \.carts, on: self)
    }
    
    @Published var carts: [Cart] = []

    private func performCarts(at version: Version.Identifier) -> [Cart] {
        return try! Cart.all(in: storeCoordinator, at: version).sorted(by: {
            (($0.name, $0.id.uuidString) < ($1.name, $1.id.uuidString))
        })
    }
    
    // MARK: - Cart Store Manager
    
    func addNewCart(_ cart: Cart) {
        let change: Value.Change = .insert(try! cart.encodeValue())
        try! storeCoordinator.save([change])
        sync()
    }
    
    func updateCart(_ cart: Cart) {
        let change: Value.Change = .update(try! cart.encodeValue())
        try! storeCoordinator.save([change])
        sync()
    }
    
    func deleteCart(withID id: Cart.ID) {
        let change: Value.Change = .remove(Cart.storeValueId(for: id))
        try! storeCoordinator.save([change])
        sync()

    }
    
    func cart(withID id: Cart.ID) -> Cart {
        return carts.first(where: { $0.id == id }) ?? Cart(name: "", iconName: .undefined)
    }
    
    //MARK: SupermarketItems Store Manager
    
    func fetchSupermarketItem(for id: Cart.ID, with uuid: UUID) -> SupermarketItem {
        let cart = self.cart(withID: id)
        return cart.items.first(where: { $0.id == uuid }) ?? SupermarketItem()
    }
    

    
    func fetchItems(for id: Cart.ID) -> [SupermarketItem] {
        
        let cart = self.cart(withID: id)
        
        return cart.items
    }
    
    func addItem(for id: Cart.ID, with content: SupermarketItem) {
        var cart = self.cart(withID: id)
        cart.items.append(content)
        updateCart(cart)
        sync()
    }
    
    func deleteItem(for id: Cart.ID, with content: SupermarketItem) {
        var cart = self.cart(withID: id)
        cart.items.removeAll(where: { $0.id == content.id})
        updateCart(cart)
    }
    
    // MARK: Syncing
    
    func sync(executingUponCompletion completionHandler: ((Swift.Error?) -> Void)? = nil) {
        storeCoordinator.exchange { _ in
            self.storeCoordinator.merge()
        }
    }
}
