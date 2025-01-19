export type ConsoleImpl = {
    __index: ConsoleImpl,
    log: (data: any, ...any) -> (),
    error: (data: any, ...any) -> (),
    warn: (data: any, ...any) -> (),
}
return {}