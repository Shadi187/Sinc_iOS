//
//  CoredataManager.swift
//  Sinc
//
//  Created by boshFbt on 21/06/2024.
//
//
//import Foundation
//import CoreData
//import Security
//
//final class CoreDataManager {
//    
//    static let instance = CoreDataManager()
//    
//    @Published var savedAccount:[Account] = []
//    
//    let container:NSPersistentContainer
//    
//    init(){
//        container = NSPersistentContainer(name: "SavedUser")
//        container.loadPersistentStores { (Description, Error )in
//            if let error = Error{
//                fatalError("Error In Generating Data")
//            }else {
//                print("Loaded Successfully")
//            }
//        }
//        
////        self.savedAccount = getUserCred().first!
//    }
//    
//    func getUserCred() -> [Account] {
//        let request = NSFetchRequest<Account>(entityName:"Account")
////        let Acc:[Account] = Account()
//        do {
////            Acc = try container.viewContext.fetch(/*request*/)
//            savedAccount = try container.viewContext.fetch(request)
//            return savedAccount
//        }catch{
//            print("ERROR IN GENERATING DATA")
//            return []
//        }
//    }
//}
