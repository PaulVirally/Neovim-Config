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
			{i(1, 'h!'), i(2, 'Caption'), i(3, 'label'), i(4), i(0)},
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
			{i(1, 'h!'), i(2, '0.8'), i(3), i(4, 'Caption'), i(5, 'label')},
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
			{i(1, 'h!'), i(2, '0.7'), i(3), i(4, 'Caption'), i(5, 'label')},
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
		{trig = '<=', name = 'implied by', hidden = true},
		t([[\impliedby]]),
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
	), -- TODO auto fractions and auto subscripts

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
		{trig = 'conj', name = 'conjugate', hidden = true},
		t([[^{*}]]),
		{condition = is_math_env, show_condition = is_math_env}
	),

	autosnippet(
		{trig = 'dint', name = 'definite integral', hidden = true},
		fmt([[\int_{<>}^{<>} <>]], {i(1), i(2), i(0)}, {delimiters = '<>'}),
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
		end), d(1, function(_, snip)
				local cap = snip.captures[1]
				local default_text = ''
				if cap == '2' then default_text = 'S' end
				if cap == '3' then default_text = 'V' end
				return sn(1, {i(1, default_text)})
		end, {1}), i(0)}, {delimiters = '<>'}),
		{condition = is_math_env, show_condition = is_math_env}
	),

	-- autosnippet(
	-- 	{trig = '', name = '', hidden = true},
	-- 	t([[]]),
	-- 	{condition = is_math_env, show_condition = is_math_env}
	-- ),

	-- autosnippet(
	-- 	{trig = '', name = '', hidden = true},
	-- 	t([[]]),
	-- 	{condition = is_math_env, show_condition = is_math_env}
	-- ),

	-- autosnippet(
	-- 	{trig = '', name = '', hidden = true},
	-- 	t([[]]),
	-- 	{condition = is_math_env, show_condition = is_math_env}
	-- ),

	-- autosnippet(
	-- 	{trig = '', name = '', hidden = true},
	-- 	t([[]]),
	-- 	{condition = is_math_env, show_condition = is_math_env}
	-- ),

	-- autosnippet(
	-- 	{trig = '', name = '', hidden = true},
	-- 	t([[]]),
	-- 	{condition = is_math_env, show_condition = is_math_env}
	-- ),

	-- autosnippet(
	-- 	{trig = '', name = '', hidden = true},
	-- 	t([[]]),
	-- 	{condition = is_math_env, show_condition = is_math_env}
	-- ),

}
