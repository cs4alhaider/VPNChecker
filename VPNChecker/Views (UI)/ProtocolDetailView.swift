//
//  ProtocolDetailView.swift
//  VPNChecker
//
//  Created by 16Root19 on 22/12/2022.
//

import SwiftUI
import Defaults

struct ProtocolDetailView: View {
    let vpn: VPNModel
    @StateObject private var vm: VPNCheck = .shared
    @State private var showAlert: Bool = false
    @Default(.vpnProtocolsKeysIdentifiers) var vpnProtocolsKeysIdentifiers
    
    var body: some View {
        VStack {
            HStack {
                Text(vpn.value)
                    .font(.footnote)
                    .fontDesign(.monospaced)
                    .padding()
                Spacer()
            }
            Spacer()
            Button {
                if vm.vpnProtocolsKeysIdentifiers.contains(vpn.id) {
                    vm.removeVPNProtocol(key: vpn.id)
                } else {
                    vm.addNewVPNProtocol(vpn.id)
                    showAlert.toggle()
                }
            } label: {
                VStack {
                    if vm.vpnProtocolsKeysIdentifiers.contains(vpn.id) {
                        Label("Remove from listed VPN protocol", systemImage: "minus")
                            .foregroundColor(.red)
                    } else {
                        Label("Add this protocol to VPN list", systemImage: "plus")
                    }
                }
                .padding()
            }
            .alert("\(vpn.id) has been added to the list of VPN protocols.", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
        .navigationTitle(vpn.id)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("Copy") {
                    Button("VPN id: \(vpn.id)") {
                        UIPasteboard.general.string = vpn.id
                    }
                    
                    Button("VPN value") {
                        UIPasteboard.general.string = vpn.value
                    }
                }
            }
        }
    }
}

struct ProtocolDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolDetailView(vpn: .init(id: "ipsec6", value: "", isVPNProtocol: true))
    }
}
