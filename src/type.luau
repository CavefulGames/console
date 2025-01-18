export type ConsoleImpl = {
    __index: ConsoleImpl,
    assert: (value: any, ...any) -> (),
    log: (...any) -> (),
    error: (...any) -> (),
}

return {}