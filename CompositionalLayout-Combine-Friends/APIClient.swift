//
//  APIClient.swift
//  CompositionalLayout-Combine-Friends
//
//  Created by Liubov Kaper  on 8/25/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation
import Combine


class APIClient {
    
    public func getEpisodes() -> AnyPublisher<[Episode], Error> {
        let endPoint = "https://api.tvmaze.com/shows/431/episodes"
        
        let url = URL(string: endPoint)!
        
       return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Episode].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
