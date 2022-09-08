//
//  RepositoryMobile.swift
//  Exitek intership
//
//  Created by Dmitrij Meidus on 08.09.22.
//

import Foundation

protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}

struct Mobile: Hashable {
    let imei: String
    let model: String
}

enum MobileStorageErrors: Error{
    case objectDoesNotUnique
    case objectDoesNotExist
}

///Son of MobileStorage
class MobileStorageImpl: MobileStorage {
    var items = Set<Mobile>()
    func getAll() -> Set<Mobile>{return items}
    
    func findByImei(_ imei: String) -> Mobile?{
        return items.first(where: {$0.imei == imei} )
    }
    
    func save(_ mobile: Mobile) throws -> Mobile{
        if (items.contains(where: {$0.imei == mobile.imei})){
            throw MobileStorageErrors.objectDoesNotUnique
        }
        items.insert(mobile)
        return mobile
    }
    
    func delete(_ product: Mobile) throws{
        if (exists(product)){
            items.remove(product)
        } else {
            throw MobileStorageErrors.objectDoesNotExist
        }
    }

    func exists(_ product: Mobile) -> Bool{
        return items.contains(product)
    }
}
