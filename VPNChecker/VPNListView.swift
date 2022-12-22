//
//  VPNListView.swift
//  VPNChecker
//
//  Created by 16Root19 on 22/12/2022.
//

import SwiftUI
import Defaults

struct VPNListView: View {
    @StateObject private var vm: VPNCheck = .shared
    @State private var share = false
    @Default(.vpnProtocolsKeysIdentifiers) var vpnProtocolsKeysIdentifiers
    
    var body: some View {
        List(vpnProtocolsKeysIdentifiers, id: \.self) { key in
            VStack(alignment: .leading) {
                Text(key)
                    .fontDesign(.monospaced)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    share.toggle()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                .sheet(isPresented: $share) {
                    ActivityView(items: [saveAndGetURL()])
                }
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveAndGetURL() -> URL {
        let str = vpnProtocolsKeysIdentifiers.joined(separator: "\n")
        let filename = getDocumentsDirectory().appendingPathComponent("VPN-List.txt")
        try? str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        return filename
    }
}

struct VPNListView_Previews: PreviewProvider {
    static var previews: some View {
        VPNListView()
    }
}
