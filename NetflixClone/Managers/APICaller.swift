//
//  APICaller.swift
//  NetflixClone
//
//  Created by ekincare on 11/10/22.
//

import Foundation

struct Constants{
    static let API_KEY = "fa00bd5cc55de7bbe4e9a452198b2495"
    static let baseURL = "https://api.themoviedb.org"
    static let youtubeAPI_KEY = "AIzaSyAgK6jbDGrS1cUMunhqn6m1YWnxqLm5RQY"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"

}

enum APIError: Error {
    case failedTogetData
}

class APICaller{
    static let shared = APICaller()
    
    //Treanding Movie
    func getTreandingMovies(completion: @escaping (Result<[Title], Error>) ->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                print("Data is ",data)
                let result = try JSONDecoder().decode(TreandingTitleResponce.self, from: data)
                completion(.success(result.results))
           
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    //For Tv
    func getTreandingTvs(completion: @escaping (Result<[Title], Error>) ->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(TreandingTitleResponce.self, from: data)
                completion(.success(result.results))
               
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    //Get Upcomming Movie
    func getUpcommingMovies(completion: @escaping (Result<[Title], Error>) ->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(TreandingTitleResponce.self, from: data)
                completion(.success(result.results))
               
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }

    
    //Popular Movie
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) ->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(TreandingTitleResponce.self, from: data)
                completion(.success(result.results))
               
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    //get Top Rated Movies
    func getTopRated(completion: @escaping (Result<[Title], Error>) ->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(TreandingTitleResponce.self, from: data)
                completion(.success(result.results))
               
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    //Movies discover
    func getMoviesDiscover(completion: @escaping (Result<[Title], Error>) ->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(TreandingTitleResponce.self, from: data)
                completion(.success(result.results))
               
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    //Movies  or Tv Search
    func search(with query: String, completion: @escaping (Result<[Title], Error>) ->Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(TreandingTitleResponce.self, from: data)
                print(result.results)
                completion(.success(result.results))
               
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    // get movies
    func getMovies(with query: String, completion: @escaping (Result<VideoElement, Error>) ->Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.youtubeBaseURL)q=\(query)&key=\(Constants.youtubeAPI_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(YoutubeSearchResults.self, from: data)
                print(result)
                completion(.success(result.items[0]))
                
               
            }catch{
                completion(.failure(error))
//                print(error.localizedDescription)
            }
        }
        task.resume()
    }

}
