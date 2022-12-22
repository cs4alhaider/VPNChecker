//
//  ContentView.swift
//  VPNChecker
//
//  Created by Abdullah Alhaider on 21/12/2022.
//

import SwiftUI
import Defaults

struct ContentView: View {
    @StateObject private var vm: VPNCheck = .shared
    
    var body: some View {
        NavigationStack {
            VStack {
                Label(vm.vpnConnected ? "VPN is connected" : "VPN NOT connected", systemImage: "globe")
                    .imageScale(.large)
                    .foregroundColor(vm.vpnConnected ? .green : .gray)
                    .padding()
                List {
                    Section {
                        ForEach(vm.list) { item in
                            NavigationLink(destination: ProtocolDetailView(vpn: item)) {
                                VStack(alignment: .leading) {
                                    Text(item.id)
                                        .fontDesign(.monospaced)
                                    Text(item.isVPNProtocol ? "VPN protocol (listed)" : "Unlisted protocol")
                                        .foregroundColor(item.isVPNProtocol ? .green : .gray)
                                        .font(.footnote)
                                }
                            }
                        }
                    } footer: {
                        NavigationLink(destination: VPNListView()) {
                            HStack {
                                Spacer()
                                Text("See all saved VPN list")
                                    .bold()
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    
                }
            }
            .onAppear(perform: vm.checkVPN)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
