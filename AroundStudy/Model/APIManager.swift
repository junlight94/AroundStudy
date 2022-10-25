//  APIManager.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/09/27.
//  API 호출 설정

import Foundation
import Alamofire

public actor APIManager {
    /// API 호출 싱글턴 인스턴스
    public static let shared = APIManager()
    
    private init() {}
    
    /**
     * @서버의 데이터 호출
     * @주의점1: async, await 형식으로 실행 시 Task 블록에서 작업
     * @주의점2: 기본적으로 글로벌 비동기 처리이므로, UI를 업데이트 할 때는 메인스레드에서 동작하게 설정해야 함.
     * @creator : coder3306
     * @param url : 서버에 요청할 URL 주소
     * @param type : 모델 데이터
     * @param method : 요청방식(get,post,put,delete)
     * @param uri : 서버에 있는 리소스 주소 설정
     * @param param : 서버에 요청할 데이터의 파라미터
     * @param header : 서버에 요청할 부가적인 정보
     * @Return : (비동기) 모델에 매핑된 데이터 반환
     */
    public func requestJSON<T:Codable>(url: String, type: T.Type, method: HTTPMethod, uri: String = "", param: [String: String]? = nil, header: [HTTPHeader]? = nil) async throws -> T {
        ///TODO: API ID, HEADER 설정해서 url 작업 들어가야하고, 헤더도 부가적으로 필요하다.
        let request = AF.request(url
                                , method: method
                                , parameters: param
                                , encoding: JSONEncoding.default).serializingDecodable(type)
        //FIXME: - 모델 매핑 미스에 대한 오류처리 추가 필요함
        guard await (request.response.response?.statusCode == 200) else { throw ApiError.statusCodeError }
        guard await (request.response.value != nil) else { throw ApiError.emptyData }
        return try await request.value
    }
    
    /**
     * @이미지 다운로드
     * @creator : coder3306
     * @param url : 다운로드할 이미지 주소
     * @Return : (비동기) 다운로드가 완료된 이미지
     */
    public func downloadImage(_ url: String, complete: @escaping (Result<UIImage, Error>) -> ()) {
        if let encodingURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            AF.request(encodingURL).responseData(completionHandler: { response in
                switch response.result {
                    case .success(let data):
                        if let image = UIImage(data: data) {
                            complete(.success(image))
                        }
                    case .failure(let error):
                        complete(.failure(error))
                }
            })
        }
    }
}

/// API 에러 열거
public enum ApiError: Error {
    case invalidURL
    case encodingError
    case statusCodeError
    case imageConvertingError
    case emptyData
}

extension ApiError {
    var localizedDescription: String {
        switch self {
            case .invalidURL:
                return "Invalid URL"
            case .statusCodeError:
                return "Response Error"
            case .imageConvertingError:
                return "image Error"
            case .emptyData:
                return "No Data"
            case .encodingError:
                return "Encoding Error"
        }
    }
}
