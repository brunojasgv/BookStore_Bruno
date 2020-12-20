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

protocol VolumeViewModelType {
    func fetchBooks(name: String)
    var delegate: VolumeViewModelDelegate? { get set }
}

protocol BooksViewModelType: VolumeViewModelType {
    var books: [BookModel] { get }
}

class VolumeViewModel: BooksViewModelType {
    
    var books: [BookModel] = []
    let dataSource: BooksDataSourceType
    weak var delegate: VolumeViewModelDelegate?
    
    init(dataSource: BooksDataSourceType) {
        self.dataSource = dataSource
    }
    
    func fetchBooks(name: String) {
        delegate?.willLoadData()
        dataSource.fetchBooks(name: name) { result in
            switch result {
            case .failure:
                self.delegate?.loadDataError()
            case .success(let data):
                self.books = data.items ?? []
                self.delegate?.didLoadData()
            }
        }
    }
}
