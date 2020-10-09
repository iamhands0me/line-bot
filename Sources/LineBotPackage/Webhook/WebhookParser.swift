import Vapor

public final class WebhookParser {
    private let key: SymmetricKey
    
    public init(channelSecret: String) {
        key = SymmetricKey(data: Data(channelSecret.utf8))
    }
    
    public func parse(body: String, signature: String) -> Array<Event>? {
        let data = Data(body.utf8)
        let digest = HMAC<SHA256>.authenticationCode(for: data, using: key)
        
        guard signature == Data(hexString: digest.hex)?.base64EncodedString() else {
            return nil
        }
        
        struct WebhookPayload: Decodable {
            var destination: String
            var events: Array<Event>
        }
        
        let webhookPayload = try? JSONDecoder().decode(WebhookPayload.self, from: data)
        return webhookPayload?.events
    }
}

extension Data {
    init?(hexString: String) {
        let len = hexString.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = hexString.index(hexString.startIndex, offsetBy: i*2)
            let k = hexString.index(j, offsetBy: 2)
            let bytes = hexString[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
}
