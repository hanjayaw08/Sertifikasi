//
//  TambahBuku.swift
//  LibraryProject
//
//  Created by Hanjaya Putra Wijangga on 18/12/22.
//

import Foundation
import SwiftUI
import PhotosUI

struct TambahBuku: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var catalog: FetchedResults<Catalog>
    @State private var Username: String = ""
    @State private var Password: String = ""
    @State var selectedItems: [PhotosPickerItem] = []
    @State var data: Data?
    @State private var NamaBuku = ""
    var body: some View {
        VStack {
            if let data = data, let uiimage = UIImage(data: data) {
                Image(uiImage: uiimage)
                    .resizable()
            }
            PhotosPicker(selection: $selectedItems,
                         maxSelectionCount: 1,
                         matching: .images
                         ){
                VStack{
                    Text("Pick Photo")
                    
                }
            }
                         .onChange(of: selectedItems) {newValue in
                             guard let item = selectedItems.first else{
                                 return
                             }
                             item.loadTransferable(type: Data.self) {result in
                                 switch result {
                                 case .success(let data):
                                     if let data = data {
                                         self.data = data
                                     } else {
                                         print("Data is nil")
                                     }
                                 case .failure(let failure):
                                     fatalError("\(failure )")
                                 }
                             }
                         }
            HStack{
                Text("Nama buku = ")
                TextField("Masukan nama buku", text: $NamaBuku)
            }
            
            Button("Submit") {
                            if let data = data {
                                guard let catalogue_image = UIImage(data: data) else { return }
                                let isiDataCatalog = Catalog(context: moc)
                                isiDataCatalog.content = catalogue_image
                                isiDataCatalog.judul_buku = NamaBuku
                                try? moc.save()
                            }
                        }
        }
        .padding()
    }
}

struct TambahBuku_Previews: PreviewProvider {
    static var previews: some View {
        TambahBuku()
    }
}
