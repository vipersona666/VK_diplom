//
//  APIManager.swift
//  VK
//
//  Created by Andrei on 04.08.2023.
//

import Foundation

enum NetworkError: Error{
    case badURL, badResponse, badRequest, invalidData
}

class APIManager{
    
    static let shared = APIManager()
    
    private init(){
    }
    
    let urlString = "https://rickandmortyapi.com/api/character"
    
    func getPost(completion: @escaping (Result<RickMortiData, Error>) -> Void) {
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url! ) {data, response, error in
            if let error {
                print(error)
                completion(.failure(NetworkError.invalidData))
            } else {
                //let httpResponse = response as? HTTPURLResponse
               //print(httpResponse!)
                
                guard let data else {
                    return
                }
                do {
                    
                   let rickMortiData = try? JSONDecoder().decode(RickMortiData.self, from: data)
                    completion(.success(rickMortiData!))
                 
                } catch {
                    completion(.failure(NetworkError.invalidData))
                }
            }
        }
        task.resume()
   
    }

}
