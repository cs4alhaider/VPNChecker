//
//  VPNCheck.swift
//  VPNChecker
//
//  Created by 16Root19 on 22/12/2022.
//

import Foundation
import Defaults

struct VPNModel: Codable, Identifiable, Equatable {
    let id: String
    let value: String
    var isVPNProtocol: Bool
}

class VPNCheck: ObservableObject {
    
    @Published var vpnConnected: Bool = false
    @Published var list: [VPNModel] = []
    @Default(.vpnProtocolsKeysIdentifiers) var vpnProtocolsKeysIdentifiers
    
    static let shared = VPNCheck()
    
    private init() { }
    
    func checkVPN() {
        let cfDict = CFNetworkCopySystemProxySettings()
        let nsDict = cfDict!.takeRetainedValue() as NSDictionary
        guard let list = nsDict["__SCOPED__"] as? [String: Any] else { return }
        var listModel: [VPNModel] = []
        
        list.forEach { (key: String, value: Any) in
            let new: VPNModel = .init(id: key, value: "\(value)", isVPNProtocol: false)
            listModel.append(new)
        }
        
        print(listModel)
        
        self.list = listModel
        vpnConnected = vpnConnected()
    }
    
    func addNewVPNProtocol(_ key: String) {
        if !vpnProtocolsKeysIdentifiers.contains(key) {
            vpnProtocolsKeysIdentifiers.append(key)
        }
    }
    
    func removeVPNProtocol(key: String) {
        if vpnProtocolsKeysIdentifiers.contains(key) {
            if let index = vpnProtocolsKeysIdentifiers.firstIndex(where: { $0 == key }) {
                vpnProtocolsKeysIdentifiers.remove(at: index)
            }
        }
    }
    
    func vpnConnected(keys: [String]? = nil) -> Bool {
        let vpnProtocolsKeysIdentifiers = keys ?? vpnProtocolsKeysIdentifiers
        
        // Checking for tunneling protocols in the keys
        for item in list {
            for protocolId in vpnProtocolsKeysIdentifiers where item.id == protocolId {
                // we can use start(with:), to cover also `ipsec4`, `ppp0`, `utun0` etc...
                if let index = list.firstIndex(where: { $0 == item }) {
                    var changedItem = item
                    changedItem.isVPNProtocol = true
                    list[index] = changedItem
                }
                return true
            }
        }
        return false
    }
}
