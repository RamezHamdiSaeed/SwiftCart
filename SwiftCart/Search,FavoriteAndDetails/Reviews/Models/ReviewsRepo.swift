//
//  ReviewsRepo.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 13/06/2024.
//

import Foundation

class ReviewsRepos{
    static let shared = ReviewsRepos()
    private init(){}
    let reviews : [Review] = [Review(userName: "John", message: "Excellent"),Review(userName: "Ebrahim", message: "Awesome"),Review(userName: "Micheal", message: "goooood"),Review(userName: "Rowan", message: "Excellent"),Review(userName: "Marwa", message: "not bad"),Review(userName: "Ramez", message: "WoW")]
    
    func getReviewsForProduct()->[Review]{
        return reviews.shuffled()
    }
}
