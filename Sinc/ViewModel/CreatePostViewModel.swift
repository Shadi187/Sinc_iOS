//
//  CreatePostViewModel.swift
//  Sinc
//
//  Created by shadi bou zin eddin on 05/01/1446 AH.
//

import Foundation
import Combine
import SwiftUI
import _PhotosUI_SwiftUI


enum sendingPosState{
    case writing
    case loading
    case finished
    case error
}

class CreatePostViewModel:ObservableObject{
    
    @Published var stateOfUpload:sendingPosState = .writing
    @Published var captionText:String = ""
    @Published var captionValid:Bool = false // input should be 1 for this to be true
    @Published var image:Image? = nil
    @Published var pickedImage:PhotosPickerItem? = nil
    @Published var showPhotoPicker:Bool = false
    @Published var savedData:Data? = nil
    @Published var isInputsValid:Bool = false
    @Published private var isPhotoValid: Bool = false
    
    private var cancellablesSet = Set<AnyCancellable>()
    


    
    init() {
        $captionText
            .map{ char in
                return char.count > 1
            }
            .assign(to: \.captionValid, on:self)
            .store(in: &cancellablesSet)
        
        
        Publishers.CombineLatest($isPhotoValid,$captionValid)
            .map{ isPValid,isCValid in
                return (isPValid && isCValid)
            }
            .assign(to: \.isInputsValid , on:self)
            .store(in: &cancellablesSet)
            
    }
    
    
    func addPhoto() {}
    
    func deletePhoto() {}
    
    func emptyInputs() {
        captionText.removeAll()
        nilThePhoto()
    }
    
    func limitText(_ upper: Int) {
            if captionText.count > upper {
                captionText = String(captionText.prefix(upper))
            }
        }
    
    
    func togglePhotoBool() {
        self.isPhotoValid.toggle()
    }
    
    
    func showCharCount() {
        print(captionText)
    }

    
    func changeBool(){
        if !showPhotoPicker {
            self.showPhotoPicker = true
        }
    }
    
    func nilThePhoto(){
        self.pickedImage = nil
        self.savedData = nil 
    }
    
//    func downMock()async {
//        do{
//        try await SupabaseManager.instance.mockDownload()
//        }catch{
//            print(error.localizedDescription)
//        }
//    }
    
    func mockUpload(img:Data)async {
        do{
            try await SupabaseManager.instance.createPost(userId: "fad677ad-8ab2-4338-babe-6557b436254f", content: captionText, img: img)
            emptyInputs()
        }catch{
            print(error)
        }
    }
    
    func mockDown()async {
        do{
            try await SupabaseManager.instance.mockDownload(path:"uploads/DAD3825A-B433-43DB-A476-95E16D94E57D")
        }catch{
            print(error.localizedDescription)
        }
    }
}
