//
//  Bookmarks.swift
//  BookStore_Bruno
//
//  Created by BRUNO VASCONCELOS on 20/12/2020.
//

import Foundation

class Bookmarks {
    
    let defaults = UserDefaults.standard
    var tempArray = [String]()
    var bookKey = "bookmarkArray"
    
    func getBookmarkList() -> [String] {
        return defaults.object(forKey: bookKey) as? [String] ?? [String]()
    }
    
    func addBookmark(_ bookmark: String) {
        if let temp =  defaults.object(forKey: bookKey) as? [String] {
            if !temp.contains(bookmark) {
                tempArray = temp
                tempArray.append(bookmark)
                defaults.set(tempArray, forKey: bookKey)
            }
        } else {
            tempArray.append(bookmark)
            defaults.set(tempArray, forKey: bookKey)
        }
    }
    
    func removeBookmark(_ bookmark: String) {
        if let temp =  defaults.object(forKey: bookKey) as? [String] {
            if temp.contains(bookmark) {
                tempArray = temp.filter{ $0 != bookmark }
                defaults.set(tempArray, forKey: bookKey)
            }
        }
    }
    
}
