IEx.configure(
  colors: [
    syntax_colors: [
      number: [:light_yellow, :bright],
      atom: :light_cyan,
      string: :light_blue,
      boolean: :red,
      nil: [:magenta, :bright]
    ],
    ls_directory: :cyan,
    ls_device: :yellow,
    doc_code: :green,
    doc_inline_code: :magenta,
    doc_headings: [:light_blue, :underline],
    doc_title: [:light_blue_background, :black, :bright]
  ],
  default_prompt:
    "#{IO.ANSI.color(5, 2, 0)}λ#{IO.ANSI.reset()} " <>
      "#{IO.ANSI.green()}(%counter)#{IO.ANSI.reset()}" <>
      "#{IO.ANSI.color(5, 2, 0)}>#{IO.ANSI.reset()}",
  alive_prompt:
    "#{IO.ANSI.color(5, 2, 0)}λ#{IO.ANSI.reset()} " <>
      "(#{IO.ANSI.cyan()}[%node]#{IO.ANSI.reset()}) " <>
      "#{IO.ANSI.green()}(%counter)#{IO.ANSI.reset()}" <>
      "#{IO.ANSI.color(5, 2, 0)}>#{IO.ANSI.reset()}",
  history_size: 50,
  inspect: [
    pretty: true,
    limit: :infinity,
    width: 80
  ],
  width: 80
)
