public import Byte
public import ISO_32000_7_Syntax
public import ISO_32000_Shared


extension ISO_32000.DigitalSignature.SignatureReference.DocMDPParams {
    public enum Permission: Int, Sendable, Hashable, Codable, CaseIterable {

        case noChanges = 1

        case formFillingAndSigning = 2

        case formFillingSigningAndAnnotations = 3
    }
}
