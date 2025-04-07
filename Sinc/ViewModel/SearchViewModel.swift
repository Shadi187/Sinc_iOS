//
//  SearchViewModel.swift
//  Sinc
//
//  Created by boshFbt on 27/06/2024.
//

import Foundation
import SwiftUI


final class SearchViewModel:ObservableObject{
    @Published var searchText:String = ""
    @Published var listOfUsers:[User] = []
    
    @MainActor func searchInDataBase()async throws{
        if searchText.isEmpty{
            listOfUsers.removeAll()
            return
        }
        
        self.listOfUsers = try await SupabaseManager.instance.realSearchUsers(text: searchText)
        
    }
    
    @MainActor func getImage(url:String) async->UIImage?{
        await ImageManager.instance.fetchData(url: url)
    }
}



