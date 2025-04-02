//
//  StoreManager.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-31.
//


import Combine
import Foundation
import StoreKit

typealias ProductID = String
typealias SubscriptionPeriod = Product.SubscriptionPeriod

/// FROM: https://www.revenuecat.com/blog/engineering/ios-in-app-subscription-tutorial-with-storekit-2-and-swift/
@MainActor
class StoreManager: ObservableObject {
    
    let productIds = ["com.bundle-id", "..."]
    
    @Published private(set) var purchasedProductIDs = Set<String>()

    @Published var products: [Product]
    
    private var productsLoaded = false
    
    private var updates: Task<Void, Never>? = nil
    
    init(products: [Product] = []) {
        self.products = products
        updates = observeTransactionUpdates()
    }

    deinit {
        updates?.cancel()
    }

    var hasUnlockedPro: Bool {
        !purchasedProductIDs.isEmpty
    }
    
    func loadProducts() async throws {
        guard !productsLoaded else { return }
        products = try await Product.products(for: productIds)

        productsLoaded = true
    }

    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [unowned self] in
            for await verificationResult in Transaction.updates {
                guard case .verified(let transaction) = verificationResult else { return }
                self.handleVerifiedTransaction(transaction)
            }
        }
    }

    func restore() async -> Bool {
        return ((try? await AppStore.sync()) != nil)
    }

    func purchase(_ productId: ProductID) async throws -> Bool {
        guard let product = products.first(where: {$0.id == productId }) else { return false }
        
        let result = try await product.purchase()

        switch result {
        case let .success(.verified(transaction)):
            await transaction.finish()
            await updatePurchasedProducts()
            AlertController.shared.showToast("Purchase Success", type: .success)
            return true
        case .success(.unverified):
            AlertController.shared.showToast("Unverified Purchase", type: .failure)
            // Successful purchase but transaction/receipt can't be verified
            // Could be a jailbroken phone
            return true
        case .pending:
            // Transaction waiting on SCA (Strong Customer Authentication) or
            // approval from Ask to Buy
            return true
        case .userCancelled:
            //AlertController.shared.showToast("Transaction cancelled!", type: .failure)
            // ^^^
            return false
        @unknown default:
            return false
        }
    }
    
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }

            handleVerifiedTransaction(transaction)
        }
    }
    
    private func handleVerifiedTransaction(_ transaction: Transaction) {
        if transaction.revocationDate == nil {
            purchasedProductIDs.insert(transaction.productID)
        } else {
            purchasedProductIDs.remove(transaction.productID)
        }
    }
    
    func requestReview(context: String) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        AppStore.requestReview(in: windowScene)
    }
}

struct IntroOffer {
    public let displayPrice: String
    public let period: SubscriptionPeriod
}
