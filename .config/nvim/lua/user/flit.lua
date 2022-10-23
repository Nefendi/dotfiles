local status_ok, flit = pcall(require, "flit")
if not status_ok then
    return
end

flit.setup {}
