public struct ImageSendMessage: Encodable {
    private let type = "image"
    private let originalContentUrl: String
    private let previewImageUrl: String
    
    public init(originalContentUrl: String, previewImageUrl: String) {
        self.originalContentUrl = originalContentUrl
        self.previewImageUrl = previewImageUrl
    }
}
