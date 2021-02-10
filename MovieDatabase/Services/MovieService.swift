//
//  MovieService.swift
//  MovieDatabase
//
//  Created by Piotr Furmanski on 10/02/2021.
//

import Foundation

enum ServiceError: Error {
    case emptyData
}


protocol MovieServiceProtocol: AnyObject {
    func getList(for title: String, completion: @escaping (Result<[MovieModel], Error>) -> Void)
    func getDetails(for id: String, completion: @escaping (Result<MovieDetailsModel, Error>) -> Void)
}

class MovieServiceService: MovieServiceProtocol {
    private struct Constansts {
        static let baseUrl = "http://www.omdbapi.com/?apikey=b9bd48a6"
        struct Endpoints {
            static let list = "&type=movie&s="
            static let detail = "6&i="
        }
    }
    
    func getList(for title: String, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        guard let strUrl = "\(Constansts.baseUrl)\(Constansts.Endpoints.list)\(title)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: strUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(ServiceError.emptyData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(SearchResponseModel.self, from: data)
                
                completion(.success(response.result))
                
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDetails(for id: String, completion: @escaping (Result<MovieDetailsModel, Error>) -> Void) {
        guard let url = URL(string: "\(Constansts.baseUrl)\(Constansts.Endpoints.detail)\(id)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(ServiceError.emptyData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let details = try decoder.decode(MovieDetailsModel.self, from: data)
                completion(.success(details))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}


