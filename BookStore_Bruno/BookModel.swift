//
//  BookModel.swift
//  BookStore_Bruno
//
//  Created by BRUNO VASCONCELOS on 19/12/2020.
//

import Foundation
import Alamofire
import ObjectMapper

enum Result {
    case success(VolumeResponse)
    case failure
}

class BookModel: Mappable {
    var identifier: String!
    var title: String!
    var authors: [String]?
    var description: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        identifier <- map["id"]
        title <- map["volumeInfo.title"]
        authors <- map["volumeInfo.authors"]
        description <- map["volumeInfo.description"]
    }
}

protocol BooksDataSourceType {
    func fetchBooks(name: String, completion: @escaping (_ result: Result) -> Void)
}

class BooksDataSource: BooksDataSourceType {
    
    public func fetchBooks(name: String, completion: @escaping (_ result: Result) -> Void) {
        //check valid input
        guard let parameterString = name.normalizeForSearchParameter(string: name) else {
            return
        }
        AF.request(BooksAPI.volumes(parameterString)).responseJSON { (responce) in
            switch responce.result {
            case .success(let value):
                guard let castingValue = value as? [String: Any] else { return }
                guard let data = Mapper<VolumeResponse>().map(JSON: castingValue) else { return }
                completion(.success(data))
            case .failure:
                completion(.failure)
            }
        }
    }
}

extension String {
    public func normalizeForSearchParameter(string: String) -> String? {
        return string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
