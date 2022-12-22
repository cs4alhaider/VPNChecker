//
//  Defaults+Keys.swift
//  VPNChecker
//
//  Created by Abdullah Alhaider on 21/12/2022.
//

import Defaults

extension Defaults.Keys {
    // static let unlistedProtocols = Key<[String]>("unlistedProtocols", default: [])
    static let vpnProtocolsKeysIdentifiers = Key<[String]>("vpnProtocolsKeysIdentifiers", default: [
        "tap", "tun", "ppp", "ipsec", "ipsec0", "utun", "ipsec"
    ])
}
