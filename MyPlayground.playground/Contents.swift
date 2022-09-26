import UIKit

// Implement mobile phone storage protocol
// Requirements:
// - Mobiles must be unique (IMEI is an unique number)
// - Mobiles must be stored in memory


protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
    }

struct Mobile: Hashable, Codable {
    
    static func == (lhs: Mobile, rhs: Mobile) -> Bool {
        return lhs.imei == rhs.imei
       }

       func hash(into hasher: inout Hasher) {
           hasher.combine(imei)
       }
    
    let imei: String
    let model: String
}

private let mobileDataKey = "mobile"

do {
    let mobileData = try JSONEncoder().encode(Mobile(imei: "", model: ""))
    UserDefaults.standard.set(mobileData, forKey: mobileDataKey)
} catch {
    print(error.localizedDescription)
}

if let mobileData = UserDefaults.standard.data(forKey: mobileDataKey) {
    do {
        let mobileObject = try JSONDecoder().decode(Mobile.self, from: mobileData)
        print(mobileObject.imei)
        print(mobileObject.model)
    } catch {
        print(error.localizedDescription)
    }
}

