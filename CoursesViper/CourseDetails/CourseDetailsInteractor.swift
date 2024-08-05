//
//  CourseDetailsInteractor.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 02.08.2024.
//

import Foundation

protocol CourseDetailsInteractorInputProtocol {
    var isFavorite: Bool { get }
    init(presenter: CourseDetailsInteractorOutputProtocol, course: Course)
    func provideCourseDetails()
    func toggleFavoriteStatus()
}

protocol CourseDetailsInteractorOutputProtocol: AnyObject {
    func receiveCourseDetails(with dataStore: CourseDetailsDataStore)
    func receiveFavoriteStatus(with status: Bool)
}

class CourseDetailsInteractor: CourseDetailsInteractorInputProtocol {
    var isFavorite: Bool {
        get {
            DataManager.shared.getFavoriteStatus(for: course.name)
        } set {
            DataManager.shared.setFavoriteStatus(for: course.name, with: newValue)
        }
    }
    
    private unowned let presenter: CourseDetailsInteractorOutputProtocol
    private let course: Course
    
    required init(presenter: any CourseDetailsInteractorOutputProtocol, course: Course) {
        self.presenter = presenter
        self.course = course
    }
    
    func provideCourseDetails() {
        let imageData = ImageManager.shared.fetchImageData(from: course.imageUrl)
        let dataStore = CourseDetailsDataStore(
            courseName: course.name,
            numberOfLessons: course.numberOfLessons,
            numberOfTest: course.numberOfTests,
            imageData: imageData,
            isFavorite: isFavorite
            
        )
        presenter.receiveCourseDetails(with: dataStore)
    }
    
    func toggleFavoriteStatus() {
        isFavorite.toggle()
        presenter.receiveFavoriteStatus(with: isFavorite)
    }
}
