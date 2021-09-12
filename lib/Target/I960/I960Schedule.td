// while I know some versions of the i960 support out of order execution and superscalar execution,
// I do not know which ones do at this point in time. So just assume in-order execution.
def I960SchedModel : SchedMachineModel {
    let IssueWidth = 1;
    let MicroOpBufferSize = 0;
    let CompleteModel = 0;
    let NoModel = 1;
}


/// @todo figure out if the i960Sx processor series supports multiple instruction execution