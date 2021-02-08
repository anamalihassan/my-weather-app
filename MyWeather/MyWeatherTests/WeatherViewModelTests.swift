//
//  WeatherViewModelTests.swift
//  MyWeatherTests
//
//  Created by Ali Hassan on 03/11/2020.
//

import XCTest
@testable import MyWeather

class WeatherViewModelTests: XCTestCase {
    
    var sut: WeatherViewModel!
    var mockWeatherService: MockWeatherService!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockWeatherService = MockWeatherService()
        sut = WeatherViewModel(weatherService: mockWeatherService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockWeatherService = nil
        super.tearDown()
    }
    
    func test_fetch_weather_info() {
        sut.fetchWeatherInformation(latitude: 59.337239, longitude: 18.062381)
    
        // Assert
        XCTAssert(mockWeatherService!.isFetchWeatherInfoCalled)
    }
    
    func test_create_daily_weather_cells() {

        let stubWeather = StubGenerator().stubWeatherInfo()
        mockWeatherService.weatherResult = stubWeather
        let expect = XCTestExpectation(description: "daily data count")
        sut.reloadDailyTableView = { () in
            expect.fulfill()
        }
        
        sut.fetchWeatherInformation(latitude: 59.337239, longitude: 18.062381)
        
        // dailyWeatherCount is equal to the number of daily data
        XCTAssertEqual( sut.dailyWeatherCount, stubWeather.daily?.data?.count )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }
    
    func test_create_hourly_weather_cells() {

        let stubWeather = StubGenerator().stubWeatherInfo()
        mockWeatherService.weatherResult = stubWeather
        let expect = XCTestExpectation(description: "hourly data count")
        sut.reloadHourlyCollectionView = { () in
            expect.fulfill()
        }
        
        sut.fetchWeatherInformation(latitude: 59.337239, longitude: 18.062381)
        
        // dailyWeatherCount is equal to the number of daily data
        XCTAssertEqual( sut.hourlyWeatherCount, stubWeather.hourly?.data?.count )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }

}

//MARK: State control
extension WeatherViewModelTests {
    private func goToFetchPhotoFinished() {
        mockWeatherService.weatherResult = StubGenerator().stubWeatherInfo()
        sut.fetchWeatherInformation(latitude: 59.337239, longitude: 18.062381)
        
    }
}

class MockWeatherService: WeatherService {
    init() {
        super.init(weather: WeatherEndPoint.forecast.rawValue)
    }
    override func fetchWeatherInformation(latitude: Double, longitude: Double) {
        isFetchWeatherInfoCalled = true
        weatherResult = StubGenerator().stubWeatherInfo()
        if let response = weatherResult{
            self.delegate?.onWeatherFetchCompleted(with: response)
            
        }
    }
    
    
    var isFetchWeatherInfoCalled = false
    
    var weatherResult: WeatherResult?
    
}

class StubGenerator {
    func stubWeatherInfo() -> WeatherResult {
        let path = Bundle.main.path(forResource: "content", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let weatherResult = try! decoder.decode(WeatherResult.self, from: data)
        return weatherResult
    }
}

