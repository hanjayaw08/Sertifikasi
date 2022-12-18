//
//  AdminView.swift
//  LibraryProject
//
//  Created by Hanjaya Putra Wijangga on 18/12/22.
//

import Foundation
import SwiftUI
import CoreData

struct AdminView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var statusPeminjaman: FetchedResults<StatusPeminjaman>
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    @State private var showingSheet = false
    @State private var showingSheet1 = false
    @State private var showingSheet2 = false
    @State private var isUpdate = false
    @State var bukuDipinjam: [StatusPeminjaman] = []
    @State var umpanData = []
    @State var simpanROw: Int = 0
    let formatter1 = DateFormatter()

    var body: some View {
        VStack{
            HStack{
                Button("Add buku") {
                           showingSheet.toggle()
                       }
                       .sheet(isPresented: $showingSheet) {
                           TambahBuku()
                       }
                Spacer()
                    Text("Daftar Pinjaman")
                        .font(.title)
                Spacer()
                Button("Add Pinjam") {
                           showingSheet1.toggle()
                       }
                       .sheet(isPresented: $showingSheet1) {
                           EditView( isUpdate: $isUpdate)
                       }
            }
            List{
                ForEach(0 ..< bukuDipinjam.count, id: \.self){ i in
                    Button(action: {
                               simpanROw = i
                        showingSheet2.toggle()
                            }) {
                                HStack{
                                    Image(uiImage: statusPeminjaman[i].catalog?.content ?? UIImage())
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                    Spacer()
                                    Text(statusPeminjaman[i].catalog?.judul_buku ?? "x")
                                    Spacer()
                                    VStack {
                                        Text(formatter1.string(from: statusPeminjaman[i].tanggal_peminjaman ?? Date.distantPast))
                                            .font(.headline)
                                        Text(formatter1.string(from: statusPeminjaman[i].tanggal_delete ?? Date.distantPast))
                                            .font(.headline)
                                        Text(statusPeminjaman[i].user?.nama_user ?? "x")
                                            .font(.headline)
                                    }
                                }
                            }.buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $showingSheet2) {
                            EditMember(updateData: $isUpdate, updateNamaMember: user[simpanROw], deletePinjam: statusPeminjaman[simpanROw])
                                }
                }
//                .onDelete(perform: removeData)
//                .onDelete {
//                    i in
//                    for index in i {
//                        bukuDipinjam[index].setValue(true, forKey: "buku_dipinjam")
//                        try? moc.save()
//                        isUpdate.toggle()
//                        print(index)
//                    }
//                }
            }
        }
        .onAppear {
            bukuDipinjam = statusPeminjaman.filter({ $0.buku_dipinjam == false })
            formatter1.dateStyle = .short
        }
        .onChange(of: isUpdate) { newValue in
            bukuDipinjam = statusPeminjaman.filter({ $0.buku_dipinjam == false })
            formatter1.dateStyle = .short
            
        }
        .padding()
    }
    func removeData(at offsets: IndexSet) {
        for index in offsets {
            let language = bukuDipinjam[index]
            moc.delete(language)
        }
//        do {
//            try moc.save()
//        } catch {
//            print("error")
//        }
        isUpdate.toggle()
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
