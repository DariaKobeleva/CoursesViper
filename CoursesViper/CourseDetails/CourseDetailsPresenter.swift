//
//  CourseDetailsPresenter.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 02.08.2024.
//

import Foundation

struct CourseDetailsDataStore {
    let courseName: String
    let numberOfLessons: Int
    let numberOfTest: Int
    let imageData: Data?
    let isFavorite: Bool
}

class CourseDetailsPresenter: CourseDetailsViewOutputProtocol {
    var interactor: CourseDetailsInteractorInputProtocol!
    private unowned let view: CourseDetailsViewInputProtocol
    
    required init(view: any CourseDetailsViewInputProtocol) {
        self.view = view
    }
    
    func showDetails() {
        interactor.provideCourseDetails()
    }
    
    func favoriteButtonPressed() {
        interactor.toggleFavoriteStatus()
    }
}

//MARK: - CourseDetailsInteractorOutputProtocol
extension CourseDetailsPresenter: CourseDetailsInteractorOutputProtocol {
    func receiveFavoriteStatus(with status: Bool) {
        view.displayImageFavoriteButton(with: status)
    }
    
    func receiveCourseDetails(with dataStore: CourseDetailsDataStore) {
        let numberOfLessons = "Number of lessons: \(dataStore.numberOfLessons)"
        let  numberOfTests = "Number of tests: \(dataStore.numberOfTest)"
        
        view.displayCourseName(with: dataStore.courseName)
        view.displayNumberOfLessons(with: numberOfLessons)
        view.displayNumberOfTests(with: numberOfTests)
        view.displayImageFavoriteButton(with: dataStore.isFavorite)
        
        guard let imageData = dataStore.imageData else { return }
        view.displayImage(with: imageData)
    }
}
