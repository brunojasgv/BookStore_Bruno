//
//  CodableResponse.swift
//  BookStore_Bruno
//
//  Created by BRUNO VASCONCELOS on 19/12/2020.
//

import Foundation

struct BooksResponse<T: Codable>: Codable {
  let data: BooksResults<T>
}

struct BooksResults<T: Codable>: Codable {
  let results: [T]
}

struct ImgurResponse<T: Codable>: Codable {
  let data: T
}
