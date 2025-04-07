//
//  CreatePostView.swift
//  Sinc
//
//  Created by shadi bou zin eddin on 04/01/1446 AH.
//

import SwiftUI
import Combine
import _PhotosUI_SwiftUI

struct CreatePostView: View {
    
    @State private var textt:String = "fad"
    @State private var cond:Bool = false
    @State private var condForDef = false
    @State private var thereIsNoPic = false
    
    @StateObject var vm = CreatePostViewModel() 
    
    var body: some View {
        ZStack{
            Color.theme.ashGray.ignoresSafeArea()
            
            //Background for the content of this page
            bg
            
            VStack{
                addPhotoSection
                    .onTapGesture {
                        if !condForDef {
                            condForDef.toggle()
                        }
                    }
                    .confirmationDialog("Press", isPresented: $condForDef){
                        Button("Add Picture") { vm.changeBool() }
                        Button("Delete Photo") { vm.nilThePhoto()}.disabled(thereIsNoPic)
                }
                    .padding(.bottom,70)
                
                texField
                
                HStack{
                    Spacer()
                    
                    charCount
                        
                    
                    
                }.padding(.top,70)
                    
                    
                button
                    .disabled(!vm.isInputsValid)
                    
            }
        }
    }
}

#Preview {
    CreatePostView()
}

extension CreatePostView{
    var bg: some View {
        VStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.theme.lightAshGray)
                .frame(height: (UIWindow.current?.screen.bounds.height)!*0.78)
            
        }
    }
    
    var texField: some View {
        TextField("Caption.. ", text: $vm.captionText,axis:.vertical)
            
                .modifier(CaptionTextFieldModifier(condition: $cond))
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                
                
//            Text(vm.captionText)
//                .opacity(0)
        
            
//                    .onReceive(Just(vm.captionText)){ _ in vm.limitText(10) }

            
    }
    
    var charCount: some View {
        Text("\(vm.captionText.count) Character Remaining")
            
            .foregroundStyle(Color.gray)
            .padding(.trailing)
            .lineLimit(nil)
    }
    
    var button: some View  {
        Button(action: {
            Task{
                print(vm.savedData != nil)
                await vm.mockUpload(img:vm.savedData!)
            }
        }, label: {
            RoundedRectangle(cornerRadius: 10)
                .modifier(ButtonViewModifier(text: "Share"))
        })
    }
    
    var addPhotoSection: some View {
        ZStack {
                
//            PhotosPicker(isPresented: ,selection:$vm.pickedImage , photoLibrary: .shared(), label:{
//                RoundedRectangle(cornerRadius: 10)
//                    .foregroundStyle(Color.theme.ashGray)
//                    .frame(width:280,height:230)} )
            
                    
            if vm.savedData != nil {
                thereIsImage
                    
                        
            }else {
                thereIsNoImage
                    .photosPicker(isPresented: $vm.showPhotoPicker, selection: $vm.pickedImage, photoLibrary:.shared() )
                    .onChange(of:vm.pickedImage){ _,_ in
                        Task{
                            if let loadedData = try? await vm.pickedImage?.loadTransferable(type: Data.self){
                                vm.savedData = loadedData
                                vm.togglePhotoBool()
                            }else {
                                print("ERROR")
                            }
                        }
                    }

                
            }
        }
    }
    
    var thereIsNoImage: some View{
        RoundedRectangle(cornerRadius: 10)
            .frame(width:260,height:210)
            .opacity(0.5)
            .overlay(
                Image(systemName: "camera.fill")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.theme.lightAshGray)
            )
    }
    
    var thereIsImage: some View {
        
        if let data = vm.savedData {
            RoundedRectangle(cornerRadius: 10)
                .frame(width:260,height:210)
                .overlay(
                    Image(uiImage: UIImage(data:data)!)
                        .resizable()
                        .overlay(
                            Image(systemName: "camera.fill")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.theme.lightAshGray)
                                
                            ,alignment: .bottomTrailing
                        )
                )
        }
        else {
        RoundedRectangle(cornerRadius: 10)
            .frame(width:260,height:210)
            .overlay(
                Image("PostPic")
                    .resizable()
                    .overlay(
                        Image(systemName: "camera.fill")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.theme.lightAshGray)
                            
                        ,alignment: .bottomTrailing
                    )
            )
            
        }
    }
    
    var photoPick: some View {
        PhotosPicker(selection:$vm.pickedImage , photoLibrary: .shared(), label: {
            Text((vm.pickedImage != nil) ? "Change Image" : "Add Image" )
        })
    }
}


/*

 - ADD THE PHOTO
    .user press the add picture
    .user add the picture
    .the photo in the add photo section changes
 
 */
