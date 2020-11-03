//
//  WeatherServiceTests.swift
//  MyWeatherTests
//
//  Created by Ali Hassan on 03/11/2020.
//

import XCTest
@testable import MyWeather

class WeatherServiceTests: XCTestCase {
    
    var weatherService: WeatherService?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the classWeatherService
        super.setUp()
        weatherService = WeatherServiceImpl()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        weatherService = nil
        super.tearDown()
    }

    func test_fetch_weather_information() {

        // Given A apiservice
        let weatherService = self.weatherService!

        // When fetch popular photo
        let expect = XCTestExpectation(description: "callback")

        weatherService.fetchWeatherInformation(latitude: 59.337239, longitude: 18.062381, completion: { (weatherResult, error) in
            expect.fulfill()
            XCTAssertNotNil(weatherResult)
        })

        wait(for: [expect], timeout: 3.1)
    }

}
