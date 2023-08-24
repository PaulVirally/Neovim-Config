local ls = require('luasnip')
local snippet = ls.snippet
local autosnippet = ls.extend_decorator.apply(snippet, {snippetType = 'autosnippet'})
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local extras = require('luasnip.extras')
local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt
local line_begin = require('luasnip.extras.conditions.expand').line_begin
local ts_utils = require('nvim-treesitter.ts_utils')

local function is_node_math(node)
	local type = node:type()
	if type == 'text_mode' then
		return false, true
	end
	if type == 'math_environment' or type == 'inline_formula' or type == 'displayed_equation' then
		return true, true
	end
	-- TODO: Add a check for the \qq{} special case
	return false, false
end

local function is_math_env()
	local curr_node = ts_utils.get_node_at_cursor()
	while curr_node ~= nil do
		local is_math, stop = is_node_math(curr_node)
		if is_math then
			return true
		end
		if stop then
			break
		end
		curr_node = curr_node:parent()
	end
	return false
end

local function not_math()
	return not is_math_env()
end

return {
	snippet({trig = 'skeleton', name = 'Skeleton outline', dscr = 'Creates an empty LaTeX document', hidden = true},
		fmt([[
		\documentclass[12pt]{article}

		% Packages
		\usepackage{amsfonts}
		\usepackage{amsmath}
		\usepackage{amssymb}
		\usepackage{amsthm}
		\usepackage{bbm}
		\usepackage{cancel}
		\usepackage{hyperref}
		\usepackage[nameinlink]{cleveref}
		\usepackage{empheq}
		\usepackage{fancyhdr}
		\usepackage{geometry}[margins=1.5in]
		\usepackage{mathtools}
		\usepackage{pgfplots}
		\usepackage[italicdiff, arrowdel]{physics}
		\usepackage{siunitx}
		\usepackage{tensor}
		\usepackage{wasysym}

		% Variables
		\newcommand{\theAuthor}{Paul Virally}
		\newcommand{\theTitle}{Example Title}
		\newcommand{\theSubtitle}{Example Subtitle}
		\newcommand{\theDate}{\today}

		% Headers and footers
		\pagestyle{fancy}
		\lhead{\theAuthor{}}
		\chead{\textit{\theSubtitle{}}}
		\rhead{\theTitle{}}
		\lfoot{}
		\cfoot{}
		\rfoot{Page \thepage}

		% Document
		\begin{document}


		% Cover page
		\begin{titlepage}
			\begin{center}
				\textsc{\Huge{\theTitle}}\\[0.5cm]
				\textsc{\Large{\theSubtitle}}\\[4cm]
				\theAuthor{}\\[0.2cm]
				\theDate{}
			\end{center}
		\newpage
		\end{titlepage}
		\newpage

		\tableofcontents
		\newpage

		\section{<>}

		\end{document}
		]],
			{i(0)},
			{delimiters = '<>'}
		),
		{condition = line_begin, show_condition = line_begin}
	),

	snippet(
		{trig = 'assignment', name = 'Assignment template', desc = 'Creates an empty assignment template document', hidden = true},
		fmt([[
		\documentclass{assignment}

		\synctex=1

		% Packages
		\usepackage{amsfonts}
		\usepackage{amsmath}
		\usepackage{amssymb}
		\usepackage{amsthm}
		\usepackage{bbm}
		\usepackage{cancel}
		\usepackage{hyperref}
		\usepackage[nameinlink]{cleveref}
		\usepackage{empheq}
		\usepackage{geometry}[margins=1.5in]
		\usepackage{mathtools}
		\usepackage{pgfplots}
		\usepackage[italicdiff, arrowdel]{physics}
		\usepackage{siunitx}
		\usepackage{tensor}
		\usepackage{tikz}
		\usepackage{wasysym}

		\usetikzlibrary{calc,patterns,angles,quotes}

		% PGFPlots
		\pgfplotsset{compat=newest} 

		% Assignment details
		\courselabel{}
		\exercisesheet{<>}{Assignment <>}
		\university{}
		\school{University of Waterloo}
		\student{Paul Virally --- ID:\@ 20769927}
		\semester{<>}
		\date{\today}

		\newcommand\red[1]{
		    \ensuremath{\textcolor{red}{#1}}
		}

		\newcommand\blue[1]{
			\ensuremath{\textcolor{blue}{#1}}
		}

		\newcommand\todo[1]{
			\Huge{\color{red}{TODO:~#1}}\normalsize{}
		}

		\renewcommand{\theequation}{\theenumi.\arabic{equation}}

		% Allows \label[q]{some-label} to label a question
		\crefname{q}{question}{questions}
		\Crefname{q}{Question}{Questions}
		\creflabelformat{q}{#2\textup{(#1)}#3}

		% Begin document
		\begin{document}
		\begin{problemlist}

		% Problem 1
		\pbitem{\emph{<>}}

		<>
		\end{problemlist}
		\end{document}
		]],
			{i(1, 'PHYS 394'), i(2, '1'), i(3, 'Winter 2023'), i(4, 'Problem prompt'), i(0)},
			{delimiters = '<>'}
		),
		{condition = line_begin, show_condition = line_begin}
	),

	autosnippet(
		{trig = 'prob', name = 'Problem', desc = 'Assignment problem', hidden = true},
		fmt([[
		\newpage
		% Problem <>
		\setcounter{equation}{0}
		\setcounter{enumii}{<>}
		\pbitem{\emph{<>}}
		<>
		]],
			{i(1, '2'), rep(1), i(2, 'Problem prompt'), i(0)},
			{delimiters = '<>'}
		),
		{condition = line_begin, show_condition = line_begin}
	),

	autosnippet(
		{trig = 'table', name = 'table environment', hidden = true},
		fmt([[
		\begin{table}[<>]
			\centering
			\caption{<>}
			\label{tab:<>}
			\begin{tabular}{<>}
				<>
			\end{tabular}
		\end{table}
		]],
			{i(1, '!ht'), i(2, 'Caption'), i(3, 'label'), i(4), i(0)},
			{delimiters = '<>'}
		),
		{condition = line_begin, show_condition = line_begin}
	),

	autosnippet(
		{trig = 'fig', name = 'Figure environment', hidden = true},
		fmt([[
		\begin{figure}[<>]
			\centering
			\includegraphics[width=<>\textwidth]{figures/<>}
			\caption{<>}
			\label{fig:<>}
		\end{figure}
		]],
			{i(1, '!ht'), i(2, '0.8'), i(3), i(4, 'Caption'), i(5, 'label')},
			{delimiters = '<>'}
		),
		{condition = line_begin, show_condition = line_begin}
	),

	autosnippet(
		{trig = 'pgf', name = 'Figure environment (pgf)', hidden = true},
		fmt([[
		\begin{figure}[<>]
			\centering
			\resizebox{<>\textwidth}{!}{\input{figures/<>}}
			\caption{<>}
			\label{fig:<>}
		\end{figure}
		]],
			{i(1, '!ht'), i(2, '0.7'), i(3), i(4, 'Caption'), i(5, 'label')},
			{delimiters = '<>'}
		),
		{condition = line_begin, show_condition = line_begin}
	),

	autosnippet(
		{trig = 'enum', name = 'enumerate environment', hidden = true},
		fmt([[
		\begin{enumerate}
			\item <>
		\end{enumerate}
		]],
			{i(0)},
			{delimiters = '<>'}
		),
		{condition = line_begin, show_condition = line_begin}
	),

	autosnippet(
		{trig = 'item', name = 'itemize environment', hidden = true},
		fmt([[
		\begin{itemize}
			\item <>
		\end{itemize}
		]],
			{i(0)},
			{delimiters = '<>'}
		),
		{condition = line_begin, show_condition = line_begin}
	),

	autosnippet(
		{trig = 'maboxed', name = 'Multiple aboxed', hidden = true},
		fmt([[
		\begin{empheq}[box=\fbox]{align*}
			<>
		\end{empheq}
		]],
			{i(0)},
			{delimiters = '<>'}
		),
		{condition = line_begin, show_condition = line_begin}
	),

	autosnippet(
		{trig = 'mm', name = 'Math mode', hidden = true},
		fmt([[\(<>\)]], {i(1)}, {delimiters = '<>'}),
		{condition = not_math, show_condition = not_math}
	),

	autosnippet(
		{trig = 'mdm', name = 'Math mode (display style)', hidden = true},
		fmt([[\(\displaystyle <>\)]], {i(1)}, {delimiters = '<>'}),
		{condition = not_math, show_condition = not_math}
	),

	autosnippet(
		{trig = 'dm', name = 'Display math mode', hidden = true},
		fmt('\\[<>\\]', {i(1)}, {delimiters = '<>'}),
		{condition = not_math, show_condition = not_math}
	),

	autosnippet(
		{trig = '=>', name = 'implies', hidden = true},
		t([[\implies]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'iff', name = 'if and only if', hidden = true},
		t([[\iff]]),
		{condition = is_math_env, show_condition = is_math_env}
	),


	autosnippet(
		{trig = 'align', name = 'align* environment', hidden = true},
		fmt([[
		\begin{align*}
			<>
		\end{align*}
		]], {i(1)}, {delimiters = '<>'}),
		{condition = not_math, show_condition = not_math}
	),

	autosnippet(
		{trig = '//', name = 'fraction', hidden = true},
		fmt([[\frac{<>}{<>}<>]], {i(1), i(2), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = [[([%w\_^]+)/]], name = 'fraction', regTrig = true, hidden = true},
		d(1, function(_, snip)
			return sn(2, fmt('\\frac{' .. snip.captures[1] .. '}{<>}<>', {i(1), i(0)}, {delimiters = '<>'}))
		end, nil),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '^^', name = 'superscript', wordTrig = false, hidden = true},
		fmt([[^{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'td', name = 'superscript', wordTrig = false, hidden = true},
		fmt([[^{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	-- autosnippet(
	-- 	{trig = [[([%w\_]+)^]], name = 'superscript', regTrig = true, hidden = true},
	-- 	d(1, function(_, snip)
	-- 		return sn(2, fmt(snip.captures[1] .. '^{<>}<>', {i(1), i(0)}, {delimiters = '<>'}))
	-- 	end, nil),
	-- 	{condition = is_math_env, show_condition = is_math_env}
	-- ),

	autosnippet(
		{trig = '__', name = 'subscript', wordTrig = false, hidden = true},
		fmt([[_{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{}
	),

	-- autosnippet(
	-- 	{trig = [[([%w\]+)_]], name = 'subscript', regTrig = true, hidden = true},
	-- 	d(1, function(_, snip)
	-- 		return sn(2, fmt(snip.captures[1] .. '_{<>}<>', {i(1), i(0)}, {delimiters = '<>'}))
	-- 	end, nil),
	-- 	{condition = is_math_env, show_condition = is_math_env}
	-- ),

	autosnippet(
		{trig = [[([%a\]+)(%d)]], name = 'subscript', regTrig = true, wordTrig = false, hidden = true},
		d(1, function(_, snip)
			return sn(2, fmt(snip.captures[1] .. '_{' .. snip.captures[2] .. '<>}<>', {i(1), i(0)}, {delimiters = '<>'}))
		end, nil),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '==', name = 'equals', hidden = true},
		fmt([[&= <> \\]], {i(1)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '!=', name = 'not equal to', hidden = true},
		t([[\neq]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'ceil', name = 'ceil', hidden = true},
		fmt([[\left\lceil <> \right\rceil<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '([abcmp])mat', name = 'matrix', regTrig = true, hidden = true},
		fmt([[\begin{<>matrix} <> \end{<>matrix}<>]],
			{f(function(_, snip) return snip.captures[1] end), i(1), f(function(_, snip) return snip.captures[1] end), i(0)},
			{delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '()', name = 'quantity ()', hidden = true},
		fmt([[\qty(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '[]', name = 'quantity []', hidden = true},
		fmt([[\qty[<>]<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'abs', name = 'absolute value', hidden = true},
		fmt([[\abs{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'conj', name = 'conjugate', wordTrig = false, hidden = true},
		t([[^{*}]]), {condition = is_math_env, show_condition = is_math_env}),

	autosnippet(
		{trig = 'dint', name = 'definite integral', hidden = true},
		fmt([[\int_{<>}^{<>} <>]], {i(1, [[-\infty]]), i(2, [[\infty]]), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'lint', name = 'line integral', hidden = true},
		fmt([[\int_{<>} <>]], {i(1, [[\va*{\gamma}]]), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'cint', name = 'closed contour integral', hidden = true},
		fmt([[\oint\limits_{<>} <>]], {i(1, [[\va*{\gamma}]]), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '2cint', name = 'closed surface integral', hidden = true},
		fmt([[\oiint\limits_{<>} <>]], {i(1, [[\Sigma]]), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'iint', name = 'indefinite integral', hidden = true},
		fmt([[\int <>]], {i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '([234])int', name = 'multiple integral', regTrig = true, hidden = true},
		fmt([[\<>nt\limits_{<>} <>]], {f(function(_, snip)
			return string.rep('i', snip.captures[1] + 0)
		end), i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'sum', name = 'sum', hidden = true},
		fmt([[\sum_{<>}^{<>} <>]], {i(1, 'n=0'), i(2, '\\infty'), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'lim', name = 'limit', hidden = true},
		fmt([[\lim_{<> \to <>}<>]], {i(1, 'n'), i(2, '\\infty'), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'prod', name = 'product', hidden = true},
		fmt([[\prod_{<>}^{<>} <>]], {i(1, 'n=1'), i(2, '\\infty'), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '(%d*)dd(%a)', name = 'derivative', regTrig = true, hidden = true},
		d(1, function(_, snip)
			local order = ''
			if snip.captures[1] ~= '' then order = '[' .. snip.captures[1] .. ']' end
			-- vim.pretty_print(snip.captures)
			vim.pretty_print(order)
			return sn(1, fmt('\\dv' .. order .. '{<>}{<>}<>', {i(1), i(2, snip.captures[2]), i(0)}, {delimiters = '<>'}))
		end, nil),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = [[([23]?)([%a\]*[a-tv-zA-Z])dot]], name = 'time derivative', regTrig = true, hidden = true},
		d(1, function(_, snip)
			local dots = 'd'
			if snip.captures[1] ~= '' then dots = string.rep('d', tonumber(snip.captures[1]) + 0) end
			return sn(1, fmt('\\' .. dots .. 'ot{<>}<>', {i(1, snip.captures[2]), i(0)}, {delimiters = '<>'}))
		end, nil),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'udot', name = 'dot', hidden = true},
		fmt([[\dot{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '2udot', name = 'ddot', hidden = true},
		fmt([[\ddot{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '3udot', name = 'dddot', hidden = true},
		fmt([[\dddot{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = "'", name = 'prime', wordTrig = false, hidden = true},
		t([[^\prime]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'dp', name = 'double prime', wordTrig = false, hidden = true},
		t([[^{\prime\prime}]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'tp', name = 'triple prime', wordTrig = false, hidden = true},
		t([[^{\prime\prime\prime}]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '(%d*)die', name = 'partial derivative', regTrig = true, hidden = true},
		d(1, function(_, snip)
			local order = ''
			if snip.captures[1] ~= '' then order = '[' .. snip.captures[1] .. ']' end
			return sn(1, fmt('\\pdv' .. order .. '{<>}{<>}<>', {i(1), i(2), i(0)}, {delimiters = '<>'}))
		end, nil),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'sq', name = 'square root', wordTrig = false, hidden = true},
		fmt([[\sqrt{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'sr', name = 'squared', wordTrig = false, hidden = true},
		t([[^2]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'cb', name = 'cubed', wordTrig = false, hidden = true},
		t([[^3]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'ooo', name = 'infinity', wordTrig = false, hidden = true},
		t([[\infty]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '<=', name = 'leq', wordTrig = false, hidden = true},
		t([[\le ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '>=', name = 'geq', wordTrig = false, hidden = true},
		t([[\ge ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'EE', name = 'there exists', wordTrig = false, hidden = true},
		t([[\ \exists\ ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'AA', name = 'for all', wordTrig = false, hidden = true},
		t([[\ \forall\ ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	snippet(
		{trig = 'plot', name = 'plot', hidden = true},
		fmt([[
		\begin{figure}[<>]
			\centering
			\begin{tikzpicture}
				\begin{axis}[
					axis lines = middle,
					axis lines = middle,
					smooth,
					xlabel = \(x\),
					ylabel = \(y\),
					minor tick num = 1,
					grid = both,
					unit vector ratio* = 1 1,
					enlargelimits = true
				]
					\addplot[
						domain=<>:<>,
						samples=<>
					]
					{<>};
				\end{axis}
			\end{tikzpicture}
			\caption{}
			\label{}
		\end{figure}
		]], {i(1), i(2), i(3), i(4, '100'), i(5)}, {delimiters = '<>'}),
		{}
	),

	autosnippet(
		{trig = 'mcal', name = 'mathcal', wordTrig = false, hidden = true},
		fmt([[\mathcal{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'mbb', name = 'mathbb', wordTrig = false, hidden = true},
		fmt([[\mathbb{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'lll', name = 'l', wordTrig = false, hidden = true},
		t([[\ell]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'nab', name = 'nabla', wordTrig = false, hidden = true},
		t([[\nabla]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'grad', name = 'gradient', wordTrig = false, hidden = true},
		fmt([[\grad{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'div', name = 'divergence', wordTrig = false, hidden = true},
		fmt([[\div{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'curl', name = 'curl', wordTrig = false, hidden = true},
		fmt([[\curl{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'xx', name = 'cross', wordTrig = false, hidden = true},
		t([[\times ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '*', name = 'cdot', wordTrig = false, hidden = true},
		t([[\cdot ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'ast', name = 'asterisk', wordTrig = false, hidden = true},
		t([[*]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'norm', name = 'norm', wordTrig = false, hidden = true},
		fmt([[\norm{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'sin', name = 'sin', wordTrig = false, hidden = true},
		fmt([[\sin(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'arcsin', name = 'arcsin', wordTrig = false, hidden = true},
		fmt([[\arcsin(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'cos', name = 'cos', wordTrig = false, hidden = true},
		fmt([[\cos(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'arccos', name = 'arccos', wordTrig = false, hidden = true},
		fmt([[\arccos(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'tan', name = 'tan', wordTrig = false, hidden = true},
		fmt([[\tan(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'arctan', name = 'arctan', wordTrig = false, hidden = true},
		fmt([[\tan(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),


	autosnippet(
		{trig = 'cot', name = 'cot', wordTrig = false, hidden = true},
		fmt([[\cot(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'sec', name = 'sec', wordTrig = false, hidden = true},
		fmt([[\sec(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'csc', name = 'csc', wordTrig = false, hidden = true},
		fmt([[\csc(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'ln', name = 'ln', wordTrig = false, hidden = true},
		fmt([[\ln(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'exp', name = 'exp', wordTrig = false, hidden = true},
		fmt([[\exp(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'log', name = 'log', wordTrig = false, hidden = true},
		fmt([[\log(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '->', name = 'to', wordTrig = false, hidden = true},
		t([[\to ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ':>', name = 'maps to', wordTrig = false, hidden = true},
		t([[\mapsto ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'inv', name = 'inverse', wordTrig = false, hidden = true},
		t([[^{-1}]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '>>', name = 'much greater than', wordTrig = false, hidden = true},
		t([[\gg ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '<<', name = 'much less than', wordTrig = false, hidden = true},
		t([[\ll ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '~~', name = 'similar', wordTrig = false, hidden = true},
		t([[\sim ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'set', name = 'set', wordTrig = false, hidden = true},
		fmt([[\left\{<>\right\}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'pois', name = 'Poisson bracket', wordTrig = false, hidden = true},
		fmt([[\left\{<>\right\}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '||', name = 'such that', wordTrig = false, hidden = true},
		t([[ \, \middle|\, ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'notin', name = 'not in', wordTrig = false, hidden = true},
		t([[\not\in ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'inn', name = 'in', wordTrig = false, hidden = true},
		t([[\in ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'RR', name = 'real', wordTrig = false, hidden = true},
		t([[\mathbb{R}]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'CC', name = 'complex', wordTrig = false, hidden = true},
		t([[\mathbb{C}]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'QQ', name = 'rational', wordTrig = false, hidden = true},
		t([[\mathbb{Q}]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'ZZ', name = 'integer', wordTrig = false, hidden = true},
		t([[\mathbb{Z}]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'OO', name = 'order', wordTrig = false, hidden = true},
		fmt([[\order{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'tt', name = 'text', wordTrig = false, hidden = true},
		fmt([[\text{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'case', name = 'cases', wordTrig = false, hidden = true},
		fmt([[
		\begin{dcases}
			<>
		\end{dcases}
		]], {i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'SI', name = 'SI', wordTrig = false, hidden = true},
		fmt([[\SI{<>}{<>}<>]], {i(1), i(2), i(0)}, {delimiters = '<>'}),
		{}
	),

	autosnippet(
		{trig = [[([%a\]*)bar]], name = 'bar', regTrig = true, wordTrig = false, hidden = true},
		d(1, function(_, snip)
			return sn(1, fmt('\\overline{<>}<>', {i(1, snip.captures[1]), i(0)}, {delimiters = '<>'}))
		end, nil),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = [[([ij])hat]], name = 'hat', regTrig = true, wordTrig = false, hidden = true},
		d(1, function(_, snip)
			return sn(1, fmt('\\vu*{<>}<>', {i(1, '\\' .. snip.captures[1] .. 'math'), i(0)}, {delimiters = '<>'}))
		end, nil),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = [[([%a\]*)hat]], name = 'hat', regTrig = true, wordTrig = false, hidden = true},
		d(1, function(_, snip)
			return sn(1, fmt('\\vu*{<>}<>', {i(1, snip.captures[1]), i(0)}, {delimiters = '<>'}))
		end, nil),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'let', name = 'let', wordTrig = false, hidden = true},
		t([[\text{Let }]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'mini', name = 'minipage', wordTrig = false, hidden = true},
		fmt([[
		\begin{minipage}[t]{<>\textwidth}
			<>
		\end{minipage}%
		]], {i(1, '0.45'), i(0)}, {delimiters = '<>'}),
		{condition = not_math, show_condition = not_math}
	),

	autosnippet(
		{trig = 'bend', name = 'begin/end', wordTrig = false, hidden = true},
		fmt([[
		\begin{<>}
			<>
		\end{<>}
		]], {i(1), i(0), rep(1)}, {delimiters = '<>'}),
		{condition = not_math, show_condition = not_math}
	),

	autosnippet(
		{trig = ',a', name = 'alpha', wordTrig = false, hidden = true},
		t([[\alpha]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',a', name = 'Alpha', wordTrig = false, hidden = true},
		t([[\Alpha]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',b', name = 'beta', wordTrig = false, hidden = true},
		t([[\beta]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',g', name = 'gamma', wordTrig = false, hidden = true},
		t([[\gamma]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',G', name = 'Gamma', wordTrig = false, hidden = true},
		t([[\Gamma]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',d', name = 'delta', wordTrig = false, hidden = true},
		t([[\delta]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',D', name = 'Delta', wordTrig = false, hidden = true},
		t([[\Delta ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',e', name = 'epsilon', wordTrig = false, hidden = true},
		t([[\varepsilon]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',z', name = 'zeta', wordTrig = false, hidden = true},
		t([[\zeta]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',n', name = 'eta', wordTrig = false, hidden = true},
		t([[\eta]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',t', name = 'theta', wordTrig = false, hidden = true},
		t([[\theta]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',T', name = 'tau', wordTrig = false, hidden = true},
		t([[\tau]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',i', name = 'iota', wordTrig = false, hidden = true},
		t([[\iota]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',k', name = 'kappa', wordTrig = false, hidden = true},
		t([[\kappa]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',k', name = 'Kappa', wordTrig = false, hidden = true},
		t([[\Kappa]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',l', name = 'lambda', wordTrig = false, hidden = true},
		t([[\lambda]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',L', name = 'Lambda', wordTrig = false, hidden = true},
		t([[\Lambda]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',m', name = 'mu', wordTrig = false, hidden = true},
		t([[\mu]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',v', name = 'nu', wordTrig = false, hidden = true},
		t([[\nu]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',x', name = 'xi', wordTrig = false, hidden = true},
		t([[\xi]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',X', name = 'Xi', wordTrig = false, hidden = true},
		t([[\Xi]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',a', name = 'alpha', wordTrig = false, hidden = true},
		t([[\alpha]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',p', name = 'pi', wordTrig = false, hidden = true},
		t([[\pi]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',P', name = 'Pi', wordTrig = false, hidden = true},
		t([[\Pi]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',r', name = 'rho', wordTrig = false, hidden = true},
		t([[\rho]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',s', name = 'sigma', wordTrig = false, hidden = true},
		t([[\sigma]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',S', name = 'Sigma', wordTrig = false, hidden = true},
		t([[\Sigma]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',u', name = 'upsilon', wordTrig = false, hidden = true},
		t([[\upsilon]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',U', name = 'Upsilon', wordTrig = false, hidden = true},
		t([[\Upsilon]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'fi', name = 'phi angle', wordTrig = false, hidden = true},
		t([[\phi]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'Fi', name = 'Phi angle', wordTrig = false, hidden = true},
		t([[\Phi]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',f', name = 'phi', wordTrig = false, hidden = true},
		t([[\varphi]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',F', name = 'Phi angle', wordTrig = false, hidden = true},
		t([[\Phi]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',c', name = 'chi', wordTrig = false, hidden = true},
		t([[\chi]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',y', name = 'psi', wordTrig = false, hidden = true},
		t([[\psi]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',Y', name = 'Psi', wordTrig = false, hidden = true},
		t([[\Psi]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',w', name = 'omega', wordTrig = false, hidden = true},
		t([[\omega]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',W', name = 'Omega', wordTrig = false, hidden = true},
		t([[\Omega]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',o', name = 'omega', wordTrig = false, hidden = true},
		t([[\omega]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',O', name = 'Omega', wordTrig = false, hidden = true},
		t([[\Omega]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = ',h', name = 'hbar', wordTrig = false, hidden = true},
		t([[\hbar]]),
		{condition = is_math_env, show_condition = is_math_env}
	),
	autosnippet(
		{trig = 'qed', name = 'blacksquare', wordTrig = false, hidden = true},
		t([[\ \blacksquare]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'vec', name = 'vector', wordTrig = false, hidden = true},
		fmt([[\va*{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'lr', name = 'left/right', wordTrig = false, hidden = true},
		fmt([[\left<><>\right<><>]], {i(1), i(3), i(2), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'avg', name = 'bracket average', wordTrig = false, hidden = true},
		fmt([[\expval{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'trans', name = 'transpose', wordTrig = false, hidden = true},
		t([[^\top ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'lapt', name = 'Laplace transform', wordTrig = false, hidden = true},
		fmt([[\mathcal{L}\left\{<>\right\}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'lapn', name = 'inverse Laplace transform', wordTrig = false, hidden = true},
		fmt([[\mathcal{L}^{-1}\left\{<>\right\}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'fourt', name = 'Fourier transform', wordTrig = false, hidden = true},
		fmt([[\mathcal{F}\left\{<>\right\}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'fourn', name = 'inverse Fourier transform', wordTrig = false, hidden = true},
		fmt([[\mathcal{F}^{-1}\left\{<>\right\}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'lab', name = 'ln of abs', wordTrig = false, hidden = true},
		fmt([[\ln\abs{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'comm', name = 'commutator', wordTrig = false, hidden = true},
		fmt([[\comm{<>}{<>}<>]], {i(1), i(2), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'bra', name = 'bra', wordTrig = false, hidden = true},
		fmt([[\bra{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'ket', name = 'ket', wordTrig = false, hidden = true},
		fmt([[\ket{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'dag', name = 'dagger', wordTrig = false, hidden = true},
		t([[^\dagger]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'pre', name = 'prescript', wordTrig = false, hidden = true},
		fmt([[\prescript{<>}{<>}{<>}<>]], {i(1), i(2), i(3), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'binom', name = 'binomial coefficient', wordTrig = false, hidden = true},
		fmt([[\binom{<>}{<>}<>]], {i(1), i(2), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'eqn', name = 'equation label', wordTrig = false, hidden = true},
		fmt([[\stepcounter{equation}\tag{\theequation}\label{eq:<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'nonum', name = 'No equation label', wordTrig = false, hidden = true},
		t([[\nonumber]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'lapl', name = 'laplacian', wordTrig = false, hidden = true},
		fmt([[\laplacian{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'ev', name = 'expectation value', wordTrig = false, hidden = true},
		fmt([[\ev{<>}{<>}<>]], {i(1), i(2), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'mel', name = 'matrix element', wordTrig = false, hidden = true},
		fmt([[\mel{<>}{<>}{<>}<>]], {i(1), i(2), i(3), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = [[([%a\]*)op]], name = 'operator', regTrig = true, hidden = true},
		d(1, function(_, snip)
			return sn(1, fmt('\\hat{<>}<>', {i(1, snip.captures[1]), i(0)}, {delimiters = '<>'}))
		end, nil),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '_%^', name = 'eval', regTrig = true, hidden = true},
		fmt([[\eval{<>}_{<>}^{<>}<>]], {i(3), i(1), i(2), i(0)}, {delimiters = '<>'}),
		{}
	),

	autosnippet(
		{trig = [[([%a\]*)tild]], name = 'tilde', regTrig = true, hidden = true},
		d(1, function(_, snip)
			return sn(1, fmt('\\tilde{<>}<>', {i(1, snip.captures[1]), i(0)}, {delimiters = '<>'}))
		end, nil),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'Re', name = 'real', wordTrig = false, hidden = true},
		fmt([[\text{Re}\left\{<>\right\}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'Im', name = 'imaginary', wordTrig = false, hidden = true},
		fmt([[\text{Im}\left\{<>\right\}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'Tr', name = 'trace', wordTrig = false, hidden = true},
		fmt([[\text{Tr}\qty(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'sgn', name = 'signum', wordTrig = false, hidden = true},
		fmt([[\text{sgn}\qty(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'hrule', name = 'line', wordTrig = false, hidden = true},
		fmt([[\rule{<>\textwidth}{<>pt}<>]], {i(1, '0.9'), i(2, '0.4'), i(0)}, {delimiters = '<>'}),
		{condition = not_math, show_condition = not_math}
	),

	autosnippet(
		{trig = 'vspc', name = 'vspace baselineskip', wordTrig = false, hidden = true},
		t([[\vspace{\baselineskip}]]),
		{condition = not_math, show_condition = not_math}
	),

	autosnippet(
		{trig = 'one', name = 'identity matrix', wordTrig = false, hidden = true},
		t([[\mathbbm{1}]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'tens', name = 'tensor product', wordTrig = false, hidden = true},
		t([[\otimes]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '()', name = 'parentheses', wordTrig = false, hidden = true},
		fmt([[\qty(<>)<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = '[]', name = 'square brackets', wordTrig = false, hidden = true},
		fmt([[\qty[<>]<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'ind', name = 'indices', wordTrig = false, hidden = true},
		fmt([[\indices{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'par', name = 'partial', wordTrig = false, hidden = true},
		t([[\partial]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'msf', name = 'mathsf', wordTrig = false, hidden = true},
		fmt([[\mathsf{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'dee', name = 'differential', wordTrig = false, hidden = true},
		fmt([[\dd{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'mring', name = 'math ring', wordTrig = true, hidden = true},
		fmt([[\mathring{<>}<>]], {i(1), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'star', name = 'Star', wordTrig = false, hidden = true},
		t([[\star ]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'pi', name = 'pi', wordTrig = false, hidden = true},
		t([[\pi]]),
		{condition = is_math_env, show_condition = is_math_env}
	),
}
