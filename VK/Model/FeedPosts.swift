//
//  FeedPosts.swift
//  VK
//
//  Created by Andrei on 13.07.2023.
//

import Foundation

struct PostModel{
    let author: String
    let description: String
    let image: String
    let views: Int
    let likes: Int
    let id: String
}
var posts: [PostModel] = [PostModel(author: "peaky".localized, description: "Британский сериал о криминальном мире Бирмингема 20-х годов прошлого века, в котором многолюдная семья Шелби стала одной из самых жестоких и влиятельных гангстерских банд послевоенного времени. Фирменным знаком группировки, промышлявшей грабежами и азартными играми, стали зашитые в козырьки лезвия.", image: "Peaky", views: Int.random(in: 500..<900), likes: Int.random(in: 0..<900), id: UUID().uuidString), PostModel(author: "peaky".localized, description: "Британский сериал о криминальном мире Бирмингема 20-х годов прошлого века, в котором многолюдная семья Шелби стала одной из самых жестоких и влиятельных гангстерских банд послевоенного времени. Фирменным знаком группировки, промышлявшей грабежами и азартными играми, стали зашитые в козырьки лезвия.", image: "Peaky", views: Int.random(in: 500..<900), likes: Int.random(in: 0..<900), id: UUID().uuidString), PostModel(author: "rick".localized, description: "В центре сюжета - школьник по имени Морти и его дедушка Рик. Морти - самый обычный мальчик, который ничем не отличается от своих сверстников. А вот его дедуля занимается необычными научными исследованиями и зачастую полностью неадекватен. Он может в любое время дня и ночи схватить внука и отправиться вместе с ним в безумные приключения с помощью построенной из разного хлама летающей тарелки, которая способна перемещаться сквозь межпространственный тоннель. Каждый раз эта парочка оказывается в самых неожиданных местах и самых нелепых ситуациях.", image: "rick", views: Int.random(in: 500..<900), likes: Int.random(in: 0..<900), id: UUID().uuidString), PostModel(author: "raised".localized, description: "2145 год. Человечество захлебнулось в кровопролитной войне между верующими и атеистами. Некоторое время спустя на планете Kepler-22b в меру удачно приземляется небольшое судно с двумя андроидами, которые называют друг друга Матерью и Отцом. Их миссия — вырастить из привезённых эмбрионов человеческих детёнышей и воспитать их атеистами.", image: "volf", views: Int.random(in: 500..<900), likes: Int.random(in: 0..<900), id: UUID().uuidString), PostModel(author: "breaking".localized, description: "Школьный учитель химии Уолтер Уайт узнаёт, что болен раком лёгких. Учитывая сложное финансовое состояние дел семьи, а также перспективы, Уолтер решает заняться изготовлением метамфетамина. Для этого он привлекает своего бывшего ученика Джесси Пинкмана, когда-то исключённого из школы при активном содействии Уайта. Пинкман сам занимался варкой мета, но накануне, в ходе рейда УБН, он лишился подельника и лаборатории.", image: "Breaking", views: Int.random(in: 500..<900), likes: Int.random(in: 0..<900), id: UUID().uuidString)]

