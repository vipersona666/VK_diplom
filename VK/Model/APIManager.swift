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
        let task = session.dataTask(with: url! ) { data, response, error in
            let rickMortiData: RickMortiData
//            defer {
//                DispatchQueue.main.async {
//                    completion(.success(rickMortiData))
//                }
//            }
            if let error {
                print(error)
                completion(.failure(NetworkError.badResponse))
                return
            }
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                print("Status code != 200")
                completion(.failure(NetworkError.badResponse))
                return
            }
            guard let data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            do {
                
                rickMortiData = try JSONDecoder().decode(RickMortiData.self, from: data)
                completion(.success(rickMortiData))
 
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
   
    }

}
