import Vapor

public final class LineBotApi {
    private let headers: HTTPHeaders
    
    public init(channelAccessToken: String) {
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/json")
        headers.add(name: "Authorization", value: "Bearer \(channelAccessToken)")
        self.headers = headers
    }
    
    public func replyMessage(replyToken: String, message: Encodable) -> ClientRequest {
        return replyMessage(replyToken: replyToken, messages: [message])
    }
    
    public func replyMessage(replyToken: String, messages: Array<Encodable>) -> ClientRequest {
        var request = ClientRequest()
        request.method = .POST
        request.url = "https://api.line.me/v2/bot/message/reply"
        request.headers = headers
        
        struct ReplyMessage: Encodable {
            var replyToken: String
            var messages: Array<SendMessage>
        }
        
        let data = ReplyMessage(replyToken: replyToken, messages: sendMessages(messages))
        _ = try? request.content.encode(data, using: JSONEncoder())
        
        return request
    }
    
    private func sendMessages(_ messages: Array<Encodable>) -> Array<SendMessage> {
        var sendMessages: Array<SendMessage> = []
        for message in messages {
            switch message {
            case let textSendMessage as TextSendMessage:
                sendMessages.append(SendMessage.text(textSendMessage))
            case let imageSendMessage as ImageSendMessage:
                sendMessages.append(SendMessage.image(imageSendMessage))
            default:
                break
            }
        }
        return sendMessages
    }
}
