//
//  ViewController.swift
//  MyWeather
//
//  Created by Ali Hassan on 03/11/2020.
//

import UIKit

class ViewController: UIViewController, AlertDisplayer {
    
    // MARK: - Properties
    
    private let viewModel = WeatherViewModel()
    
    private let weatherInfoView = WeatherView()
    
    private var activityIndView = UIActivityIndicatorView(style: .large)
    
    private lazy var dailyWeatherTV:UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.register(DailyWeatherTVC.self, forCellReuseIdentifier: "DailyWeatherTVC")
        tableView.tableFooterView = UIView()
        tableView.accessibilityIdentifier = "dailyWeatherTV"
        return tableView
    }()
    
    private lazy var hourlyWeatherCV: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(HourlyWeatherCVC.self, forCellWithReuseIdentifier: "HourlyWeatherCVC")
        collectionView.allowsSelection = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.accessibilityIdentifier = "hourlyWeatherCV"
        return collectionView
    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        setUpLocation()
        setUpView()
        setUpViewModel()
        self.view.addSubview(activityIndView)
    }
    
    private func separatorView() -> UIView {
        let separator = UIView()
        separator.backgroundColor = Constants.AppColors.primaryColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }
    
    private func setUpView(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"bg")!)
        let separatorTop = separatorView()
        let separatorBottom = separatorView()
        self.view.addSubview(weatherInfoView)
        self.view.addSubview(separatorTop)
        self.view.addSubview(hourlyWeatherCV)
        self.view.addSubview(separatorBottom)
        self.view.addSubview(dailyWeatherTV)
        
        self.weatherInfoView.translatesAutoresizingMaskIntoConstraints = false;
        dailyWeatherTV.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            weatherInfoView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            weatherInfoView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            weatherInfoView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor),
            
            separatorTop.topAnchor.constraint(equalTo:weatherInfoView.bottomAnchor, constant: 15),
            separatorTop.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            separatorTop.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor),
            separatorTop.heightAnchor.constraint(equalToConstant:0.5),
            
            hourlyWeatherCV.topAnchor.constraint(equalTo:separatorTop.bottomAnchor),
            hourlyWeatherCV.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            hourlyWeatherCV.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor),
            hourlyWeatherCV.heightAnchor.constraint(equalToConstant:100),
            
            separatorBottom.topAnchor.constraint(equalTo:hourlyWeatherCV.bottomAnchor, constant: -12),
            separatorBottom.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            separatorBottom.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor),
            separatorBottom.heightAnchor.constraint(equalToConstant:0.5),
            
            dailyWeatherTV.topAnchor.constraint(equalTo:separatorBottom.bottomAnchor),
            dailyWeatherTV.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            dailyWeatherTV.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            dailyWeatherTV.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        viewModel.reloadDailyTableView = {
            DispatchQueue.main.async {
                self.dailyWeatherTV.reloadData()
            }
        }
        
        viewModel.reloadHourlyCollectionView = {
            DispatchQueue.main.async {
                self.hourlyWeatherCV.reloadData()
            }
        }
    }
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let cellWidthConstant: CGFloat = 80
        let cellHeightConstant: CGFloat = 100
        
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 10,
                                           bottom: 0,
                                           right: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: cellWidthConstant, height: cellHeightConstant)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    private func setUpViewModel() {
        
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlert = {
            if let error = self.viewModel.error {
                let title = "Warning"
                let action = UIAlertAction(title: "OK", style: .default)
                DispatchQueue.main.async {
                    self.displayAlert(with: title , message: error, actions: [action])
                }
            }
        }
        
        viewModel.didFinishFetch = {
            DispatchQueue.main.async {
                self.viewModel.configureWeatherView(self.weatherInfoView)
            }
        }
    }
    
    private func activityIndicatorStart() {
        DispatchQueue.main.async {
            LLSpinner.spin()
        }
    }
    
    private func activityIndicatorStop() {
        DispatchQueue.main.async {
            LLSpinner.stop()
        }
    }
    
    
}


// MARK: - Table View

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dailyWeatherCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherTVC", for: indexPath) as! DailyWeatherTVC
        cell.setUpData(weathInfo: viewModel.dailyWeather[indexPath.row])
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


// MARK: - Collection View

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.hourlyWeatherCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherCVC", for: indexPath) as! HourlyWeatherCVC
        cell.setUpData(hourlyWeatherDettail: viewModel.hourlyWeather[indexPath.row])
        return cell
    }
    
}

