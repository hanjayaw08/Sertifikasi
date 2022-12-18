//
//  MemberView.swift
//  LibraryProject
//
//  Created by Hanjaya Putra Wijangga on 18/12/22.
//

import Foundation
import SwiftUI
struct MemberView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var catalog: FetchedResults<Catalog>
    @State var buku: [Catalog] = []
    
//    @State var dummy = ["a" ,"b" ,"c"]
    var body: some View {
        VStack{
            HStack{
                    Text("Catalog")
                        .font(.title)
                Spacer()
            }
            List(catalog) { catalogs in
                    HStack{
                        Image(uiImage: catalogs.content!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        Spacer()
                        Spacer()
                        VStack {
                            Text(catalogs.judul_buku ?? "")
                                .font(.headline)
                        }
                    }
            }
        }
//        .onAppear {
//            buku = catalog.filter({ $0.buku_dipinjam == false })
//        }
        .padding()
    }
}

struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        MemberView()
    }
}
