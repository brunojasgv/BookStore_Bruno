//
//  DetailsViewController.swift
//  BookStore_Bruno
//
//  Created by BRUNO VASCONCELOS on 20/12/2020.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var labelInfo: UILabel!
    var selectedBook: BookModel?
    
    override func viewWillAppear(_ animated: Bool) {
        if let book = selectedBook {
            labelInfo.text = "\(book.title)\n\(book.description)\n \(book.authors)"
            self.checkBookmarked()
        }
    }
    @IBAction func setBookmark(_ sender: Any) {
        _ = Bookmarks().getBookmarkList().contains(where: { $0 == selectedBook?.identifier }) ? Bookmarks().removeBookmark(selectedBook?.identifier ?? ""): Bookmarks().addBookmark(selectedBook?.identifier ?? "")
        self.checkBookmarked()
    }
    
    func checkBookmarked() {
        let btnTitle = Bookmarks().getBookmarkList().contains(where: { $0 == selectedBook?.identifier }) ? "Dislike":"Like"
        let color = Bookmarks().getBookmarkList().contains(where: { $0 == selectedBook?.identifier }) ? UIColor.red:UIColor.green
        btnBookmark.setTitle(btnTitle, for: .normal)
        btnBookmark.setTitleColor(color, for: .normal)
    }

}
