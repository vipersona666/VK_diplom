//
//  RickMortiData.swift
//  VK
//
//  Created by Andrei on 04.08.2023.
//
//Структура данных из сети
struct RickMortiData: Decodable {
    let results: [Hero]
    struct Hero: Decodable {
        var id: Int
        var name: String
        var image: String
        var status: String
    }
}






