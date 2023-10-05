return {
  s(
    "fif",
    fmt(
      [[
  <f:if condition="{()}">
      ()
  </f:if>
  ]],
      { i(1), i(2) },
      { delimiters = "()" }
    )
  ),
  s(
    "fift",
    fmt(
      [[
  <f:if condition="{()}">
    <f:then>
      ()
    </f:then>
    <f:else>
      ()
    </f:else>
  </f:if>
  ]],
      { i(1), i(2), i(3) },
      { delimiters = "()" }
    )
  ),
  s("fdb", fmt("<f:debug>{()}</f:debug>", { i(1) }, { delimiters = "()" })),
  s(
    "fimg",
    fmt(
      [[
  <f:image
    image="{()}"
    title="{()}"
    alt="{()}"
    width="()"
  />
  ]],
      { i(1), i(2), i(3), i(4) },
      { delimiters = "()" }
    )
  ),
}
