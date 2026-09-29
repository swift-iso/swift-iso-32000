public import Geometry

extension ISO_32000 {

    /// Homogeneous column-vector matrix: [[a,c,e],[b,d,f],[0,0,1]].
    public typealias Transform<Space> = Linear<Double, Space>.Matrix<3, 3>
}
