import Foundation

enum NetworkError: Error {
    case decodeError
    case wrongResponse
    case wrongStatusCode(code: Int)
}

public class NetworkService {
    
    public init() {}
    
    public func getData<T: Decodable>(urlString: String, completion: @escaping (Result<T,Error>) ->(Void)) {
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let error {
                print(error.localizedDescription)
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("Wrong status code: \(response.statusCode.description)")
                return
            }
            
            guard let data else { return }
            
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(object))
                }
            } catch {
                completion(.failure(NetworkError.decodeError))
            }
        }.resume()
    }
}
