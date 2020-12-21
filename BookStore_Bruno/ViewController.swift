//
//  ViewController.swift
//  BookStore_Bruno
//
//  Created by BRUNO VASCONCELOS on 18/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var model: BooksViewModelType!
    var selectedBook: BookModel?
    var bookmarkSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = VolumeViewModel(dataSource: BooksDataSource()) // the view model is injected into BooksViewModelType
        model.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model.fetchBooks(name: "ios", bookmarked: bookmarkSelected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            if let details = segue.destination as? DetailsViewController {
                details.selectedBook = self.selectedBook
            }
        }
    }
    
    @IBAction func showBookmarked(_ sender: Any) {
        bookmarkSelected = !bookmarkSelected
        model.fetchBooks(name: "ios", bookmarked: bookmarkSelected)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let book = model.books[indexPath.row]
        if let label = cell.contentView.viewWithTag(1) as?  UILabel {
            label.text = book.title
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedBook = model.books[indexPath.row]
        self.performSegue(withIdentifier: "details", sender: self)
    }
}


// State updates from the view model
extension ViewController: VolumeViewModelDelegate {
    
    func willLoadData() {}
    
    func didLoadData() {
        collectionView.reloadData()
    }
    
    func loadDataError() {}
}

