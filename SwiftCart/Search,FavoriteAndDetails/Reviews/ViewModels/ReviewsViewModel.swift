//
//  ReviewsViewModel.swift
//  SwiftCart
//
//  Created by Ramez Hamdi Saeed on 13/06/2024.
//

import Foundation

class ReviewsViewModel{
    var reviews : [Review] = [Review]()
    func getReviewsForProduct(){
       reviews = ReviewsRepos.shared.getReviewsForProduct()
    }}
