//
//  EditMembet.swift
//  LibraryProject
//
//  Created by Hanjaya Putra Wijangga on 18/12/22.
//

import Foundation
import SwiftUI

struct EditMember: View {
    @State private var Username: String = ""
    @Binding var updateData: Bool
    @Environment(\.managedObjectContext) var moc
    var updateNamaMember: User
    var deletePinjam: StatusPeminjaman
    var body: some View {
        VStack {
           Text("Edit")
            Spacer()
            HStack{
                Text("username = ")
                TextField("enter your usernam", text: $Username)
            }
            Spacer()
            HStack{
                Button("Update") {
                    updateNamaMember.setValue(Username, forKey: "nama_user")
                    try? moc.save()
                    updateData.toggle()
                }
                Button("delete"){
//                    deletePinjam.setValue(true, forKey: "buku_dipinjam")
//                    try? moc.save()
//                    updateData.toggle()
                    moc.delete(deletePinjam)
                    try? moc.save()
                }
            }
        }
        .onAppear{
            Username = updateNamaMember.nama_user ?? "a"
        }
        .padding()
    }
}

