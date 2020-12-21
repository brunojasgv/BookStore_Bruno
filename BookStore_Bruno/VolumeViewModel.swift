//
//  VolumeViewModel.swift
//  BookStore_Bruno
//
//  Created by BRUNO VASCONCELOS on 20/12/2020.
//

import Foundation

protocol VolumeViewModelDelegate: class {
    func willLoadData()
    func didLoadData()
    func loadDataError()
}

//separation of concerns
protocol VolumeViewModelType {
    func fetchBooks(name: String, bookmarked: Bool)
    var delegate: VolumeViewModelDelegate? { get set }
}

protocol BooksViewModelType: VolumeViewModelType {
    var books: [BookModel] { get }
}

class VolumeViewModel: BooksViewModelType {
    
    var books: [BookModel] = []
    var bm = false
    let dataSource: BooksDataSourceType
    weak var delegate: VolumeViewModelDelegate?
    
    init(dataSource: BooksDataSourceType) {
        self.dataSource = dataSource
    }
    
    func fetchBooks(name: String, bookmarked: Bool) {
        delegate?.willLoadData()
        dataSource.fetchBooks(name: name) { result in
            switch result {
            case .failure:
                self.delegate?.loadDataError()
            case .success(let data):
                let bookmarkedArray = Bookmarks().getBookmarkList()
                self.books = bookmarked ? (data.items?.filter({bookmarkedArray.contains($0.identifier) == true}) ?? []):(data.items ?? [])
                self.delegate?.didLoadData()
            }
        }
    }
}
