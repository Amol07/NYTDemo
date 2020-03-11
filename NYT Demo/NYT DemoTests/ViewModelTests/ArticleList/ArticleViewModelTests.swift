//
//  ArticleViewModelTests.swift
//  NYT DemoTests
//
//  Created by Amol Prakash on 11/03/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import XCTest
@testable import NYT_Demo

class ArticleViewModelTests: XCTestCase {
    var viewModel: ArticleViewModel!
    var articleSerivce: ArticleServiceApiMock!
    var article: Article!
    var downloadImageService: DownloadImageServiceMock!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.articleSerivce = ArticleServiceApiMock()
        self.downloadImageService = DownloadImageServiceMock()
        self.viewModel = ArticleViewModel(articleSerivce: self.articleSerivce)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.articleSerivce = nil
        self.article = nil
        self.downloadImageService = nil
        self.viewModel = nil
        super.tearDown()
    }

    func testContentViewModel() {
        XCTAssertNil(self.viewModel.contentViewModel(at: 0))
        
        let viewModel = ArticleTableCellViewModel(content: self.mockedContent(), downloadImageService: self.downloadImageService)
        self.viewModel.append(contentViewModel: viewModel)
        self.viewModel.append(contentViewModel: viewModel)
        self.viewModel.append(contentViewModel: viewModel)

        let viewModel0 = self.viewModel.contentViewModel(at: -1)
        let viewModel1 = self.viewModel.contentViewModel(at: 0)
        let viewModel2 = self.viewModel.contentViewModel(at: 1)
        let viewModel3 = self.viewModel.contentViewModel(at: 2)
        let viewModel4 = self.viewModel.contentViewModel(at: 3)

        XCTAssertNil(viewModel0)
        XCTAssertNotNil(viewModel1)
        XCTAssertNotNil(viewModel2)
        XCTAssertNotNil(viewModel3)
        XCTAssertNil(viewModel4)
    }
    
    func testAppendContentViewModel() {
        let viewModel = ArticleTableCellViewModel(content: self.mockedContent(), downloadImageService: self.downloadImageService)
        self.viewModel.append(contentViewModel: viewModel)
        XCTAssertEqual(self.viewModel.contentViewModels.count, 1)
        
        self.viewModel.append(contentViewModel: viewModel)
        XCTAssertEqual(self.viewModel.contentViewModels.count, 2)
        
        self.viewModel.append(contentViewModel: viewModel)
        XCTAssertEqual(self.viewModel.contentViewModels.count, 3)
    }

}

// MARK: - Test loadMore method
extension ArticleViewModelTests {
    func testLoadMoreSuccess() {
        let content = self.mockedContent()
        let contents =  [content, content, content]
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.isInverted = true
        self.viewModel.onReloadData = { [weak self] in
            XCTAssertEqual(self?.self.viewModel.contentViewModels.count, contents.count)
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        erroredExpectation.isInverted = true
        self.viewModel.onError = { _ in
            erroredExpectation.fulfill()
        }
        
        let moreDataExpectation = XCTestExpectation(description: #function + "onMoreData")
        self.viewModel.onMoreData = { _ in
            moreDataExpectation.fulfill()
        }

        self.viewModel.loadMore()
        XCTAssertTrue(self.viewModel.isLoading)
        self.articleSerivce.completion?(.success(contents))

        XCTAssertFalse(self.viewModel.isLoading)
        XCTAssertEqual(self.articleSerivce.pageIndex, 1)
        XCTAssertEqual(self.articleSerivce.offset, Constant.APIConstant.offset)
        wait(for: [reloadDataExpectation, erroredExpectation, moreDataExpectation], timeout: 0.1)
    }
    
    func testLoadMoreError() {
        let message = "Error message"
        let expectedError = mockedError(message: message)
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.isInverted = true
        self.viewModel.onReloadData = {
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        self.viewModel.onError = { [weak self] errorMessage in
            XCTAssertEqual(self?.self.viewModel.contentViewModels.count, 0)
            XCTAssertEqual(errorMessage, message)
            erroredExpectation.fulfill()
        }
        
        let moreDataExpectation = XCTestExpectation(description: #function + "onMoreData")
        moreDataExpectation.isInverted = true
        self.viewModel.onMoreData = { _ in
            moreDataExpectation.fulfill()
        }

        self.viewModel.loadMore()
        XCTAssertTrue(self.viewModel.isLoading)
        self.articleSerivce.completion?(.failure(expectedError))

        XCTAssertFalse(self.viewModel.isLoading)
        XCTAssertEqual(self.articleSerivce.pageIndex, 1)
        XCTAssertEqual(self.articleSerivce.offset, Constant.APIConstant.offset)
        wait(for: [reloadDataExpectation, erroredExpectation, moreDataExpectation], timeout: 0.1)
    }
}

// MARK: - Test refresh method
extension ArticleViewModelTests {
    
    func testRefreshSuccess() {
        let content = self.mockedContent()
        let contents =  [content, content, content]
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        self.viewModel.onReloadData = { [weak self] in
            XCTAssertEqual(self?.self.viewModel.contentViewModels.count, contents.count)
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        erroredExpectation.isInverted = true
        self.viewModel.onError = { _ in
            erroredExpectation.fulfill()
        }
        
        let moreDataExpectation = XCTestExpectation(description: #function + "onMoreData")
        moreDataExpectation.isInverted = true
        self.viewModel.onMoreData = { _ in
            moreDataExpectation.fulfill()
        }

        self.viewModel.refresh()
        XCTAssertTrue(self.viewModel.isLoading)
        self.articleSerivce.completion?(.success(contents))

        XCTAssertFalse(self.viewModel.isLoading)
        XCTAssertEqual(self.articleSerivce.pageIndex, 0)
        XCTAssertEqual(self.articleSerivce.offset, Constant.APIConstant.offset)
        wait(for: [reloadDataExpectation, erroredExpectation, moreDataExpectation], timeout: 0.1)
    }
    
    func testRefreshError() {
        let message = "Error message"
        let expectedError = mockedError(message: message)
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.isInverted = true
        self.viewModel.onReloadData = {
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        self.viewModel.onError = { [weak self] errorMessage in
            XCTAssertEqual(self?.self.viewModel.contentViewModels.count, 0)
            XCTAssertEqual(errorMessage, message)
            erroredExpectation.fulfill()
        }
        
        let moreDataExpectation = XCTestExpectation(description: #function + "onMoreData")
        moreDataExpectation.isInverted = true
        self.viewModel.onMoreData = { _ in
            moreDataExpectation.fulfill()
        }
        self.viewModel.refresh()
        XCTAssertTrue(self.viewModel.isLoading)
        self.articleSerivce.completion?(.failure(expectedError))
        XCTAssertFalse(self.viewModel.isLoading)
        XCTAssertEqual(self.articleSerivce.pageIndex, 0)
        XCTAssertEqual(self.articleSerivce.offset, Constant.APIConstant.offset)
        wait(for: [reloadDataExpectation, erroredExpectation, moreDataExpectation], timeout: 0.1)
    }
}

// MARK: - Privates

extension ArticleViewModelTests {
    private func mockedContent() -> Article {
        return Article(title: "title", abstract: "abstract", url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html")!, date: Date(), multimedias: [
            Multimedia(type: .image, caption: "caption", copyright: "copyright", mediaData: [MediaData(url: URL(string: "https://static01.nyt.com/images/2020/02/17/world/17JAPAN-SHIP12-promo/17JAPAN-SHIP12-promo-thumbStandard-v4.jpg")!, format: .standardThumbnail)])
            ], byline: "byline", source: "source")
    }
    
    private func mockedError(message: String) -> Error {
        return NSError(domain: "test-error", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
