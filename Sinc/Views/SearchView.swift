//
//  SwiftUIView.swift
//  Sinc
//
//  Created by boshFbt on 19/06/2024.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var vm = SearchViewModel()
    @State var notdhing = false
    var body: some View {
        ZStack {
            Color.theme.ashGray.ignoresSafeArea()
            VStack {
                HStack {
                    Text("Search")
                        .bold()
                        .font(.title)
                        .padding()
                    Spacer()
                }
                TextField("Search..", text: $vm.searchText)
                    .modifier(TextFieldViewModifier(condition: $notdhing))
                    .onChange(of: vm.searchText) { _,_ in
                        Task{
                            try await vm.searchInDataBase()
                        }
                        
                    }
                VStack{
                    ForEach(vm.listOfUsers){ user in
                        NavigationLink {
//                            AccountView(name:user.username,img:user.imgUrl ?? "", user: <#User#>)
                        } label: {
                            EachUser(img: UIImage(named:"ProfileDef")!, name: user.username, url: user.imgUrl ?? "")
                                .padding(.leading)
                        }

                        
                    }
                }
                
                Spacer()
                
                
            }
            
        }
    }
}

#Preview {
    SearchView()
}



/*
 
 ZStack {
     RoundedRectangle(cornerRadius: 25)
     .foregroundStyle(Color.white)
     .frame(width:(UIScreen.current?.bounds.width)! * 0.88, height: 40)
     
     HStack {
         HStack{
             Image(systemName:"magnifyingglass")
                 .foregroundStyle(Color.gray)
             Text("Search")
                 .font(.subheadline)
                 .foregroundStyle(Color.gray)
         }.padding(.leading)
          .padding(.leading)
         
//                            .padding(EdgeInsets()
         Spacer()
     }
 }
 */
