import Foundation
import StoreKit
import Combine

@MainActor
class StoreManagerSK: ObservableObject {
    @Published var products: [Product] = []
    @Published var purchasedProductIDs: Set<String> = []
    @Published var isLoading: Bool = false
    @Published var restoreMessage: String?
    
    private let productIds = ["premium_theme_golden_pharaoh", "premium_theme_night_nile"]
    
    init() {
        Task {
            for await result in Transaction.updates {
                if let transaction = try? result.payloadValue {
                    purchasedProductIDs.insert(transaction.productID)
                    await transaction.finish()
                }
            }
        }
        
        Task {
            await updatePurchasedProducts()
            await fetchProducts()
        }
    }
    
    func fetchProducts() async {
        isLoading = true
        do {
            products = try await Product.products(for: productIds)
            products.sort { $0.displayName < $1.displayName }
            isLoading = false
        } catch {
            print("Failed to fetch products: \(error)")
            isLoading = false
        }
    }
    
    enum PurchaseResult {
        case success
        case userCancelled
        case pending
        case failed(Error)
    }
    
    @Published var areEntitlementsLoaded: Bool = false
    

    func purchaseTheme(_ id: String) async -> PurchaseResult {
        guard let product = products.first(where: { $0.id == id }) else {
            print("Product with ID \(id) not found")
            return .failed(NSError(domain: "StoreManagerSK", code: -1, userInfo: [NSLocalizedDescriptionKey: "Product not found"]))
        }
        
        return await purchase(product)
    }
    
    func purchase(_ product: Product) async -> PurchaseResult {
        isLoading = true
        var purchaseResult: PurchaseResult = .failed(NSError(domain: "StoreManagerSK", code: -2, userInfo: [NSLocalizedDescriptionKey: "Unknown error"]))
        
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                if let transaction = try? verification.payloadValue {
                    purchasedProductIDs.insert(transaction.productID)
                    await transaction.finish()
                    purchaseResult = .success
                } else {
                     purchaseResult = .failed(NSError(domain: "StoreManagerSK", code: -3, userInfo: [NSLocalizedDescriptionKey: "Transaction verification failed"]))
                }
            case .pending:
                purchaseResult = .pending
            case .userCancelled:
                purchaseResult = .userCancelled
            @unknown default:
                 purchaseResult = .failed(NSError(domain: "StoreManagerSK", code: -4, userInfo: [NSLocalizedDescriptionKey: "Unknown purchase result"]))
            }
        } catch {
            print("Purchase failed: \(error)")
            purchaseResult = .failed(error)
        }
        isLoading = false
        return purchaseResult
    }
    
    func restorePurchases() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await AppStore.sync()
            await updatePurchasedProducts()
            
            if purchasedProductIDs.isEmpty {
                restoreMessage = "No previous purchases found."
            } else {
                restoreMessage = "Purchases successfully restored!"
            }
        } catch {
            restoreMessage = "Failed to restore: \(error.localizedDescription)"
        }
    }
    
    
    private func updatePurchasedProducts() async {
        var newPurchasedIDs: Set<String> = []
        
        for await result in Transaction.currentEntitlements {
            switch result {
            case .verified(let transaction):
                newPurchasedIDs.insert(transaction.productID)
                await transaction.finish()
                
            case .unverified(let transaction, let error):
                print("⚠️ Unverified transaction for \(transaction.productID): \(error)")
            }
        }
        
        self.purchasedProductIDs = newPurchasedIDs
        self.areEntitlementsLoaded = true
        
    }
    
    func hasAccess(to productID: String) -> Bool {
        return purchasedProductIDs.contains(productID)
    }

    nonisolated func paymentQueue(_ queue: SKPaymentQueue,
                                  shouldAddStorePayment payment: SKPayment,
                                  for product: SKProduct) -> Bool {
        return true
    }
}
