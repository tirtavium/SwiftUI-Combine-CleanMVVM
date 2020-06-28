//
//  ContentView.swift
//  CleanMVVM
//
//  Created by Tirta A Gunawan on 22/06/20.
//  Copyright © 2020 iOS Dev Team. All rights reserved.
//

import SwiftUI

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

struct NoteBookView<T>: View where T: NoteBookViewModelObservable & NoteBookViewModelCommand {
    
    @EnvironmentObject var viewModel: T
    
    var body: some View {
        NavigationView {
            MasterView<T>()
                .navigationBarTitle(Text("Master"))
                .navigationBarItems(
                    leading: EditButton(),
                    trailing:
                    NavigationLink(
                        destination: DetailView<T>()
                    ) {
                        Image(systemName: "plus")
                    }
            )
            DetailView<T>()
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
            .onAppear {
                self.viewModel.fetchNotes()
        }.alert(isPresented: $viewModel.showErrorMessage) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct MasterView<T>: View where T: NoteBookViewModelObservable  & NoteBookViewModelCommand {
   @EnvironmentObject var viewModel: T
    
    var body: some View {
        List {
            ForEach(viewModel.dataSource, id: \.self) { model in
                NavigationLink(
                    destination: DetailView<T>(id: model.id)
                    ){
                    Text(model.title)
                }

            }.onDelete { indices in
                indices.forEach {
                    self.viewModel.deleteNote(index: $0)}
            }
        }
    }
}


struct DetailView<T>: View where T: NoteBookViewModelObservable & NoteBookViewModelCommand{
    var id: String?
    @State var textHeight: CGFloat = 150
    @EnvironmentObject var viewModel: T
    var body: some View {
        Group {
            ScrollView {
                TextView(placeholder: "", text: self.$viewModel.note, minHeight: self.textHeight, calculatedHeight: self.$textHeight)
                    .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
            }.onAppear {
                self.viewModel.refreshNoteTo(id: self.id)
            }
        }.navigationBarTitle(Text("Detail"))
            .navigationBarItems(trailing:Button("Save") {
                self.viewModel.saveNote()
            })
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteBookView<NoteBookViewModel>().environmentObject(NoteBookViewModel()
//)
//    }
//}
