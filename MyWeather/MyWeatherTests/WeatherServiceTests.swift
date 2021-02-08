//
//  WeatherServiceTests.swift
//  MyWeatherTests
//
//  Created by Ali Hassan on 03/11/2020.
//

import XCTest
@testable import MyWeather

class WeatherServiceTests: XCTestCase, WeatherServiceDelegate {
    
    var weatherService: WeatherService?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the classWeatherService
        super.setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        weatherService = nil
        super.tearDown()
    }
    
    private var onWeatherFetchCompletedExpectation: XCTestExpectation!
    private var onFetchFailedExpectation: XCTestExpectation!
    private var weatherResult: WeatherResult!
    private var errorReason: String!
    
    func test_fetch_weather_information_success() {

        // Given A apiservice
        weatherService = WeatherService(weather: WeatherEndPoint.forecast.rawValue)
        weatherService?.delegate = self

        // When fetch weath info
        onWeatherFetchCompletedExpectation = expectation(description: "onWeatherFetchCompleted")
        weatherService!.fetchWeatherInformation(latitude: 59.337239, longitude: 18.062381)
        
        waitForExpectations(timeout: 100)
        XCTAssertNotNil(self.weatherResult)
        XCTAssertNil(self.errorReason)
    }
    
    func test_fetch_weather_information_failure() {

        // Given A apiservice
        weatherService = WeatherService(weather: "invalidURL")
        weatherService?.delegate = self

        // When fetch weath info
        onFetchFailedExpectation = expectation(description: "onFetchFailed")
        weatherService!.fetchWeatherInformation(latitude: 59.337239, longitude: 18.062381)
        
        waitForExpectations(timeout: 100)
        XCTAssertNil(self.weatherResult)
        XCTAssertNotNil(self.errorReason)
    }
    
    func onWeatherFetchCompleted(with weatherResult: WeatherResult) {
        self.weatherResult = weatherResult
        onWeatherFetchCompletedExpectation.fulfill()
    }
    
    
    func onFetchFailed(with reason: String) {
        self.errorReason = reason
        onFetchFailedExpectation.fulfill()
    }

}
