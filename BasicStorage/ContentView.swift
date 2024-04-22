//
//  ContentView.swift
//  BasicStorage
//
//  Created by Brenda Sugey Vega Contreras on 4/19/24.
//
//  HW2 - Basic Storage
//
//  This app was implemented to test two different storage approaches : UserDefaults and FileManager.
//  This app uses three different views to store 3 different type of data:
//      1. ContentView - used to store and load data related to dark mode.
//      2. UserInfo - used to store and load user input in User Info tab.
//      3. FileManagement - used to store and load an image downloaded from a URL in File Management tab.

import SwiftUI

struct ContentView: View {
    // Shared background color for both tabs
    @State private var darkMode = false
    @State private var color = Color.orange
    
    // Function to load mode
    func loadMode(){
        let curMode = UserDefaults.standard.string(forKey: "mode")
        // If value not found for that key, set disable darkMode
        if (curMode == nil){
            self.darkMode = false
        }
        // Else display the value associated with that key
        else{
            self.darkMode = (curMode! as NSString).boolValue
        }
    }
    
    // The body of this view encompases the view of two tabs
    var body: some View {
        VStack {
            Toggle(isOn: $darkMode, label: {
                Text("Dark Mode")
            })
            .onChange(of: darkMode){
                // Update color on change
                color = darkMode ? Color.gray : Color.orange
                UserDefaults.standard.set(darkMode, forKey: "mode")
            }
            .padding(20.0)
            
            TabView{
                // This first view is for user defaults
                UserInfo()
                    .background(color)
                    .tabItem {
                        Image(systemName: "person")
                        Text("User Info")
                    }
                // This second view is for file management (load, save images)
                FileManagement()
                    .background(color)
                    .tabItem {
                        Image(systemName: "photo.badge.arrow.down")
                        Text("File Management")
                    }            
            }
        }
        .onAppear{
            loadMode()
        }
    }
}

#Preview {
    ContentView()
}
