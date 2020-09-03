//
//  SearchBar.swift
//  teenWork
//
//  Created by CJ Wheelan on 4/15/20.
//  Copyright © 2020 CJ Wheelan. All rights reserved.
//

import Foundation
import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text : String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text : String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            // searchBar.text = nil
            
            searchBar.resignFirstResponder()
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.endEditing(true)
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            
            searchBar.setShowsCancelButton(true, animated: true)
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            searchBar.resignFirstResponder()
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.endEditing(true)
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        
        searchBar.delegate = context.coordinator
        searchBar.barStyle = .default
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}
