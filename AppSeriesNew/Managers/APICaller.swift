//
//  APICaller.swift
//  APPSeries
//
//  Created by Mendes, Mafalda Joana on 11/05/2022.
//

import Foundation
import Alamofire

struct Constants {
    static let apiKey = "k_k5beia58"// "k_o4g32is7"//"k_k5beia58" //"k_rxtomrn7" // k_h19su5vw
    static let baseURL = "https://imdb-api.com/API"
}

enum APIError: Error {
    case failedToGetData
    case URLfailed
    case failedRequest
    case faieldEnconding
}

class APICaller {
    static let shared = APICaller()
    func getMostPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/MostPopularMovies/\(Constants.apiKey)") else {
            completion(.failure(APIError.URLfailed))
            return
        }
        AF.request(url).validate().responseDecodable(of: MoviesResponse.self) { response in
            guard let data = response.data, response.error == nil else {
                completion(.failure(APIError.failedRequest))
                return
            }
            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.items!))
            } catch {
                completion(.failure(APIError.failedToGetData))
                // print(String(describing: error))
            }
        }
    }
    func getTop250Movies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/Top250Movies/\(Constants.apiKey)") else {
            completion(.failure(APIError.URLfailed))
            return
        }
        AF.request(url).validate().responseDecodable(of: MoviesResponse.self) { response in
            guard let data = response.data, response.error == nil else {
                completion(.failure(APIError.failedRequest))
                return
            }
            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.items!))
            } catch {
               // print(String(describing: error))
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
    func getInTheaters(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/InTheaters/\(Constants.apiKey)") else {
            completion(.failure(APIError.URLfailed))
            return
        }
        AF.request(url).validate().responseDecodable(of: MoviesResponse.self) { response in
            guard let data = response.data, response.error == nil else {
                completion(.failure(APIError.failedRequest))
                return
            }
            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.items!))
            } catch {
                // print(String(describing: error))
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
    func getCommingSoonMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/ComingSoon/\(Constants.apiKey)") else {
            completion(.failure(APIError.URLfailed))
            return
        }
        AF.request(url).validate().responseDecodable(of: MoviesResponse.self) { response in
            guard let data = response.data, response.error == nil else {
                completion(.failure(APIError.failedRequest))
                return
            }
            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.items!))
            } catch {
                // print(String(describing: error))
                completion(.failure(APIError.failedToGetData))
            }
        }
    }
    func searchMovie(with movie: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let movie = movie.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            completion(.failure(APIError.faieldEnconding))
            return
        }
        guard let url = URL(string: "\(Constants.baseURL)/SearchMovie/\(Constants.apiKey)/\(movie)") else {
            completion(.failure(APIError.URLfailed))
            return
        }
        AF.request(url).validate().responseDecodable(of: MoviesResponse.self) { response in
            guard let data = response.data, response.error == nil else {
                completion(.failure(APIError.failedRequest))
                return
            }
            do {
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results!))
            } catch {
                // print(String(describing: error))
                completion(.failure(APIError.failedToGetData))
            }

        }
    }
}
