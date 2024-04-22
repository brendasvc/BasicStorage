//
//  FileManager.swift
//  BasicStorage
//
//  Created by Brenda Sugey Vega Contreras on 4/20/24.
//
//  FileManagement - used to store and load an image downloaded from a URL in File Management tab.

import SwiftUI
import UIKit

struct FileManagement: View {
    // Default image to be downloaded
    @State private var storedImg: UIImage?
    @State private var imageURL = "https://hips.hearstapps.com/ghk.h-cdn.co/assets/16/08/gettyimages-530330473.jpg?crop=0.659xw:0.990xh;0.123xw,0.00779xh&resize=980:*"
    
    // Function used to download data from URL
        func downloadImageData(from url: URL, completion: @escaping(Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                completion(data, response, error)
            }.resume()
        }
    
    // Function to download an image from URL
    func downloadImage(){
        let imageUrl = URL(string: self.imageURL)!

        self.downloadImageData(from: imageUrl) { data, response,error in
            guard let data = data, error == nil else{return}
    
        do{
            self.storedImg = UIImage(data: data)
        }
        catch{
                print ("error" + error.localizedDescription)
                return
            }
        }
    }
    
    // Save image to directory
    func saveImageToDirectory(){
        // Create directory path
        let dir_path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("directory", isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: dir_path.path){
            do{
                try FileManager.default.createDirectory(atPath: dir_path.path, withIntermediateDirectories: true, attributes: nil)
                print("Success")
            }
            catch {
                print("Error creating user directory" + error.localizedDescription)
            }
        }
        
        let img_dir = dir_path.appendingPathComponent("image.png")
        
        // Save image to path called dir_path
        do{
            print(dir_path)
            try self.storedImg?.pngData()?.write(to: img_dir)
            print ("Saved image")
        }
        catch{
            print("Some error" + error.localizedDescription)
        }
    }
    
    // Function to load saved image from directory
    func loadImagedFromDirectory(){
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imagePath = path
            .appendingPathComponent("directory")
            .appendingPathComponent("image.png")
        self.storedImg = UIImage(contentsOfFile: imagePath.path)
        print("Image loaded")
    }
    
    func deleteImage(){
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("directory")
            
        let imagePath = path.appendingPathComponent("image.png")
        
        do{
            try FileManager.default.removeItem(atPath: imagePath.path)
            print ("Removed image")
        }
        catch{
            print("Failed to remove image" + error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack{
            // If image stored, display it
            if(self.storedImg != nil){
                Image(uiImage: self.storedImg!)
                    . resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Form{
                TextField("Enter image URL", text:self.$imageURL)
                
                // Download image
                Button(action: {
                    self.downloadImage()
                }, label: {
                    Text("Download image from URL")
                })
                
                // Save image
                Button(action: {
                    self.saveImageToDirectory()
                }, label: {
                    Text("Save this image")
                })
                
                // Load image
                Button(action: {
                    self.loadImagedFromDirectory()
                }, label: {
                    Text("Load image")
                })
                
                // Deletes image
                Button(action: {
                    self.deleteImage()
                }, label: {
                    Text("Delete image")
                        .foregroundColor(.red)
                })
            }.scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    FileManagement()
}
