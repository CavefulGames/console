export type ConsoleImpl = {
    log: (data: any, ...any) -> (),
    error: (data: any, ...any) -> (),
    warn: (data: any, ...any) -> (),

    assert: (value: any, ...any) -> (),
    count: (label: string?) -> (),
    countReset: (table: string?) -> (),
    debug: (data: any, ...any) -> (),
    dir: (object: { [any]: any }, options: { colors: boolean?, }?) -> (),
    dirxml: (data: any, ...any) -> (),
    group: (data: any, ...any) -> (),
    groupEnd: () -> (),
    info: (data: any, ...any) -> (),
    table: (table: { [any]: any }) -> (),
    time: (label: string?) -> (),
    timeEnd: (label: string?) -> (),
    timeLog: (label: string?, ...any) -> (),
    tree: (top: string, child: { [number]: any }?) -> (),
}
return {}