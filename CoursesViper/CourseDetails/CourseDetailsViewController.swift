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
    func displayNumberOfTests(with tittle: String)
    func displayImage(with imageData: Data)
    func displayImageFavoriteButton(with status: Bool)
}

protocol CourseDetailsViewOutputProtocol {
    init(view: CourseDetailsViewInputProtocol)
    func showDetails()
    func favoriteButtonPressed()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self, and: course)
        presenter.showDetails()
    }
    
    @IBAction func toggleFavorite() {
        presenter.favoriteButtonPressed()
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
    
    func displayNumberOfTests(with tittle: String) {
        numberOfTestsLabel.text = tittle
    }
    
    func displayImage(with imageData: Data) {
        courseImage.image = UIImage(data: imageData)
    }
    
    func displayImageFavoriteButton(with status: Bool) {
        favoriteButton.tintColor = status ? .red : .gray
    }
}
