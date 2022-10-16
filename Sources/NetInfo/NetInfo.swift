import Foundation
import NIO

public struct NetworkInterface: Encodable {
    
    public let ip: String
    
    public let name: String
    
    public let broadcast: String
    
    public let netmask: String
    
    internal var address: SocketAddress
    internal var _broadcast: SocketAddress

    public var isLocalhost: Bool {
        return ip == "127.0.0.1"
    }
    
    enum CodingKeys: CodingKey {
        case ip, name, broadcast, netmask
    }
    
    static public func availableInterfaces() -> [NetworkInterface] {
        let matchingInterfaces = try? System.enumerateDevices()
            .compactMap { nioInterface -> NetworkInterface? in
                guard let address = nioInterface.address,
                      let ip = address.ipAddress,
                      let netmask = nioInterface.netmask?.ipAddress,
                      let broadcast = nioInterface.broadcastAddress?.ipAddress else {
                    return nil
                }
                
                return NetworkInterface(ip: ip,
                                        name: nioInterface.name,
                                        broadcast: broadcast,
                                        netmask: netmask,
                                        address: address,
                                        _broadcast: nioInterface.broadcastAddress!)
            }
        return matchingInterfaces ?? []
     }
}

extension NetworkInterface: Equatable {}
