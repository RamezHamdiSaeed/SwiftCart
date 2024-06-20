//
//  ReviewsRepoTest.swift
//  SwiftCartTests
//
//  Created by Ramez Hamdi Saeed on 19/06/2024.
//

import Foundation
import XCTest
@testable import SwiftCart

final class ReviewsRepoTest: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func  testFetchReviews(){
      let reviews =  ReviewsRepo.shared.getReviewsForProduct()
        XCTAssertTrue(!reviews.isEmpty)
    }
    
}
