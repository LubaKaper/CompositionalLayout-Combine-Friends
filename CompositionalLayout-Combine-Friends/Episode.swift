//
//  Episode.swift
//  CompositionalLayout-Combine-Friends
//
//  Created by Liubov Kaper  on 8/25/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation

struct Episode: Decodable, Hashable {
    let name: String
    let season: Int
    let number: Int
    let summary: String
    let image: Image
}
struct Image: Decodable, Hashable {
    let medium: String
}
