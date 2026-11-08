public import ISO_32000_Shared
public import RFC_3986


extension ISO_32000.Action {
    public enum Kind: String, Sendable, Codable, CaseIterable {

        case goTo = "GoTo"

        case goToR = "GoToR"

        case goToE = "GoToE"

        case goToDp = "GoToDp"

        case launch = "Launch"

        case thread = "Thread"

        case uri = "URI"

        case sound = "Sound"

        case movie = "Movie"

        case hide = "Hide"

        case named = "Named"

        case submitForm = "SubmitForm"

        case resetForm = "ResetForm"

        case importData = "ImportData"

        case setOCGState = "SetOCGState"

        case rendition = "Rendition"

        case trans = "Trans"

        case goTo3DView = "GoTo3DView"

        case javaScript = "JavaScript"

        case richMediaExecute = "RichMediaExecute"
    }
}
