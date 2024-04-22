//
//  UserInfo.swift
//  BasicStorage
//
//  Created by Brenda Sugey Vega Contreras on 4/20/24.
//
//  UserInfo - used to store and load user input in User Info tab.

import SwiftUI

struct UserInfo: View {
    @State private var storedData = ""
    
    // Function to store user input
    func save(data: String){
        UserDefaults.standard.set(data, forKey: "key")
        print("Saved string: " + data.description)
    }
    
    //Function to load stored data
    func load(){
        // Ask for value with the key "key"
        let curData = UserDefaults.standard.string(forKey: "key")
        // If no value found with that key
        if (curData == nil){
            self.storedData = "No data in memory"
        }
        // Else display the value associated with that key
        else{
            self.storedData = curData!
        }
    }
    
    
    //Function to delete from storage
    func delete(){
        DispatchQueue.main.async{
            UserDefaults.standard.removeObject(forKey: "key")
            print ("Deleted string from local storage")
        }
    }
    
    var body: some View {
        VStack {
            Form{
                // Saves data
                TextField("Enter any text", text: self.$storedData)
                Button(action: {
                    self.save(data: self.storedData)
                }, label: {
                    Text("Save to local storage")
                        .bold()
                })
                
                // Loads data
                Button(action: {
                    self.load()
                }, label: {
                    Text("Load from local storage")
                        .bold()
                })
                
                // Removes data
                Button(action: {
                    self.delete()
                }, label: {
                    Text("Delete from local storage")
                        .foregroundColor(.red)
                })
            }           
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    UserInfo()
}
