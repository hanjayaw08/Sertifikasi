//
//  ContentView.swift
//  LibraryProject
//
//  Created by Hanjaya Putra Wijangga on 18/12/22.
//

import SwiftUI

struct EditView: View {
    @FetchRequest(sortDescriptors: []) var catalog: FetchedResults<Catalog>
    @FetchRequest(sortDescriptors: []) var statuspeminjaman: FetchedResults<StatusPeminjaman>
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    @Environment(\.managedObjectContext) var moc
    
    @State private var NamaBuku = ""
    @State private var NamaMember: String = ""
    @State private var TanggalPengambillan: Date = Date.now
    @State private var TanggalPengembalian: Date = Date.now
    @State var userPick = User()
    @State var bookPick = Catalog()
    @Binding var isUpdate:Bool
    var body: some View {
        VStack {
            HStack{
                Text("Nama buku = ")
                Picker("Please choose a User", selection: $bookPick) {
                    ForEach(catalog, id: \.self) { i in
                        Text(i.judul_buku!)
                            .tag(i)
                        
                    }
                }
            }
            HStack{
                Text("Nama Member = ")
                TextField("Masukan nama member", text: $NamaMember)
                Picker("Please choose a User", selection: $userPick) {
                    ForEach(user, id: \.self) { i in
                        Text(i.nama_user!)
                            .tag(i)

                        
                    }
                }
                .pickerStyle(.menu)
            }

            .pickerStyle(.wheel)

            Button("add User"){
                let namabuku = NamaBuku
                let namamember = NamaMember
                let ambil = Date.now
                let kembali = Date.now.addingTimeInterval(604800)
                let foto = "index1"
                
                
                let isiDataStatpinjam = StatusPeminjaman(context: moc)
                isiDataStatpinjam.buku_dipinjam = false
                isiDataStatpinjam.tanggal_peminjaman = ambil
                isiDataStatpinjam.tanggal_delete = kembali
                isiDataStatpinjam.catalog = bookPick
                if NamaMember != "" {
                    let isiDataUser = User(context: moc)
                    isiDataUser.nama_user = NamaMember
                    isiDataStatpinjam.user = isiDataUser
                } else {
                    isiDataStatpinjam.user = userPick
                }
                isUpdate.toggle()
                try? moc.save()
            }
        }
        .padding()
    }
}

