//
//  ViewController.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 02.08.2024.
//

import UIKit

protocol CourseDetailsViewInputProtocol: AnyObject {
    func displayCourseName(with tittle: String)
    func displayNumberOfLessons(with tittle: String)
    func displayNumberOfTest(with tittle: String)
}

protocol CourseDetailsViewOutputProtocol {
    init(view: CourseDetailsViewInputProtocol)
    func showDetails()
}

class CourseDetailsViewController: UIViewController {
    
    @IBOutlet private var courseNameLabel: UILabel!
    @IBOutlet private var numberOfLessonsLabel: UILabel!
    @IBOutlet private var numberOfTestsLabel: UILabel!
    @IBOutlet private var courseImage: UIImageView!
    @IBOutlet private var favoriteButton: UIButton!
    
    var course: Course!
    var presenter: CourseDetailsViewOutputProtocol!
    var configurator: CourseDetailsConfiguratorInputProtocol = CourseDetailsIConfigurator()
    
    private var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self, and: course)
        loadFavoriteStatus()
        setupUI()
        presenter.showDetails()
    }
    
    @IBAction func toggleFavorite() {
        isFavorite.toggle()
        setStatusForFavoriteButton()
        DataManager.shared.setFavoriteStatus(for: course.name, with: isFavorite)
        
    }
    
    private func setupUI() {
        numberOfLessonsLabel.text = "Number of lessons: \(course.numberOfLessons)"
        numberOfTestsLabel.text = "Number of tests: \(course.numberOfTests)"
        
        if let imageData = ImageManager.shared.fetchImageData(from: course.imageUrl) {
            courseImage.image = UIImage(data: imageData)
        }
        setStatusForFavoriteButton()
    }
    
    private func setStatusForFavoriteButton() {
        favoriteButton.tintColor = isFavorite ? .red : .gray
    }
    
    private func loadFavoriteStatus() {
        isFavorite = DataManager.shared.getFavoriteStatus(for: course.name)
    }
}

//MARK: - CourseDetailsViewInputProtocol

extension CourseDetailsViewController: CourseDetailsViewInputProtocol {
    func displayCourseName(with tittle: String) {
        courseNameLabel.text = tittle
    }
    func displayNumberOfLessons(with tittle: String) {
        numberOfLessonsLabel.text = tittle
    }
    
    func displayNumberOfTest(with tittle: String) {
        numberOfTestsLabel.text = tittle
    }
}
