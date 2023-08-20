local status, ft = pcall(require, "guard.filetype")
if not status then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("没有找到 guard", "error")
	return
end

ft("lua"):fmt("stylua")
ft("typescript,javascript,typescriptreact"):fmt("prettier")
ft("c"):fmt("clang-format")
ft("python"):fmt("black"):lint("pylint")
ft("sh"):fmt("shfmt"):lint("shellcheck")
ft("go"):fmt("lsp"):append("golines"):lint("golangci")
