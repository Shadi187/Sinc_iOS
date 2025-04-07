//
//  ImageManager.swift
//  Sinc
//
//  Created by boshFbt on 26/06/2024.
//
import Foundation
import SwiftUI
import _PhotosUI_SwiftUI

class ImageManager {
   static let instance = ImageManager()
    
    @MainActor func fetchData(url:String) async -> UIImage? {
       let location = URL(string:url)
//       var data:Data?
//       var convertedImg:UIImage? = nil
        if let location {
            do {
                let conv = try await URLSession.shared.data(from: location)
                return UIImage(data: conv.0)
            }catch{ print(error.localizedDescription)}
            
        }
       
       return nil
   }
    
    
    
    
    
    
    func convertImagePreview(img:PhotosPickerItem) async -> UIImage? {
        Task{
        if let data = try? await img.loadTransferable(type: Data.self){
                if let uiImg = UIImage(data: data){
                    return uiImg
                }
        }else {
        
        }
            return UIImage(named:"Paracetamol")!
        }
        return nil
    }
    
    
    
}

/*
 //               data = try Data(contentsOf: location)
 //               if let data {
 ////                   print("THERE IS DATA HERE!")
 //                   convertedImg = UIImage(data: data)
 //               }else {
 ////                   print("DATA IS NIL")
 //                   return nil
 //               }
 
 */
//URLSESS
