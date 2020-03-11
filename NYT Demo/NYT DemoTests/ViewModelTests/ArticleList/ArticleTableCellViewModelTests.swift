//
//  ArticleTableCellViewModelTests.swift
//  NYT DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
@testable import NYT_Demo

class ArticleTableCellViewModelTests: XCTestCase {
    var viewModel: ArticleTableCellViewModel!
    var article: Article!
    var downloadImageService: DownloadImageServiceMock!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.downloadImageService = DownloadImageServiceMock()
        self.article = self.mockedContent()
        self.viewModel = ArticleTableCellViewModel(content: self.article, downloadImageService: self.downloadImageService)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.downloadImageService = nil
        self.article = nil
        self.viewModel = nil
        super.tearDown()
    }

    func testIdIsNotEmpty() {
            let expectedValue = self.viewModel.id
            XCTAssertFalse(expectedValue.isEmpty)
        }
        
        func testIdIsEmpty() {
            self.article.url = nil
            self.viewModel = ArticleTableCellViewModel(content: self.article, downloadImageService: self.downloadImageService)
            let expectedValue = self.viewModel.id
            XCTAssertTrue(expectedValue.isEmpty)
        }
        
        func testTitleIsNotEmpty() {
            let expectedValue = self.viewModel.title
            XCTAssertFalse(expectedValue.isEmpty)
        }
        
        func testTitleIsEmpty() {
            self.article.title = nil
            self.viewModel = ArticleTableCellViewModel(content: self.article, downloadImageService: self.downloadImageService)
            let expectedValue = self.viewModel.title
            XCTAssertTrue(expectedValue.isEmpty)
        }
        
        func testDateIsNotEmpty() {
            let expectedValue = self.viewModel.date
            XCTAssertFalse(expectedValue.isEmpty)
        }
        
        func testDateIsEmpty() {
            self.article.date = nil
            self.viewModel = ArticleTableCellViewModel(content: self.article, downloadImageService: self.downloadImageService)
            let expectedValue = self.viewModel.date
            XCTAssertTrue(expectedValue.isEmpty)
        }
        
        func testSnippetIsNotEmpty() {
            let expectedValue = self.viewModel.snippet
            XCTAssertFalse(expectedValue.isEmpty)
        }
        
        func testSnippetIsEmpty() {
            self.article.abstract = nil
            self.viewModel = ArticleTableCellViewModel(content: self.article, downloadImageService: self.downloadImageService)
            let expectedValue = self.viewModel.snippet
            XCTAssertTrue(expectedValue.isEmpty)
        }
        
        func testLoadImageSuccess() {
            let expectation = self.expectation(description: #function)
            let expectedImage = UIImage()
            self.viewModel.loadImage { [weak self] (id, response) in
                XCTAssertEqual(id, self?.self.viewModel.id)
                switch response {
                case .success(let image):
                    XCTAssertEqual(expectedImage, image)
                case .failure(let error):
                    XCTAssertNil(error)
                }
                expectation.fulfill()
            }
            self.downloadImageService.completion?(.success(expectedImage))
            wait(for: [expectation], timeout: 0.1)
        }
        
        func testLoadImageFailure() {
            let expectation = self.expectation(description: #function)
            let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
            self.viewModel.loadImage { [weak self] (id, response) in
                XCTAssertEqual(id, self?.self.viewModel.id)
                switch response {
                case .success(let image):
                    XCTAssertNil(image)
                case .failure(let error):
                    XCTAssertEqual(error as NSError, expectedError)
                }
                expectation.fulfill()
            }
            self.downloadImageService.completion?(.failure(expectedError))
            wait(for: [expectation], timeout: 0.1)
        }
        
        func testLoadImageNotCall() {
            self.article.multimedias = nil
            let expectation = self.expectation(description: #function)
            expectation.isInverted = true
            self.viewModel = ArticleTableCellViewModel(content: self.article, downloadImageService: self.downloadImageService)
            let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
            let expectedImage = UIImage()
            
            self.viewModel.loadImage { (id, response) in
                expectation.fulfill()
            }
            self.downloadImageService.completion?(.success(expectedImage))
            self.downloadImageService.completion?(.failure(expectedError))
            wait(for: [expectation], timeout: 0.1)
        }
        
    }

// MARK: - Privates
extension ArticleTableCellViewModelTests {
    private func mockedContent() -> Article {
        return Article(title: "title", abstract: "abstract", url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html")!, date: Date(), multimedias: [
            Multimedia(type: .image, caption: "caption", copyright: "copyright", mediaData: [MediaData(url: URL(string: "https://static01.nyt.com/images/2020/02/17/world/17JAPAN-SHIP12-promo/17JAPAN-SHIP12-promo-thumbStandard-v4.jpg")!, format: .standardThumbnail)])
            ], byline: "byline", source: "source")
    }
}
